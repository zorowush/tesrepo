
<p align="center">
  <img src="resources/js/Pages/Publik/logo-persimanu.jpeg" alt="Logo PERSIMANU Jepara" width="220" />
</p>

<p align="center">
  <a href="https://laravel.com"><img src="https://img.shields.io/badge/Laravel-11+-3a5a40?style=for-the-badge&logo=laravel&logoColor=fff" alt="Laravel"></a>
  <a href="https://www.php.net"><img src="https://img.shields.io/badge/PHP-8.2+-47584a?style=for-the-badge&logo=php&logoColor=fff" alt="PHP"></a>
  <a href="https://vuejs.org"><img src="https://img.shields.io/badge/Vue-3-3a5a40?style=for-the-badge&logo=vuedotjs&logoColor=fff" alt="Vue 3"></a>
  <a href="https://inertiajs.com"><img src="https://img.shields.io/badge/Inertia.js-c9a227?style=for-the-badge&logo=vite&logoColor=fff" alt="Inertia"></a>
  <a href="https://www.mysql.com"><img src="https://img.shields.io/badge/MySQL-8-8a7a3c?style=for-the-badge&logo=mysql&logoColor=fff" alt="MySQL"></a>
  <a href="https://reverb.laravel.com"><img src="https://img.shields.io/badge/Reverb-Realtime-3a5a40?style=for-the-badge&logo=laravel&logoColor=fff" alt="Reverb"></a>
  <a href="#"><img src="https://img.shields.io/badge/Status-Siap%20Demo-c9a227?style=for-the-badge" alt="Status"></a>
  <a href="#-lisensi"><img src="https://img.shields.io/badge/Lisensi-MIT-2b2118?style=for-the-badge" alt="Lisensi"></a>
</p>

<h1 align="center">🏕️ PERSIMANU — Sistem Penilaian Lomba Kepramukaan</h1>

<p align="center">
  <em>Perkemahan Prestasi Ma'arif Nahdlatul Ulama · Kabupaten Jepara</em><br>
  <sub>Satu platform utuh: dari pendaftaran kontingen sampai papan juara siaran langsung.</sub>
</p>

<p align="center">
  <img src="resources/js/Pages/Publik/maskot-sielang.jpeg" alt="Maskot SiELANG" width="160" />
</p>
<p align="center"><sub><b>SiELANG</b> — Siswa Ma'arif Berprestasi, Empatik, Luhur, Adaptif, Nasionalis &amp; Gigih</sub></p>

---

**PERSIMANU** adalah sistem manajemen &amp; penilaian lomba kepramukaan untuk lingkungan **LP Ma'arif NU**. Aplikasi ini mengintegrasikan pendidikan kepramukaan, penguatan karakter *Ahlussunnah wal Jama'ah An-Nahdliyah*, kepemimpinan, kemandirian, serta pengembangan prestasi akademik &amp; non-akademik — dari hulu (operator sekolah mendaftarkan kontingen) sampai hilir (papan medali publik yang memperbarui dirinya sendiri secara *real-time*).

Dibangun sebagai **aplikasi lomba end-to-end**: pendaftaran → verifikasi pembayaran → verifikasi biodata → alokasi peserta → penomoran &amp; penguncian regu → penilaian juri → rekap &amp; juara umum → publikasi &amp; ekspor.

---

## 📑 Daftar Isi

