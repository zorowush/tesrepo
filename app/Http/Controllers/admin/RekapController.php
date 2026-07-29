<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Event;
use App\Models\Juara;
use App\Models\Kontingen;
use App\Models\Lomba;
use App\Models\Penilaian;
use App\Models\PenilaianDetail;
use App\Exports\RekapLombaExport;
use Illuminate\Support\Str;
use Maatwebsite\Excel\Facades\Excel;
use Symfony\Component\HttpFoundation\StreamedResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Spatie\Activitylog\Models\Activity;

class RekapController extends Controller
{
    // ===================== 7A: REKAP PER LOMBA =====================

    public function index(Request $request)
    {
        $events = Event::orderByDesc('id')->get();
        $selectedEventId = $request->query('event_id') ? (int) $request->query('event_id') : null;

        $lombas = collect();
        if ($selectedEventId) {
            Event::findOrFail($selectedEventId);
            $lombas = Lomba::where('event_id', $selectedEventId)
                ->withCount('penilaians')
                ->orderBy('nama')
                ->get();
        }

        return inertia('Admin/Rekap/Index', compact('events', 'lombas', 'selectedEventId'));
    }

    public function show(Lomba $lomba)
    {
        $lomba->load('event');
        $rekap = $this->hitungRekap($lomba);

        $finalized_at      = Juara::where('lomba_id', $lomba->id)->max('updated_at');
        $last_penilaian_at = Penilaian::where('lomba_id', $lomba->id)->max('submitted_at');

        // revisi admin (audit) untuk penilaian di lomba ini
        $penilaianIds = Penilaian::where('lomba_id', $lomba->id)->pluck('id');
        $last_revisi_at = Activity::where('subject_type', (new Penilaian)->getMorphClass())
            ->whereIn('subject_id', $penilaianIds)
            ->max('created_at');

        // perubahan terakhir = max(juri submit, admin revisi)
        $last_change_at = collect([$last_penilaian_at, $last_revisi_at])
            ->filter()->map(fn ($d) => strtotime($d))->max();
        $last_change_at = $last_change_at ? date('Y-m-d H:i:s', $last_change_at) : null;

        return inertia('Admin/Rekap/Show', compact('lomba', 'rekap', 'finalized_at', 'last_change_at'));
    }

    private function hitungRekap(Lomba $lomba): array
    {
        $penilaians = Penilaian::where('lomba_id', $lomba->id)->with('kontingen.team')->get();
        $rekap = [];

        foreach ($penilaians->groupBy('golongan') as $gol => $group) {
            $rows = $group->groupBy('kontingen_id')
                ->map(fn ($g) => [
                    'kontingen_id' => $g->first()->kontingen_id,
                    'team_name'    => $g->first()->kontingen->team->name ?? '-',
                    'nilai_akhir'  => round((float) $g->avg('nilai_akhir_juri'), 2),
                    'jumlah_juri'  => $g->count(),
                ])
                ->values()->sortByDesc('nilai_akhir')->values()
                ->map(fn ($r, $i) => $r + ['rank' => $i + 1])->values()->all();
            $rekap[$gol] = $rows;
        }
        return $rekap;
    }

    public function finalize(Lomba $lomba)
    {
        $rekap  = $this->hitungRekap($lomba);
        $medali = [1 => 'emas', 2 => 'perak', 3 => 'perunggu'];

        DB::transaction(function () use ($lomba, $rekap, $medali) {
            Juara::where('lomba_id', $lomba->id)->delete();
            foreach ($rekap as $gol => $rows) {
                foreach ($rows as $r) {
                    if ($r['rank'] > 3) continue;
                    Juara::create([
                        'event_id' => $lomba->event_id, 'lomba_id' => $lomba->id,
                        'kontingen_id' => $r['kontingen_id'], 'golongan' => $gol,
                        'juara' => $r['rank'], 'medali' => $medali[$r['rank']],
                        'nilai_akhir' => $r['nilai_akhir'], 'is_final' => true,
                    ]);
                }
            }
        });

        event(new \App\Events\JuaraUpdated($lomba->event_id, "Juara \"{$lomba->nama}\" diperbarui"));
    }

