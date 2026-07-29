<?php

namespace App\Http\Controllers\Publik;

use App\Http\Controllers\Controller;
use App\Models\Event;
use App\Models\Juara;
use App\Models\Lomba;
use App\Models\Penilaian;
use Carbon\Carbon;

class LandingController extends Controller
{
    public function index()
    {
        // event "utama": yang aktif dulu, kalau nggak ada ambil yang terbaru
        $event = Event::where('status', 'aktif')->latest()->first()
              ?? Event::latest()->first();

        return $this->render($event);
    }

    public function show(Event $event)
    {
        return $this->render($event);
    }

    private function render(?Event $event)
    {
        if (! $event) {
            return inertia('Publik/Landing', [
                'event' => null, 'stats' => null, 'phases' => [],
                'standings' => [], 'leaderboards' => [], 'liveStatus' => null,
            ]);
        }

        return inertia('Publik/Landing', [
            'event'        => $event,
            'liveStatus'   => $this->liveStatus($event),
            'stats'        => $this->stats($event),
            'phases'       => $this->phases($event),
            'standings'    => $this->standings($event),
            'leaderboards' => $this->leaderboards($event),
        ]);
    }

    /** Status "hidup" event berdasarkan tanggal pelaksanaan vs sekarang. */
    private function liveStatus(Event $event): string
    {
        $now = Carbon::now();
        if ($now->lt(Carbon::parse($event->tanggal_pelaksanaan_mulai)->startOfDay())) return 'upcoming';
        if ($now->gt(Carbon::parse($event->tanggal_pelaksanaan_selesai)->endOfDay())) return 'ended';
        return 'live';
    }

    private function stats(Event $event): array
    {
        $lombaIds = $event->lombas()->pluck('id');

        return [
            'pangkalan' => (int) \App\Models\Kontingen::where('event_id', $event->id)
                ->distinct('team_id')->count('team_id'),
            'regu'      => (int) \App\Models\LombaKontingen::whereIn('lomba_id', $lombaIds)->count(),
            'lomba'     => (int) $lombaIds->count(),
            'juri'      => (int) \DB::table('lomba_juri')->whereIn('lomba_id', $lombaIds)
                ->distinct('juri_id')->count('juri_id'),
        ];
    }

    /** Timeline 3 fase; fase yang sedang berlangsung di-flag active. */
    private function phases(Event $event): array
    {
        $now = Carbon::now();
        $mk = fn ($m, $s) => ['mulai' => $m, 'selesai' => $s,
            'active' => $now->between(Carbon::parse($m)->startOfDay(), Carbon::parse($s)->endOfDay())];

        return [
            ['key' => 'daftar', 'label' => 'Pendaftaran', 'icon' => '📝']
                + $mk($event->periode_pendaftaran_mulai, $event->periode_pendaftaran_selesai),
            ['key' => 'lomba', 'label' => 'Pelaksanaan Lomba', 'icon' => '🏕️']
                + $mk($event->tanggal_pelaksanaan_mulai, $event->tanggal_pelaksanaan_selesai),
            ['key' => 'juara', 'label' => 'Pengumuman Juara', 'icon' => '🏆']
                + ['mulai' => $event->tanggal_pelaksanaan_selesai, 'selesai' => $event->tanggal_pelaksanaan_selesai,
                   'active' => $now->gt(Carbon::parse($event->tanggal_pelaksanaan_selesai)->endOfDay())],
        ];
    }

    /** Papan medali lintas lomba (hanya ada kalau admin sudah finalize). */
    private function standings(Event $event): array
    {
        $juaras = Juara::where('event_id', $event->id)->where('is_final', true)
            ->with('kontingen.team')->get();

        if ($juaras->isEmpty()) return [];

        $bobot = ['emas' => 3, 'perak' => 2, 'perunggu' => 1];

        $rows = $juaras->groupBy('kontingen_id')->map(function ($g) use ($bobot) {
            $e = $g->where('medali', 'emas')->count();
            $p = $g->where('medali', 'perak')->count();
            $r = $g->where('medali', 'perunggu')->count();
            return [
                'kontingen_id' => $g->first()->kontingen_id,
                'team_name'    => $g->first()->kontingen->team->name ?? '-',
                'jenjang'      => $g->first()->kontingen->team->jenjang ?? null,
                'emas' => $e, 'perak' => $p, 'perunggu' => $r,
                'poin' => ($e * $bobot['emas']) + ($p * $bobot['perak']) + ($r * $bobot['perunggu']),
            ];
        })->values()->all();

        usort($rows, fn ($a, $b) =>
            [$b['poin'], $b['emas'], $b['perak'], $a['kontingen_id']]
            <=> [$a['poin'], $a['emas'], $a['perak'], $b['kontingen_id']]);

        return collect($rows)->map(fn ($r, $i) => $r + ['rank' => $i + 1])->values()->all();
    }

    /** Leaderboard per lomba — hanya tampil jika sudah difinalisasi admin. */
    private function leaderboards(Event $event): array
    {
        return $event->lombas()->orderBy('nama')->get()->map(function (Lomba $lomba) {
            // Hanya tampilkan leaderboard jika lomba sudah difinalisasi
            $finalized = Juara::where('lomba_id', $lomba->id)->where('is_final', true)->exists();
            if (!$finalized) {
                return ['lomba' => ['id' => $lomba->id, 'nama' => $lomba->nama], 'rows' => []];
            }

            // golongan per regu di lomba ini
            $golMap = \App\Models\LombaKontingen::where('lomba_id', $lomba->id)
                ->pluck('golongan', 'kontingen_id');

            $rows = Penilaian::where('lomba_id', $lomba->id)
                ->with(['kontingen.team', 'juri'])
                ->get()
                ->groupBy('kontingen_id')
                ->map(fn ($g) => [
                    'kontingen_id' => $g->first()->kontingen_id,
                    'team_name'    => $g->first()->kontingen->team->name ?? '-',
                    'golongan'     => $golMap[$g->first()->kontingen_id] ?? null,
                    'nilai_akhir'  => round((float) $g->avg('nilai_akhir_juri'), 2),
                    'jumlah_juri'  => $g->count(),
                    'juri_scores'  => $g->map(fn ($p) => [
                        'nama'  => $p->juri->name ?? '-',
                        'nilai' => $p->nilai_akhir_juri,
                    ])->values()->all(),
                ])
                ->values()->sortByDesc('nilai_akhir')->values()
                ->map(fn ($r, $i) => $r + ['rank' => $i + 1])->values()->all();

            return ['lomba' => ['id' => $lomba->id, 'nama' => $lomba->nama], 'rows' => $rows];
        })->values()->all();
    }
}