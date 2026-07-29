<?php

namespace App\Http\Controllers\Sekolah;

use App\Http\Controllers\Controller;
use App\Models\Kontingen;
use App\Models\LombaKontingen;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class AlokasiController extends Controller
{
    private const MAX_SISWA = 10;

    private function pangkalan(Request $request)
    {
        return $request->user()->ownedTeams()->first();
    }

    /** Gerbang: kontingen milik operator + boleh alokasi. */
    private function authorizeKontingen(Request $request, Kontingen $kontingen): void
    {
        $pangkalan = $this->pangkalan($request);

        abort_unless($pangkalan && $kontingen->team_id === $pangkalan->id, 403, 'Kontingen bukan milik pangkalan Anda.');
        abort_unless($kontingen->bolehAlokasi(), 403, 'Alokasi lomba belum dapat dilakukan pada status saat ini.');
    }

    /** Alokasi harus milik kontingen yang sedang dibuka. */
    private function authorizeAlokasi(Request $request, Kontingen $kontingen, LombaKontingen $alokasi): void
    {
        $this->authorizeKontingen($request, $kontingen);
        abort_unless($alokasi->kontingen_id === $kontingen->id, 404);
    }

    /** Lomba yang boleh dipilih = lomba aktif milik event kontingen ini. */
    private function lombaTersedia(Kontingen $kontingen)
    {
        return $kontingen->event->lombas()
            ->where('status', 'aktif')
            ->orderBy('nama')
            ->get(['id', 'nama']);
    }

    /** Siswa yang boleh dicentang = milik kontingen & belum ditolak verifikasi. */
    private function siswaTersedia(Kontingen $kontingen)
    {
        return $kontingen->siswas()
            ->where('status_verifikasi', '!=', 'rejected')
            ->orderBy('nama')
            ->get();
    }

    private function pendampingTersedia(Kontingen $kontingen)
    {
        return $kontingen->pendampings()
            ->where('status_verifikasi', '!=', 'rejected')
            ->orderBy('nama')
            ->get();
    }

    public function index(Request $request, Kontingen $kontingen)
    {
        $this->authorizeKontingen($request, $kontingen);

        $kontingen->load('event');
        $alokasi = LombaKontingen::with(['lomba', 'pendamping', 'siswas'])
            ->where('kontingen_id', $kontingen->id)
            ->orderBy('golongan')
            ->get();

        return inertia('Sekolah/Alokasi/Index', compact('kontingen', 'alokasi'));
    }

    public function create(Request $request, Kontingen $kontingen)
    {
        $this->authorizeKontingen($request, $kontingen);

        return inertia('Sekolah/Alokasi/Form', [
            'kontingen'  => $kontingen,
            'alokasi'    => null,
            'lombas'     => $this->lombaTersedia($kontingen),
            'siswas'     => $this->siswaTersedia($kontingen),
            'pendampings'=> $this->pendampingTersedia($kontingen),
        ]);
    }

    public function store(Request $request, Kontingen $kontingen)
    {
        $this->authorizeKontingen($request, $kontingen);
        $data = $this->validateAlokasi($request, $kontingen);

        $alokasi = LombaKontingen::create([
            'lomba_id'     => $data['lomba_id'],
            'kontingen_id' => $kontingen->id,
            'golongan'     => $data['golongan'],
            'pendamping_id'=> $data['pendamping_id'],
            'status'       => 'draft',
        ]);

        $alokasi->siswas()->sync($data['siswa_ids']);

        return redirect()
            ->route('sekolah.alokasi.index', $kontingen)
            ->with('success', 'Alokasi lomba berhasil disimpan.')
            ->setStatusCode(303);
    }

    public function edit(Request $request, Kontingen $kontingen, LombaKontingen $alokasi)
    {
        $this->authorizeAlokasi($request, $kontingen, $alokasi);
        abort_unless($alokasi->status === 'draft' && is_null($alokasi->nomor_urut_tampil), 403, 'Alokasi sudah dikunci oleh Admin.');

        $alokasi->load('siswas');

        return inertia('Sekolah/Alokasi/Form', [
            'kontingen'  => $kontingen,
            'alokasi'    => $alokasi,
            'lombas'     => $this->lombaTersedia($kontingen),
            'siswas'     => $this->siswaTersedia($kontingen),
            'pendampings'=> $this->pendampingTersedia($kontingen),
        ]);
    }

    public function update(Request $request, Kontingen $kontingen, LombaKontingen $alokasi)
    {
        $this->authorizeAlokasi($request, $kontingen, $alokasi);
        abort_unless($alokasi->status === 'draft' && is_null($alokasi->nomor_urut_tampil), 403, 'Alokasi sudah dikunci oleh Admin.');

        $data = $this->validateAlokasi($request, $kontingen, $alokasi->lomba_id);

        $alokasi->update([
            'golongan'      => $data['golongan'],
            'pendamping_id' => $data['pendamping_id'],
        ]);
        $alokasi->siswas()->sync($data['siswa_ids']);

        return redirect()
            ->route('sekolah.alokasi.index', $kontingen)
            ->with('success', 'Alokasi lomba berhasil diupdate.')
            ->setStatusCode(303);
    }

    public function destroy(Request $request, Kontingen $kontingen, LombaKontingen $alokasi)
    {
        $this->authorizeAlokasi($request, $kontingen, $alokasi);
        abort_unless($alokasi->status === 'draft', 403, 'Alokasi sudah dikunci oleh Admin.');

        $alokasi->delete(); // cascade hapus pivot siswa

        return redirect()
            ->route('sekolah.alokasi.index', $kontingen)
            ->with('success', 'Alokasi lomba berhasil dihapus.')
            ->setStatusCode(303);
    }

    /**
     * Validasi inti: batas 10 siswa, 1 pendamping, ownership, golongan punya kriteria.
     */
    private function validateAlokasi(Request $request, Kontingen $kontingen, ?int $currentLombaId = null): array
    {
        $data = $request->validate([
            'lomba_id'      => ['required', Rule::exists('lombas', 'id')],
            'golongan'      => ['required', Rule::in(['siaga', 'penggalang', 'penegak', 'pandega'])],
            'pendamping_id' => ['required', Rule::exists('pendampings', 'id')],
            'siswa_ids'     => ['required', 'array', 'min:1', 'max:' . self::MAX_SISWA],
            'siswa_ids.*'   => ['integer', Rule::exists('siswas', 'id')],
        ]);

        // (1) Lomba harus milik event kontingen ini & aktif
        $lomba = $kontingen->event->lombas()->where('lombas.id', $data['lomba_id'])->where('status', 'aktif')->first();
        abort_unless($lomba, 422, 'Lomba tidak tersedia untuk event ini.');

        // (2) Golongan harus punya kriteria untuk lomba ini (biar juri bisa nilai)
        $adaKriteria = $lomba->kriterias()->where('golongan', $data['golongan'])->where('is_active', true)->exists();
        abort_unless($adaKriteria, 422, "Golongan {$data['golongan']} belum punya kriteria aktif untuk lomba ini.");

        // (3) Semua siswa harus milik kontingen ini & belum ditolak
        $validSiswa = $kontingen->siswas()
            ->whereIn('id', $data['siswa_ids'])
            ->where('status_verifikasi', '!=', 'rejected')
            ->pluck('id')
            ->toArray();
        if (count($validSiswa) !== count(array_unique($data['siswa_ids']))) {
            abort(422, 'Ada siswa yang tidak valid atau sudah ditolak verifikasi.');
        }

        // (4) Pendamping harus milik kontingen ini & belum ditolak
        $pendampingOk = $kontingen->pendampings()
            ->where('id', $data['pendamping_id'])
            ->where('status_verifikasi', '!=', 'rejected')
            ->exists();
        abort_unless($pendampingOk, 422, 'Pendamping tidak valid untuk kontingen ini.');

        // (5) Batas 10 siswa (double check, walau Rule::max udah jaga)
        abort_unless(count($data['siswa_ids']) <= self::MAX_SISWA, 422, 'Maksimal ' . self::MAX_SISWA . ' siswa per alokasi.');

        // (6) Cegah siswa double-booking dalam kontingen yang sama
        $existingSiswa = LombaKontingen::where('kontingen_id', $kontingen->id)
            ->when($currentLombaId, fn ($q) => $q->where('lomba_id', '!=', $currentLombaId))
            ->whereHas('siswas', fn ($q) => $q->whereIn('siswa_id', $data['siswa_ids']))
            ->with(['lomba', 'siswas' => fn ($q) => $q->whereIn('siswa_id', $data['siswa_ids'])])
            ->get();
        if ($existingSiswa->isNotEmpty()) {
            $namaSiswa = $existingSiswa->pluck('siswas')->flatten()->pluck('nama')->unique()->join(', ');
            $namaLomba = $existingSiswa->pluck('lomba.nama')->unique()->join(', ');
            abort(422, "Siswa berikut sudah dialokasikan ke lomba lain ({$namaLomba}): {$namaSiswa}");
        }

        $data['siswa_ids'] = $validSiswa;
        return $data;
    }
}