    /** Ratakan rekap jadi baris tabel (dipakai Excel & CSV biar konsisten). */
private function flattenRekap(Lomba $lomba): array
{
    $rekap = $this->hitungRekap($lomba); // reuse logika 7A
    $rows = [];
    foreach ($rekap as $gol => $items) {
        foreach ($items as $r) {
            $rows[] = [
                $r['rank'],
                $r['team_name'],
                ucfirst($gol),
                number_format((float) $r['nilai_akhir'], 2, ',', '.'),
                $r['jumlah_juri'],
            ];
        }
    }
    return $rows;
}

/** Export .xlsx (butuh maatwebsite/excel). */
public function exportExcel(Lomba $lomba)
{
    $lomba->load('event');
    $rows = $this->flattenRekap($lomba);

    return Excel::download(
        new RekapLombaExport($rows, $lomba->nama, $lomba->event->nama ?? ''),
        'rekap-' . Str::slug($lomba->nama) . '.xlsx'
    );
}

/** Export .csv — TANPA package (bulletproof, UTF-8 BOM biar Excel baca huruf Indonesia). */
public function exportCsv(Lomba $lomba): StreamedResponse
{
    $lomba->load('event');
    $rows = $this->flattenRekap($lomba);
    $headings = ['Peringkat', 'Pangkalan / Kontingen', 'Golongan', 'Nilai Akhir', 'Jumlah Juri'];
    $filename = 'rekap-' . Str::slug($lomba->nama) . '.csv';

    return response()->streamDownload(function () use ($headings, $rows) {
        $out = fopen('php://output', 'w');
        fwrite($out, "\xEF\xBB\xBF"); // UTF-8 BOM
        fputcsv($out, $headings, ';');
        foreach ($rows as $r) {
            fputcsv($out, $r, ';');
        }
        fclose($out);
    }, $filename, ['Content-Type' => 'text/csv; charset=UTF-8']);
}

    // ===================== 7B-1: JUARA UMUM =====================

    public function juaraUmum(Request $request)
    {
        $events = Event::orderByDesc('id')->get();
        $selectedEventId = $request->query('event_id') ? (int) $request->query('event_id') : null;

        $ranking = []; $totalMedal = ['emas' => 0, 'perak' => 0, 'perunggu' => 0]; $lombaDinilai = 0;

        if ($selectedEventId) {
            $event = Event::findOrFail($selectedEventId);
            $juaras = Juara::where('event_id', $event->id)->where('is_final', true)
                ->with(['kontingen.team', 'lomba'])->get();
            $lombaDinilai = $juaras->pluck('lomba_id')->unique()->count();
            $bobot = ['emas' => 3, 'perak' => 2, 'perunggu' => 1];

            $rows = $juaras->groupBy('kontingen_id')->map(function ($g) use ($bobot) {
                $emas = $g->where('medali', 'emas')->count();
                $perak = $g->where('medali', 'perak')->count();
                $perunggu = $g->where('medali', 'perunggu')->count();
                return [
                    'kontingen_id' => $g->first()->kontingen_id,
                    'team_name'    => $g->first()->kontingen->team->name ?? '-',
                    'jenjang'      => $g->first()->kontingen->team->jenjang ?? null,
                    'emas' => $emas, 'perak' => $perak, 'perunggu' => $perunggu,
                    'poin' => ($emas * $bobot['emas']) + ($perak * $bobot['perak']) + ($perunggu * $bobot['perunggu']),
                    'details' => $g->map(fn ($j) => [
                        'lomba_nama' => $j->lomba->nama ?? '-', 'golongan' => $j->golongan,
                        'medali' => $j->medali, 'nilai' => $j->nilai_akhir,
                    ])->values()->all(),
                ];
            });

            foreach ($rows as $r) {
                $totalMedal['emas'] += $r['emas']; $totalMedal['perak'] += $r['perak']; $totalMedal['perunggu'] += $r['perunggu'];
            }

            $arr = $rows->values()->all();
            usort($arr, fn ($a, $b) =>
                [$b['poin'], $b['emas'], $b['perak'], $a['kontingen_id']] <=> [$a['poin'], $a['emas'], $a['perak'], $b['kontingen_id']]);
            $ranking = collect($arr)->map(fn ($r, $i) => $r + ['rank' => $i + 1])->values()->all();
        }

        return inertia('Admin/Rekap/JuaraUmum', compact('events', 'selectedEventId', 'ranking', 'totalMedal', 'lombaDinilai'));
    }

    // ===================== 7B-2 + 7B-3: EDIT NILAI + AUDIT =====================

