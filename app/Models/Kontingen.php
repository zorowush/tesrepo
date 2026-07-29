<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Spatie\Image\Enums\Fit;
use Spatie\MediaLibrary\HasMedia;
use Spatie\MediaLibrary\InteractsWithMedia;
use Spatie\MediaLibrary\MediaCollections\Models\Media;

class Kontingen extends Model implements HasMedia
{
    use HasFactory;
    use InteractsWithMedia;

    protected $fillable = [
        'event_id',
        'team_id',
        'status',
        'nama_kontingen',
        'contact_person',
        'contact_phone',
        'catatan_pembayaran',
        'approved_by',
        'approved_at',
        'finalized_at',
    ];

    protected $casts = [
        'approved_at' => 'datetime',
        'finalized_at' => 'datetime',
    ];

    public function registerMediaConversions(?Media $media = null): void
    {
        $this->addMediaConversion('preview')
            ->fit(Fit::Contain, 1200, 1200)   // max 1200px, aspect ratio aman
            ->quality(80)                      // compress
            ->performOnCollections('bukti_pembayaran');
    }

    // 1 kontingen = 1 bukti pembayaran (upload baru replace yang lama)
    public function registerMediaCollections(): void
    {
        $this->addMediaCollection('bukti_pembayaran')
            ->singleFile()
            ->acceptsMimeTypes(['image/jpeg', 'image/png', 'image/jpg', 'application/pdf']);
    }

    /**
     * Biodata siswa/pendamping hanya boleh diisi setelah pembayaran
     * disetujui admin (atau saat ada item ditolak & perlu diperbaiki).
     */
    public function bolehIsiBiodata(): bool
    {
        return in_array($this->status, [
            'menunggu_verifikasi_dokumen',
            'verifikasi_ditolak',
        ]);
    }

    public function alokasi()
    {
        return $this->hasMany(LombaKontingen::class);
    }

    /**
     * v1: alokasi boleh setelah pembayaran disetujui.
     * NANTI diperketat jadi hanya ['terverifikasi'] setelah B3-admin jalan.
     */
    public function bolehAlokasi(): bool
    {
        return in_array($this->status, [
            'menunggu_verifikasi_dokumen',
            'verifikasi_ditolak',
            'terverifikasi',
        ]);
    }

    /**
     * Hitung ulang status kontingen berdasarkan status verifikasi
     * seluruh siswa & pendamping. Dipanggil tiap admin approve/reject item.
     */
    public function segelVerifikasi(): void
    {
        $siswaTotal = $this->siswas()->count();
        $pendampingTotal = $this->pendampings()->count();

        $siswaPending = $this->siswas()->where('status_verifikasi', 'pending')->count();
        $pendampingPending = $this->pendampings()->where('status_verifikasi', 'pending')->count();

        $adaRejected = $this->siswas()->where('status_verifikasi', 'rejected')->exists()
                    || $this->pendampings()->where('status_verifikasi', 'rejected')->exists();

        $adaPending = ($siswaPending + $pendampingPending) > 0;
        $adaItem = ($siswaTotal + $pendampingTotal) > 0;

        // Terverifikasi jika: ada minimal 1 item (siswa/pendamping) dan semuanya approved
        $semuaApproved = $adaItem
                      && ! $adaRejected
                      && ! $adaPending;

        if ($semuaApproved) {
            $this->status = 'terverifikasi';
            $this->finalized_at = $this->finalized_at ?? now();
        } elseif ($adaRejected) {
            $this->status = 'verifikasi_ditolak';
            $this->finalized_at = null;
        } else {
            $this->status = 'menunggu_verifikasi_dokumen';
            $this->finalized_at = null;
        }

        $this->save();
    }

    public function event(): BelongsTo
    {
        return $this->belongsTo(Event::class);
    }

    public function team(): BelongsTo
    {
        return $this->belongsTo(Team::class);
    }

    public function siswas(): HasMany
    {
        return $this->hasMany(Siswa::class);
    }

    public function pendampings(): HasMany
    {
        return $this->hasMany(Pendamping::class);
    }

    public function approver(): BelongsTo
    {
        return $this->belongsTo(User::class, 'approved_by');
    }
}
