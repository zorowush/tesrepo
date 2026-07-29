<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Kontingen;
use App\Models\Pendamping;
use App\Models\Siswa;
use Illuminate\Http\Request;

class VerifikasiController extends Controller
{
    public function index()
    {
        $kontingens = Kontingen::with(['event', 'team'])
            ->whereIn('status', ['menunggu_verifikasi_dokumen', 'verifikasi_ditolak'])
            ->withCount([
                'siswas',
                'siswas as siswa_approved'         => fn ($q) => $q->where('status_verifikasi', 'approved'),
                'pendampings',
                'pendampings as pendamping_approved' => fn ($q) => $q->where('status_verifikasi', 'approved'),
            ])
            ->latest()
            ->get();

        return inertia('Admin/Verifikasi/Index', compact('kontingens'));
    }

    public function show(Kontingen $kontingen)
    {
        $kontingen->load(['event', 'team']);

        // Decorate siswa: SEMUA field + info surat kesehatan + flag has_doc
        $siswas = $kontingen->siswas()
            ->with('media')
            ->orderBy('nama')
            ->get()
            ->map(function ($s) {
                $doc = $s->getFirstMedia('surat_kesehatan');

                return array_merge($s->toArray(), [
                    'has_doc' => (bool) $doc,
                    'surat_kesehatan' => $doc ? [
                        'url'  => $doc->getUrl(),
                        'mime' => $doc->mime_type,
                        'name' => $doc->file_name,
                    ] : null,
                ]);
            });

        $pendampings = $kontingen->pendampings()
            ->orderBy('nama')
            ->get()
            ->map(fn ($p) => array_merge($p->toArray(), [
                'has_doc' => false,
                'surat_kesehatan' => null,
            ]));

        return inertia('Admin/Verifikasi/Show', compact('kontingen', 'siswas', 'pendampings'));
    }

    // ===== SISWA =====
    public function approveSiswa(Siswa $siswa)
    {
        $siswa->update(['status_verifikasi' => 'approved', 'catatan_verifikasi' => null]);
        $siswa->kontingen->segelVerifikasi();

        return back()->with('success', "Siswa \"{$siswa->nama}\" disetujui.")->setStatusCode(303);
    }

    public function rejectSiswa(Request $request, Siswa $siswa)
    {
        $data = $request->validate(['catatan_verifikasi' => ['required', 'string', 'max:1000']]);
        $siswa->update(['status_verifikasi' => 'rejected', 'catatan_verifikasi' => $data['catatan_verifikasi']]);
        $siswa->kontingen->segelVerifikasi();

        return back()->with('success', "Siswa \"{$siswa->nama}\" ditolak.")->setStatusCode(303);
    }

    // ===== PENDAMPING =====
    public function approvePendamping(Pendamping $pendamping)
    {
        $pendamping->update(['status_verifikasi' => 'approved', 'catatan_verifikasi' => null]);
        $pendamping->kontingen->segelVerifikasi();

        return back()->with('success', "Pendamping \"{$pendamping->nama}\" disetujui.")->setStatusCode(303);
    }

    public function rejectPendamping(Request $request, Pendamping $pendamping)
    {
        $data = $request->validate(['catatan_verifikasi' => ['required', 'string', 'max:1000']]);
        $pendamping->update(['status_verifikasi' => 'rejected', 'catatan_verifikasi' => $data['catatan_verifikasi']]);
        $pendamping->kontingen->segelVerifikasi();

        return back()->with('success', "Pendamping \"{$pendamping->nama}\" ditolak.")->setStatusCode(303);
    }
}