    /**
     * Meja revisi: semua juri yang menilai regu (lomba+kontingen+golongan),
     * lengkap dengan nilai per komponen + riwayat audit.
     */
    public function editNilai(Lomba $lomba, Kontingen $kontingen, string $golongan)
    {
        $lomba->load('event');

        abort_unless($kontingen->event_id === $lomba->event_id, 404);

        // komponen aktif lomba+golongan (urutan tampil)
        $kriterias = $lomba->kriterias()
            ->where('is_active', true)->where('golongan', $golongan)
            ->orderBy('urutan')->get(['id', 'nama_komponen', 'urutan']);

        // tiap penilaian = 1 juri untuk regu ini
        $penilaians = Penilaian::where('lomba_id', $lomba->id)
            ->where('kontingen_id', $kontingen->id)
            ->where('golongan', $golongan)
            ->with(['juri', 'details'])
            ->orderBy('nomor_urut_tampil')
            ->get()
            ->map(fn ($p) => [
                'id'         => $p->id,
                'juri_name'  => $p->juri->name ?? '-',
                'juri_email' => $p->juri->email ?? null,
                'nilai_akhir_juri' => $p->nilai_akhir_juri,
                'submitted_at' => optional($p->submitted_at)->format('d M Y H:i'),
                'is_locked'  => $p->is_locked,
                'nilai'      => $p->details->pluck('nilai', 'kriteria_komponen_id'),
            ]);

        // timeline audit untuk semua penilaian regu ini
        $ids = $penilaians->pluck('id');
        $audit = Activity::where('subject_type', (new Penilaian)->getMorphClass())
            ->whereIn('subject_id', $ids)
            ->with('causer')
            ->latest()->limit(50)->get()
            ->map(fn ($a) => [
                'who'  => $a->causer->name ?? 'Sistem',
                'when' => $a->created_at->format('d M Y H:i'),
                'desc' => $a->description,
                'props'=> $a->properties ? $a->properties->toArray() : [],
            ]);

        return inertia('Admin/Rekap/EditNilai', compact('lomba', 'kontingen', 'golongan', 'kriterias', 'penilaians', 'audit'));
    }

    /**
     * Revisi nilai satu juri: update details, recalc nilai_akhir_juri, catat audit.
     * Ini SATU-SATUNYA jalan mengubah nilai setelah juri lock.
     */
    public function updateNilai(Request $request, Lomba $lomba, Penilaian $penilaian)
    {
        abort_unless($penilaian->lomba_id === $lomba->id, 404);

        $komponenAktif = $lomba->kriterias()
            ->where('is_active', true)->where('golongan', $penilaian->golongan)
            ->pluck('id')->sort()->values()->all();

        $data = $request->validate([
            'nilai'   => ['required', 'array'],
            'nilai.*' => ['required', 'integer', 'min:1', 'max:100'],
        ]);

        $submittedIds = collect(array_keys($data['nilai']))->map(fn ($x) => (int) $x)->sort()->values()->all();
        abort_unless($submittedIds === $komponenAktif, 422, 'Komponen penilaian tidak lengkap atau tidak cocok.');

        // nilai lama (buat audit + delta)
        $oldMap = $penilaian->details->pluck('nilai', 'kriteria_komponen_id')->toArray();
        $oldAvg = (float) $penilaian->nilai_akhir_juri;

        DB::transaction(function () use ($penilaian, $data) {
            foreach ($data['nilai'] as $kid => $val) {
                PenilaianDetail::updateOrCreate(
                    ['penilaian_id' => $penilaian->id, 'kriteria_komponen_id' => (int) $kid],
                    ['nilai' => (int) $val]
                );
            }
            $newAvg = round(collect($data['nilai'])->avg(), 2);
            $penilaian->update(['nilai_akhir_juri' => $newAvg, 'is_locked' => true]);
        });

        $newAvg = round(collect($data['nilai'])->avg(), 2);

        // AUDIT LOG (7B-3)
        activity()
            ->performedOn($penilaian)
            ->causedBy(Auth::user())
            ->withProperties([
                'old'     => $oldMap,
                'new'     => $data['nilai'],
                'old_avg' => $oldAvg,
                'new_avg' => $newAvg,
                'juri_id' => $penilaian->juri_id,
            ])
            ->log('revisi-nilai');

        return back()
            ->with('success', "Nilai juri direvisi: {$oldAvg} → {$newAvg}. Tercatat di audit log.")
            ->setStatusCode(303);
    }
}