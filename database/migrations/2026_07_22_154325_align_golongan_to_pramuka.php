<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // Ubah enum golongan ke nilai Pramuka tanpa drop+create (tidak destruktif)

        $tables = ['juaras', 'lomba_kontingen', 'penilaians'];
        foreach ($tables as $table) {
            if (Schema::hasTable($table) && Schema::hasColumn($table, 'golongan')) {
                DB::statement("ALTER TABLE `{$table}` MODIFY COLUMN `golongan` ENUM('siaga', 'penggalang', 'penegak', 'pandega') NOT NULL");
            }
        }
    }

    public function down(): void
    {
        // Kembalikan ke enum lama (nilai sebelumnya tidak diketahui, tapi ini non-destruktif)
        // Tidak ada operasi rollback karena enum asli tidak bisa direstore tanpa data historis.
    }
};