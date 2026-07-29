<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('siswas', function (Blueprint $table) {
            $table->id();
            $table->foreignId('kontingen_id')->constrained()->onDelete('cascade');
            $table->string('nama');
            $table->string('nisn')->nullable();
            $table->enum('jenis_kelamin', ['L', 'P']);
            $table->string('tempat_lahir')->nullable();
            $table->date('tanggal_lahir')->nullable();
            $table->text('alamat')->nullable();
            $table->string('no_telp')->nullable();
            $table->enum('jenjang_pendidikan', [
                'SD',
                'MI',
                'SMP',
                'MTs',
                'SMA',
                'MA',
                'SMK'
            ])->nullable();
            $table->enum('golongan_lomba', [
                'SD',
                'SMP',
                'SMA'
            ])->nullable();
            $table->enum('golongan_pramuka', [
                'siaga',
                'penggalang',
                'penegak',
                'pandega'
            ])->nullable();
            $table->string('golongan_darah')->nullable();
            $table->enum('status_verifikasi', ['pending', 'approved', 'rejected'])
                ->default('pending');
            $table->text('catatan_verifikasi')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('siswas');
    }
};