- [✨ Fitur per Modul](#-fitur-per-modul)
- [🔁 Siklus Lomba (End-to-End)](#-siklus-lomba-end-to-end)
- [🧭 Gerbang Status (State Machine)](#-gerbang-status-state-machine)
- [🛠️ Stack Teknologi](#-stack-teknologi)
- [⚙️ Prasyarat](#-prasyarat)
- [🚀 Instalasi](#-instalasi)
- [🪟 Catatan Windows / Laragon](#-catatan-windows--laragon)
- [👤 Akun &amp; Data Dummy](#-akun--data-dummy)
- [📁 Struktur Proyek](#-struktur-proyek)
- [🔑 Konfigurasi (.env)](#-konfigurasi-env)
- [📡 Real-time (opsional)](#-real-time-opsional)
- [📤 Ekspor (opsional)](#-ekspor-opsional)
- [🛡️ Hardening Pra-Produksi](#-hardening-pra-produksi)
- [🧪 Smoke Test Manual](#-smoke-test-manual)
- [🗺️ Status &amp; Roadmap](#-status--roadmap)
- [🤝 Kontribusi](#-kontribusi)
- [📜 Lisensi](#-lisensi)
- [🙏 Kredit](#-kredit)

---

## ✨ Fitur per Modul

| # | Modul | Yang Dilakukan Sistem |
|---|-------|------------------------|
| **0** | **Manajemen Event** | CRUD event, slug otomatis, status `draft / aktif / selesai`, periode pendaftaran &amp; pelaksanaan. |
| **1** | **Manajemen Akun** | 3 peran — `admin`, `juri`, `operator-sekolah`. Registrasi operator otomatis membuat **Pangkalan (team)**. Pendaratan dasbor sesuai peran. |
| **2** | **Registrasi Kontingen** | Formulir kesediaan (C.01), unggah **bukti pembayaran** (Media Library), gerbang persetujuan admin. |
| **3** | **Verifikasi** | Persetujuan pembayaran + verifikasi **biodata per item** (siswa &amp; pendamping) + *roll-up* status kontingen otomatis. |
| **4** | **Lomba &amp; Kriteria** | CRUD lomba, kriteria **per golongan Pramuka** (siaga/penggalang/penegak/pandega), penugasan **multi-juri** per lomba. |
| **5** | **Alokasi Peserta** | Operator memilih lomba + golongan, **maks. 10 siswa + 1 pendamping** per regu; admin mengisi **nomor urut tampil** &amp; **mengunci** regu. |
| **6** | **Penilaian Juri** | Input nilai per komponen (1–100), rata-rata otomatis, **terkunci permanen** setelah submit. |
| **7** | **Rekap &amp; Juara** | Podium 1-2-3, **Juara Umum** (sistem poin Olimpiade), **revisi nilai admin** + **audit log** terlacak. |
| **8** | **Papan Publik** | Landing beridentitas PERSIMANU + SiELANG, klasemen &amp; *leaderboard*, **ekspor** Excel/CSV/Cetak, pembaruan **real-time**. |

### Sorotan lintas modul
- 🔐 **Otorisasi ketat** — operator hanya melihat kontingen miliknya (*ownership guard*); juri hanya menilai lomba yang ditugaskan.
- 📎 **Unggah dokumen** — bukti bayar &amp; surat keterangan sehat per siswa (gambar/PDF, *single-file replace*).
- 📜 **Jejak audit** — setiap revisi nilai mencatat *siapa / kapan / nilai lama → baru*.
- 🎨 **Identitas visual** — tema *earthy* (forest / khaki / gold / parchment / ink), maskot **SiELANG**, emblem PERSIMANU, animasi &amp; *micro-interaction*.

---

## 🔁 Siklus Lomba (End-to-End)

```text
 🏫 OPERATOR mendaftar kesediaan kontingen
            │
            ▼
 📤 unggah bukti bayar  ──────►  💳 ADMIN menyetujui pembayaran
            │                              │
            ▼                              ▼
 📋 isi biodata siswa & pendamping (+ surat sehat)
            │
            ▼
 🔍 ADMIN memverifikasi per item  ──►  kontingen = TERVERIFIKASI ✅
            │
            ▼
 🏅 OPERATOR mengalokasi lomba  (≤ 10 siswa + 1 pembina)
            │
            ▼
 🔢 ADMIN mengisi nomor urut + 🔒 KUNCI  ──►  regu = SIAP
            │
            ▼
 👨‍⚖️ JURI menilai per komponen  ──►  rata-rata + TERKUNCI
            │
            ▼
 🏆 ADMIN rekap → podium → JUARA UMUM → (bila perlu) revisi + audit
            │
            ▼
 📡 PAPAN PUBLIK memperbarui diri  +  📥 panitia mengunduh Excel/CSV/PDF
```

> Setiap panah dijaga oleh **gerbang status** — data tidak bisa melompati langkah, kepemilikan tidak bisa dilanggar, dan nilai yang terkunci tidak bisa diubah sembarangan.

---

## 🧭 Gerbang Status (State Machine)

**Status kontingen** (`kontingens.status`) — bergerak seiring verifikasi:

```text
 draft  →  menunggu_approval_pembayaran  →  menunggu_verifikasi_dokumen  →  terverifikasi
   ▲              │                                  │
   │              ▼                                  ▼
   └──────  pembayaran_ditolak              verifikasi_ditolak  ──► (perbaiki, lalu naik lagi)
```

**Status verifikasi per item** (`siswas` / `pendampings` → `status_verifikasi`): `pending → approved | rejected`.
*Kontingen menjadi `terverifikasi` hanya bila seluruh siswa &amp; pendamping `approved`.*

**Status alokasi** (`lomba_kontingen.status`): `draft → siap` (saat admin mengunci). Regu `siap` = beku &amp; siap dinilai; tidak bisa diubah operator lagi.

---

## 🛠️ Stack Teknologi

| Lapisan | Teknologi |
|---------|-----------|
| **Backend** | Laravel 11+, PHP 8.2+, MySQL 8 |
| **Frontend** | Vue 3 (Composition API), Inertia.js, Tailwind CSS, Vite |
| **Auth &amp; Tim** | Laravel Jetstream, Sanctum, Spatie Permission |
| **Media** | Spatie Media Library (bukti bayar, surat sehat) |
| **Audit** | Spatie Activity Log |
| **Real-time** | Laravel Reverb (WebSocket) + Laravel Echo / Pusher-JS |
| **Ekspor** | `maatwebsite/excel` (opsional), CSV &amp; Cetak/PDF *native* |

---

## ⚙️ Prasyarat

- **PHP** ≥ 8.2 (ekstensi: `pdo_mysql`, `mbstring`, `xml`, `gd`/`imagick` untuk konversi media, `fileinfo`)
- **Composer**
- **Node.js** ≥ 18 &amp; **npm**
- **MySQL** ≥ 8 (atau MariaDB setara)
- *(opsional)* `maatwebsite/excel` untuk ekspor `.xlsx`

---

## 🚀 Instalasi

```bash
# 1. Kloning repositori
git clone <url-repo-anda>
cd persimanu

# 2. Dependensi backend
composer install

# 3. Salin & atur environment
cp .env.example .env
php artisan key:generate
#    → edit .env: koneksi DB, APP_URL, dll (lihat bagian Konfigurasi)

# 4. Migrasi + seed (role, permission, akun admin)
php artisan migrate --seed

# 5. Tautan penyimpanan (agar unggahan bisa diakses publik)
php artisan storage:link

# 6. Dependensi frontend
npm install

# 7a. Mode pengembangan
npm run dev
php artisan serve          # http://127.0.0.1:8000

# 7b. Mode produksi
npm run build
php artisan config:cache && php artisan route:cache && php artisan view:cache
```

### Data dummy (opsional — untuk demo / uji cepat)

```bash
php artisan db:seed --class=DummyDataSeeder
```
Membuat event, lomba, kriteria, juri, beberapa pangkalan/kontingen dengan **status campuran**, penilaian terkunci, dan juara — sehingga seluruh fitur langsung terisi. *One-shot* (aman dijalankan ulang setelah `migrate:fresh`).

---

## 🪟 Catatan Windows / Laragon

`php artisan storage:link` membuat *symbolic link* yang di Windows sering butuh hak istimewa, dan bisa berujung **403** pada `/storage`. Bila itu terjadi, gunakan **junction** (tidak butuh mode admin untuk diikuti Apache):

```powershell
# hapus tautan lama (isi storage TIDAK ikut terhapus)
cmd /c rmdir public\storage

# buat junction (sesuaikan path absolut proyek Anda)
New-Item -ItemType Junction -Path "C:\laragon\www\persimanu\public\storage" `
  -Target "C:\laragon\www\persimanu\storage\app\public"
```

---

## 👤 Akun &amp; Data Dummy

| Peran | Email | Kata Sandi |
|-------|-------|------------|
| **Admin** | *(dibuat oleh `AdminUserSeeder` — lihat file-nya)* | *(lihat seeder)* |
| **Juri** | `juri1@dummy.test` · `juri2@dummy.test` | `password123` |
| **Operator** | `op0@dummy.test` … `op4@dummy.test` | `password123` |

> Akun dummy hanya ada bila `DummyDataSeeder` dijalankan. Untuk produksi, **hapus data dummy** dan gunakan akun admin dari seeder.

---

## 📁 Struktur Proyek

```text
app/
├── Http/Controllers/
│   ├── Admin/        Event, Juri, Lomba, Kriteria, PenugasanJuri,
│   │                 VerifikasiPembayaran, Verifikasi, NomorUrut, Rekap
│   ├── Juri/         Penilaian
│   ├── Sekolah/      Pendaftaran, Siswa, Pendamping, Alokasi
│   └── Publik/       Landing
├── Models/           Event, Lomba, KriteriaKomponen, Kontingen, Siswa,
│                     Pendamping, LombaKontingen, Penilaian, PenilaianDetail, Juara, …
└── Events/           JuaraUpdated, NilaiSubmitted   (broadcast real-time)

resources/js/
├── Pages/
│   ├── Admin/        dasbor + modul admin (Inertia)
│   ├── Juri/         penilaian + rekap juri
│   ├── Sekolah/      pendaftaran, biodata, alokasi
│   └── Publik/       Landing (etalase publik + identitas PERSIMANU)
├── Layouts/          AdminLayout, JuriLayout, SekolahLayout, PublicLayout
├── Components/       ExportMenu (tombol unduh pakai-ulang)
├── composables/      useLiveUpdates (langganan real-time, no-op-safe)
└── brand.js          satu sumber kebenaran path logo & maskot

routes/web.php        area: publik · admin · juri · sekolah
```

---

## 🔑 Konfigurasi (.env)

Sorotan yang relevan dengan fitur aplikasi:

```env
APP_URL=http://127.0.0.1:8000        # ganti ke domain HTTPS di produksi
APP_DEBUG=false                       # WAJIB false di produksi

DB_CONNECTION=mysql
DB_DATABASE=persimanu_db
DB_USERNAME=root                      # gunakan user khusus di produksi
DB_PASSWORD=

FILESYSTEM_DISK=public                # atau s3 (R2) bila host bersifat ephemeral
BROADCAST_CONNECTION=log              # ganti 'reverb' untuk siaran langsung
QUEUE_CONNECTION=database             # 'sync' bila tanpa worker

SESSION_SECURE_COOKIE=true            # cocokkan dengan HTTPS
```

> **Produksi:** `APP_DEBUG=false`, `APP_URL` ber-HTTPS, pengguna DB khusus, dan `npm run build` wajib ter-deploy (tanpa ini halaman Inertia menjadi kosong).

---

## 📡 Real-time (opsional)

Papan publik dapat memperbarui klasemen &amp; *leaderboard* **tanpa muat ulang** saat admin menyimpan juara atau juri mengirim nilai.

```bash
# 1. aktifkan broadcaster
#    .env → BROADCAST_CONNECTION=reverb

# 2. jalankan daemon (masing-masing di terminal terpisah)
php artisan reverb:start        # server WebSocket (port 8080)
php artisan queue:listen        # memproses antrian broadcast

# 3. frontend sudah menyambung otomatis via resources/js/echo.js
npm run dev
```

Dirancang **no-op-safe**: bila Reverb tidak aktif, aplikasi tetap berjalan normal — siaran langsung sekadar tidak menyala.

---

## 📤 Ekspor (opsional)

- **CSV** &amp; **Cetak/PDF** tersedia *tanpa* paket tambahan (UTF-8 BOM + pemisah `;` agar rapi di Excel Indonesia; *stylesheet* cetak menyembunyikan *chrome* admin).
- **Excel (.xlsx)** memerlukan:

```bash
composer require maatwebsite/excel
php artisan make:export RekapLombaExport   # bila belum ada
```

---

## 🛡️ Hardening Pra-Produksi

Checklist sebelum tayang ke publik:

```text
INTEGRITAS
[ ] Gerbang alokasi: hanya siswa berstatus 'approved' yang boleh ikut lomba
[ ] Cegah buka-kunci regu yang sudah dinilai juri

KEAMANAN AKUN
[ ] Rate-limit login & registrasi (anti brute-force)
[ ] 2FA wajib untuk peran admin
[ ] Security headers (CSP, X-Frame-Options)

KONFIGURASI
[ ] APP_DEBUG=false  ·  HTTPS aktif  ·  SESSION_SECURE_COOKIE=true
[ ] config:cache / route:cache / view:cache
[ ] .env tidak terbaca via web  ·  APP_KEY kuat & unik per lingkungan

STABILITAS
[ ] Supervisor untuk queue:listen & reverb:start
[ ] Cadangan basis data terjadwal
[ ] Penyimpanan persisten (volume) atau object storage (R2) agar unggahan tidak hilang
```

---

## 🧪 Smoke Test Manual

Satu lintasan penuh untuk memastikan sistem menyatu:

```text
1. login operator  → daftar kontingen → unggah bukti bayar
2. login admin     → setujui pembayaran → verifikasi biodata per item
3. login operator  → alokasi lomba (siswa + pendamping)
4. login admin     → isi nomor urut → kunci regu
5. login juri      → nilai regu → terkunci
6. login admin     → rekap → simpan juara → juara umum
7. buka /          → papan publik menampilkan klasemen (+ siaran langsung bila Reverb aktif)
8. admin           → unduh rekap (CSV / Cetak / Excel)
```

---

## 🗺️ Status &amp; Roadmap

- ✅ Modul 0–8 — **selesai &amp; terintegrasi**
- ✅ Identitas publik (logo, maskot SiELANG, narasi, nilai karakter)
- ✅ Ekspor CSV &amp; Cetak/PDF
- 🟡 Ekspor Excel — siap setelah `maatwebsite/excel` terpasang
- 🟡 Siaran langsung Reverb — kode siap, daemon opsional
- ⬜ Hardening produksi (lihat checklist di atas)

---

## 🤝 Kontribusi

1. *Fork* &amp; buat *branch* fitur (`git checkout -b fitur/nama-fitur`).
2. Ikuti konvensi: *controller* per area (`Admin/`, `Juri/`, `Sekolah/`, `Publik/`), *page* Inertia di `resources/js/Pages/`.
3. Jaga gerbang status &amp; *ownership guard* — jangan bypass otorisasi.
4. Uji lintasan penuh (lihat *Smoke Test*) sebelum *pull request*.

---

## 📜 Lisensi

Proyek ini dirilis di bawah **Lisensi MIT**. Lihat berkas `LICENSE` (bila tersedia).

---

## 🙏 Kredit

Dibangun untuk **Sako Pandu Ma'arif NU · LP Ma'arif NU Kabupaten Jepara** —
*PERSIMANU: Perkemahan Prestasi Ma'arif Nahdlatul Ulama.*

<p align="center">
  <sub>⚜ Dibuat dengan 🤎 untuk kader muda Ma'arif NU yang berprestasi &amp; berkarakter.</sub>
</p>
