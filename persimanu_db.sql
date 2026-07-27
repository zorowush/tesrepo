-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 27 Jul 2026 pada 20.27
-- Versi server: 8.4.3
-- Versi PHP: 8.3.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Basis data: `persimanu_db`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `activity_log`
--

CREATE TABLE `activity_log` (
  `id` bigint UNSIGNED NOT NULL,
  `log_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `event` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject_id` bigint UNSIGNED DEFAULT NULL,
  `causer_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `causer_id` bigint UNSIGNED DEFAULT NULL,
  `properties` json DEFAULT NULL,
  `batch_uuid` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `activity_log`
--

INSERT INTO `activity_log` (`id`, `log_name`, `description`, `subject_type`, `event`, `subject_id`, `causer_type`, `causer_id`, `properties`, `batch_uuid`, `created_at`, `updated_at`) VALUES
(1, 'default', 'revisi-nilai', 'App\\Models\\Penilaian', NULL, 2, 'App\\Models\\User', 1, '{\"new\": {\"3\": 78, \"4\": 88, \"5\": 88}, \"old\": {\"3\": 88, \"4\": 88, \"5\": 88}, \"juri_id\": 6, \"new_avg\": 84.67, \"old_avg\": 88}', NULL, '2026-07-27 06:45:43', '2026-07-27 06:45:43');

-- --------------------------------------------------------

--
-- Struktur dari tabel `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('laravel-cache-11aaa898d29e3f04567678f6284ca6f8', 'i:1;', 1785153547),
('laravel-cache-11aaa898d29e3f04567678f6284ca6f8:timer', 'i:1785153547;', 1785153547),
('laravel-cache-356a192b7913b04c54574d18c28d46e6395428ab', 'i:1;', 1785154680),
('laravel-cache-356a192b7913b04c54574d18c28d46e6395428ab:timer', 'i:1785154680;', 1785154680),
('laravel-cache-3ddb28f46df903491d583116bc253f46', 'i:1;', 1785171038),
('laravel-cache-3ddb28f46df903491d583116bc253f46:timer', 'i:1785171038;', 1785171038),
('laravel-cache-41b8ffa8db8346e3683daadd644be8de', 'i:5;', 1785145089),
('laravel-cache-41b8ffa8db8346e3683daadd644be8de:timer', 'i:1785145089;', 1785145089),
('laravel-cache-ac3478d69a3c81fa62e60f5c3696165a4e5e6ac4', 'i:1;', 1784750846),
('laravel-cache-ac3478d69a3c81fa62e60f5c3696165a4e5e6ac4:timer', 'i:1784750846;', 1784750846),
('laravel-cache-d4f9202c13130562a401fe2e1f2c838d', 'i:1;', 1785153473),
('laravel-cache-d4f9202c13130562a401fe2e1f2c838d:timer', 'i:1785153473;', 1785153473),
('laravel-cache-d783ef32215842a9082f01b923ce8bd2', 'i:1;', 1784743940),
('laravel-cache-d783ef32215842a9082f01b923ce8bd2:timer', 'i:1784743940;', 1784743940),
('laravel-cache-fe5dbbcea5ce7e2988b8c69bcfdfde8904aabc1f', 'i:1;', 1785154661),
('laravel-cache-fe5dbbcea5ce7e2988b8c69bcfdfde8904aabc1f:timer', 'i:1785154661;', 1785154661),
('laravel-cache-ff4c6ef89769534bf054af5950ed038b', 'i:1;', 1785145405),
('laravel-cache-ff4c6ef89769534bf054af5950ed038b:timer', 'i:1785145405;', 1785145405),
('laravel-cache-spatie.permission.cache', 'a:3:{s:5:\"alias\";a:0:{}s:11:\"permissions\";a:0:{}s:5:\"roles\";a:0:{}}', 1785258188);

-- --------------------------------------------------------

--
-- Struktur dari tabel `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `events`
--

CREATE TABLE `events` (
  `id` bigint UNSIGNED NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deskripsi` text COLLATE utf8mb4_unicode_ci,
  `periode_pendaftaran_mulai` date NOT NULL,
  `periode_pendaftaran_selesai` date NOT NULL,
  `tanggal_pelaksanaan_mulai` date NOT NULL,
  `tanggal_pelaksanaan_selesai` date NOT NULL,
  `status` enum('draft','aktif','selesai') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `events`
--

INSERT INTO `events` (`id`, `nama`, `slug`, `deskripsi`, `periode_pendaftaran_mulai`, `periode_pendaftaran_selesai`, `tanggal_pelaksanaan_mulai`, `tanggal_pelaksanaan_selesai`, `status`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'Persimanu Champions 2026', 'persimanu-champions-2026-r3tmck', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Perferendis ullam laborum distinctio esse. Asperiores quibusdam, enim quam ducimus quasi praesentium? Reprehenderit eveniet harum inventore sint in. Illo vel nulla porro?', '2026-07-22', '2026-07-31', '2026-07-22', '2026-07-31', 'aktif', 1, '2026-07-22 09:05:10', '2026-07-22 09:05:10'),
(2, 'PERSIMANU Jepara 2026 (DUMMY)', 'persimanu-jepara-2026-dummy', 'Event dummy untuk pengujian seluruh fitur.', '2026-01-01', '2026-12-31', '2026-08-15', '2026-08-17', 'aktif', NULL, '2026-07-27 04:54:28', '2026-07-27 04:54:28');

-- --------------------------------------------------------

--
-- Struktur dari tabel `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` smallint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `juaras`
--

CREATE TABLE `juaras` (
  `id` bigint UNSIGNED NOT NULL,
  `event_id` bigint UNSIGNED NOT NULL,
  `lomba_id` bigint UNSIGNED NOT NULL,
  `kontingen_id` bigint UNSIGNED NOT NULL,
  `golongan` enum('siaga','penggalang','penegak','pandega') COLLATE utf8mb4_unicode_ci NOT NULL,
  `juara` tinyint UNSIGNED NOT NULL,
  `medali` enum('emas','perak','perunggu') COLLATE utf8mb4_unicode_ci NOT NULL,
  `nilai_akhir` decimal(5,2) NOT NULL DEFAULT '0.00',
  `is_final` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `juaras`
--

INSERT INTO `juaras` (`id`, `event_id`, `lomba_id`, `kontingen_id`, `golongan`, `juara`, `medali`, `nilai_akhir`, `is_final`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 2, 'penggalang', 1, 'emas', 99.00, 1, '2026-07-27 04:22:45', '2026-07-27 04:22:45'),
(5, 2, 4, 3, 'penggalang', 1, 'emas', 90.00, 1, '2026-07-27 05:42:05', '2026-07-27 05:42:05'),
(6, 2, 4, 4, 'penggalang', 2, 'perak', 85.00, 1, '2026-07-27 05:42:05', '2026-07-27 05:42:05'),
(7, 2, 4, 5, 'penggalang', 3, 'perunggu', 80.00, 1, '2026-07-27 05:42:05', '2026-07-27 05:42:05');

-- --------------------------------------------------------

--
-- Struktur dari tabel `kontingens`
--

CREATE TABLE `kontingens` (
  `id` bigint UNSIGNED NOT NULL,
  `event_id` bigint UNSIGNED NOT NULL,
  `team_id` bigint UNSIGNED NOT NULL,
  `status` enum('draft','menunggu_approval_pembayaran','pembayaran_ditolak','menunggu_verifikasi_dokumen','verifikasi_ditolak','terverifikasi') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `nama_kontingen` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_person` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `catatan_pembayaran` text COLLATE utf8mb4_unicode_ci,
  `approved_by` bigint UNSIGNED DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `finalized_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `kontingens`
--

INSERT INTO `kontingens` (`id`, `event_id`, `team_id`, `status`, `nama_kontingen`, `contact_person`, `contact_phone`, `catatan_pembayaran`, `approved_by`, `approved_at`, `finalized_at`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'menunggu_verifikasi_dokumen', 'MTS JEPARA', 'Khoirul imam fazri', '087738117167', NULL, 1, '2026-07-22 12:17:25', NULL, '2026-07-22 11:12:30', '2026-07-22 12:17:25'),
(2, 1, 2, 'terverifikasi', 'ethtrrj', 'Irul', '5432456543', NULL, 1, '2026-07-22 13:37:36', '2026-07-27 02:43:45', '2026-07-22 13:06:15', '2026-07-27 02:43:45'),
(3, 2, 3, 'terverifikasi', 'Kontingen Dummy', 'CP Dummy', '081200000000', NULL, 1, '2026-07-27 04:54:28', '2026-07-27 04:54:28', '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(4, 2, 4, 'terverifikasi', 'Kontingen Dummy', 'CP Dummy', '081200000000', NULL, 1, '2026-07-27 04:54:28', '2026-07-27 04:54:28', '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(5, 2, 5, 'terverifikasi', 'Kontingen Dummy', 'CP Dummy', '081200000000', NULL, 1, '2026-07-27 04:54:28', '2026-07-27 04:54:28', '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(6, 2, 6, 'menunggu_verifikasi_dokumen', 'Kontingen Dummy', 'CP Dummy', '081200000000', NULL, 1, '2026-07-27 05:15:38', NULL, '2026-07-27 04:54:28', '2026-07-27 05:15:38'),
(7, 2, 7, 'menunggu_verifikasi_dokumen', 'Kontingen Dummy', 'CP Dummy', '081200000000', NULL, 1, '2026-07-27 04:54:28', NULL, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(8, 1, 3, 'terverifikasi', 'MTs NU Jepara', 'Imam', '081200008001', NULL, 1, '2026-07-27 05:17:00', '2026-07-27 05:36:53', '2026-07-27 05:16:16', '2026-07-27 05:36:53');

-- --------------------------------------------------------

--
-- Struktur dari tabel `kriteria_komponens`
--

CREATE TABLE `kriteria_komponens` (
  `id` bigint UNSIGNED NOT NULL,
  `lomba_id` bigint UNSIGNED NOT NULL,
  `golongan` enum('siaga','penggalang','penegak','pandega') COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_komponen` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `urutan` int UNSIGNED NOT NULL DEFAULT '1',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `kriteria_komponens`
--

INSERT INTO `kriteria_komponens` (`id`, `lomba_id`, `golongan`, `nama_komponen`, `urutan`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 3, 'siaga', 'Kekompakan\nTeknik\nkekuatan', 1, 1, '2026-07-22 09:10:01', '2026-07-22 09:46:40'),
(2, 1, 'penggalang', 'teknik kekompakan', 2, 1, '2026-07-22 09:46:16', '2026-07-22 09:46:16'),
(3, 4, 'penggalang', 'Kekompakan & Yel-yel', 1, 1, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(4, 4, 'penggalang', 'Teknik & Keterampilan', 2, 1, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(5, 4, 'penggalang', 'Kerapian & Disiplin', 3, 1, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(6, 5, 'penggalang', 'Kekompakan & Yel-yel', 1, 1, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(7, 5, 'penggalang', 'Teknik & Keterampilan', 2, 1, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(8, 5, 'penggalang', 'Kerapian & Disiplin', 3, 1, '2026-07-27 04:54:28', '2026-07-27 04:54:28');

-- --------------------------------------------------------

--
-- Struktur dari tabel `lombas`
--

CREATE TABLE `lombas` (
  `id` bigint UNSIGNED NOT NULL,
  `event_id` bigint UNSIGNED NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deskripsi` text COLLATE utf8mb4_unicode_ci,
  `status` enum('draft','aktif','selesai') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `lombas`
--

INSERT INTO `lombas` (`id`, `event_id`, `nama`, `slug`, `deskripsi`, `status`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 1, 'Cerdas Cermat', 'cerdas-cermat-kuj6rl', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Perferendis ullam laborum distinctio esse. Asperiores quibusdam, enim quam ducimus quasi praesentium? Reprehenderit eveniet harum inventore sint in. Illo vel nulla porro?', 'aktif', 1, '2026-07-22 09:07:12', '2026-07-22 09:07:12'),
(2, 1, 'Lomba menggambar', 'lomba-menggambar-6nkhtw', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Perferendis ullam laborum distinctio esse. Asperiores quibusdam, enim quam ducimus quasi praesentium? Reprehenderit eveniet harum inventore sint in. Illo vel nulla porro?', 'aktif', 1, '2026-07-22 09:07:26', '2026-07-22 09:07:26'),
(3, 1, 'Yel-Yel', 'yel-yel-evjvmb', 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Perferendis ullam laborum distinctio esse. Asperiores quibusdam, enim quam ducimus quasi praesentium? Reprehenderit eveniet harum inventore sint in. Illo vel nulla porro?', 'aktif', 1, '2026-07-22 09:07:42', '2026-07-22 09:07:42'),
(4, 2, 'Cerdas Cermat Kepramukaan', 'cerdas-cermat-kepramukaan-d1', 'Lomba dummy 1', 'aktif', NULL, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(5, 2, 'Pionering & Simpul', 'pionering-simpul-d2', 'Lomba dummy 2', 'aktif', NULL, '2026-07-27 04:54:28', '2026-07-27 04:54:28');

-- --------------------------------------------------------

--
-- Struktur dari tabel `lomba_juri`
--

CREATE TABLE `lomba_juri` (
  `id` bigint UNSIGNED NOT NULL,
  `lomba_id` bigint UNSIGNED NOT NULL,
  `juri_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `lomba_juri`
--

INSERT INTO `lomba_juri` (`id`, `lomba_id`, `juri_id`, `created_at`, `updated_at`) VALUES
(2, 1, 3, NULL, NULL),
(3, 2, 2, NULL, NULL),
(4, 2, 3, NULL, NULL),
(5, 4, 6, NULL, NULL),
(6, 4, 7, NULL, NULL),
(7, 5, 6, NULL, NULL),
(8, 5, 7, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `lomba_kontingen`
--

CREATE TABLE `lomba_kontingen` (
  `id` bigint UNSIGNED NOT NULL,
  `lomba_id` bigint UNSIGNED NOT NULL,
  `kontingen_id` bigint UNSIGNED NOT NULL,
  `golongan` enum('siaga','penggalang','penegak','pandega') COLLATE utf8mb4_unicode_ci NOT NULL,
  `pendamping_id` bigint UNSIGNED DEFAULT NULL,
  `nomor_urut_tampil` int UNSIGNED DEFAULT NULL,
  `status` enum('draft','siap','selesai') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `lomba_kontingen`
--

INSERT INTO `lomba_kontingen` (`id`, `lomba_id`, `kontingen_id`, `golongan`, `pendamping_id`, `nomor_urut_tampil`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 'penggalang', 3, 1, 'siap', '2026-07-23 13:22:02', '2026-07-27 04:05:15'),
(2, 4, 3, 'penggalang', 5, 1, 'siap', '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(3, 4, 4, 'penggalang', 6, 2, 'siap', '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(4, 4, 5, 'penggalang', 7, 3, 'siap', '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(5, 5, 4, 'penggalang', 6, 1, 'siap', '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(6, 5, 5, 'penggalang', 7, 2, 'siap', '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(7, 5, 3, 'penggalang', 5, 3, 'siap', '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(8, 1, 8, 'penggalang', 9, NULL, 'draft', '2026-07-27 05:41:13', '2026-07-27 05:41:13');

-- --------------------------------------------------------

--
-- Struktur dari tabel `lomba_kontingen_siswa`
--

CREATE TABLE `lomba_kontingen_siswa` (
  `id` bigint UNSIGNED NOT NULL,
  `lomba_kontingen_id` bigint UNSIGNED NOT NULL,
  `siswa_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `lomba_kontingen_siswa`
--

INSERT INTO `lomba_kontingen_siswa` (`id`, `lomba_kontingen_id`, `siswa_id`, `created_at`, `updated_at`) VALUES
(1, 1, 3, NULL, NULL),
(2, 1, 4, NULL, NULL),
(3, 1, 5, NULL, NULL),
(4, 1, 6, NULL, NULL),
(5, 1, 7, NULL, NULL),
(6, 1, 8, NULL, NULL),
(7, 1, 9, NULL, NULL),
(8, 1, 10, NULL, NULL),
(9, 1, 11, NULL, NULL),
(10, 1, 12, NULL, NULL),
(11, 2, 15, NULL, NULL),
(12, 2, 16, NULL, NULL),
(13, 2, 17, NULL, NULL),
(14, 2, 18, NULL, NULL),
(15, 3, 19, NULL, NULL),
(16, 3, 20, NULL, NULL),
(17, 3, 21, NULL, NULL),
(18, 3, 22, NULL, NULL),
(19, 4, 23, NULL, NULL),
(20, 4, 24, NULL, NULL),
(21, 4, 25, NULL, NULL),
(22, 4, 26, NULL, NULL),
(23, 5, 19, NULL, NULL),
(24, 5, 20, NULL, NULL),
(25, 5, 21, NULL, NULL),
(26, 5, 22, NULL, NULL),
(27, 6, 23, NULL, NULL),
(28, 6, 24, NULL, NULL),
(29, 6, 25, NULL, NULL),
(30, 6, 26, NULL, NULL),
(31, 7, 15, NULL, NULL),
(32, 7, 16, NULL, NULL),
(33, 7, 17, NULL, NULL),
(34, 7, 18, NULL, NULL),
(35, 8, 29, NULL, NULL),
(36, 8, 30, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `lomba_peserta`
--

CREATE TABLE `lomba_peserta` (
  `id` bigint UNSIGNED NOT NULL,
  `lomba_kontigen_id` bigint UNSIGNED NOT NULL,
  `siswa_id` bigint UNSIGNED NOT NULL,
  `keterangan` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `media`
--

CREATE TABLE `media` (
  `id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `collection_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mime_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disk` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `conversions_disk` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` bigint UNSIGNED NOT NULL,
  `manipulations` json NOT NULL,
  `custom_properties` json NOT NULL,
  `generated_conversions` json NOT NULL,
  `responsive_images` json NOT NULL,
  `order_column` int UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `media`
--

INSERT INTO `media` (`id`, `model_type`, `model_id`, `uuid`, `collection_name`, `name`, `file_name`, `mime_type`, `disk`, `conversions_disk`, `size`, `manipulations`, `custom_properties`, `generated_conversions`, `responsive_images`, `order_column`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\Kontingen', 1, '201d23e6-393f-43f0-9cc6-e7d08ea1251f', 'bukti_pembayaran', 'download', 'download.jpg', 'image/jpeg', 'public', 'public', 10626, '[]', '[]', '[]', '[]', 1, '2026-07-22 11:54:06', '2026-07-22 11:54:06'),
(2, 'App\\Models\\Kontingen', 2, '5cc2bf5e-3fda-4319-afe5-05e5f2cf928b', 'bukti_pembayaran', '18f368af-feb3-4c43-a1fe-0d1747942537', '18f368af-feb3-4c43-a1fe-0d1747942537.png', 'image/png', 'public', 'public', 1357392, '[]', '[]', '{\"preview\": true}', '[]', 1, '2026-07-22 13:06:26', '2026-07-27 11:11:09'),
(3, 'App\\Models\\Siswa', 14, 'b3bf825e-eddd-417f-a7a9-14e978f10058', 'surat_kesehatan', 'pp', 'pp.png', 'image/png', 'public', 'public', 473460, '[]', '[]', '[]', '[]', 1, '2026-07-26 10:46:37', '2026-07-26 10:46:37'),
(4, 'App\\Models\\Kontingen', 8, 'd4647bf9-f096-467b-800e-ea1166b9f6fc', 'bukti_pembayaran', 'download', 'download.jpg', 'image/jpeg', 'public', 'public', 10626, '[]', '[]', '{\"preview\": true}', '[]', 1, '2026-07-27 05:16:41', '2026-07-27 11:11:11'),
(5, 'App\\Models\\Siswa', 29, '2a11da8d-34be-4162-b939-5564db731297', 'surat_kesehatan', 'download', 'download.jpg', 'image/jpeg', 'public', 'public', 10626, '[]', '[]', '[]', '[]', 1, '2026-07-27 05:19:41', '2026-07-27 05:19:41');

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_07_20_224825_add_two_factor_columns_to_users_table', 1),
(5, '2026_07_20_224826_create_passkeys_table', 1),
(6, '2026_07_20_225118_create_personal_access_tokens_table', 1),
(7, '2026_07_20_225119_create_teams_table', 1),
(8, '2026_07_20_225120_create_team_user_table', 1),
(9, '2026_07_20_225121_create_team_invitations_table', 1),
(10, '2026_07_21_102350_create_permission_tables', 1),
(11, '2026_07_21_102642_create_activity_log_table', 1),
(12, '2026_07_21_102643_add_event_column_to_activity_log_table', 1),
(13, '2026_07_21_102644_add_batch_uuid_column_to_activity_log_table', 1),
(14, '2026_07_21_110041_add_pangkalan_fields_to_teams_table', 1),
(15, '2026_07_21_110839_create_events_table', 1),
(16, '2026_07_21_110901_create_kontingens_table', 1),
(17, '2026_07_21_110911_create_siswas_table', 1),
(18, '2026_07_21_110920_create_pendampings_table', 1),
(19, '2026_07_21_110931_create_lombas_table', 1),
(20, '2026_07_21_110942_create_kriteria_komponens_table', 1),
(21, '2026_07_21_110950_create_penilaians_table', 1),
(22, '2026_07_21_111002_create_penilaian_details_table', 1),
(23, '2026_07_21_111015_create_juaras_table', 1),
(24, '2026_07_21_111713_create_lomba_juri_table', 1),
(25, '2026_07_21_111720_create_lomba_kontingen_table', 1),
(26, '2026_07_21_111725_create_lomba_peserta_table', 1),
(27, '2026_07_21_111731_create_verifikasi_items_table', 1),
(28, '2026_07_22_121712_restore_jetstream_columns_to_teams_table', 1),
(29, '2026_07_22_122350_add_custom_fields_to_users_table', 1),
(30, '2026_07_22_154325_align_golongan_to_pramuka', 2),
(31, '2026_07_22_184632_create_media_table', 3),
(32, '2026_07_23_194136_add_alokasi_fields_and_tables', 4);

-- --------------------------------------------------------

--
-- Struktur dari tabel `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(2, 'App\\Models\\User', 2),
(2, 'App\\Models\\User', 3),
(3, 'App\\Models\\User', 4),
(3, 'App\\Models\\User', 5),
(2, 'App\\Models\\User', 6),
(2, 'App\\Models\\User', 7),
(3, 'App\\Models\\User', 8),
(3, 'App\\Models\\User', 9),
(3, 'App\\Models\\User', 10),
(3, 'App\\Models\\User', 11),
(3, 'App\\Models\\User', 12);

-- --------------------------------------------------------

--
-- Struktur dari tabel `passkeys`
--

CREATE TABLE `passkeys` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `credential_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `credential` json NOT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pendampings`
--

CREATE TABLE `pendampings` (
  `id` bigint UNSIGNED NOT NULL,
  `kontingen_id` bigint UNSIGNED NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jenis_kelamin` enum('L','P') COLLATE utf8mb4_unicode_ci NOT NULL,
  `jabatan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pekerjaan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `golongan_binaan` enum('siaga','penggalang','penegak','pandega') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `asal_instansi` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tempat_lahir` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `alamat` text COLLATE utf8mb4_unicode_ci,
  `no_telp` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kota` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `golongan_darah` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_verifikasi` enum('pending','approved','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `catatan_verifikasi` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `pendampings`
--

INSERT INTO `pendampings` (`id`, `kontingen_id`, `nama`, `jenis_kelamin`, `jabatan`, `pekerjaan`, `golongan_binaan`, `asal_instansi`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_telp`, `kota`, `golongan_darah`, `status_verifikasi`, `catatan_verifikasi`, `created_at`, `updated_at`) VALUES
(2, 2, 'Drs. H. Muhammad Soleh', 'L', 'Ketua Kontingen', 'Kepala Madrasah', 'penggalang', 'MTs NU Jepara', 'Jepara', '1972-06-10', 'Jl. Pemuda No. 45, Jepara', '081325002001', 'Jepara', 'A', 'approved', NULL, '2026-07-23 20:03:03', '2026-07-27 02:42:50'),
(3, 2, 'Ahmad Zaki, S.Pd', 'L', 'Pembina Putra', 'Guru', 'penggalang', 'MTs NU Jepara', 'Kudus', '1985-03-22', 'Desa Tahunan RT 01/02, Jepara', '081325002002', 'Jepara', 'B', 'approved', NULL, '2026-07-23 20:03:03', '2026-07-27 02:41:20'),
(4, 2, 'Siti Maryam, S.Pd.I', 'P', 'Pembina Putri', 'Guru', 'penggalang', 'MTs NU Jepara', 'Jepara', '1988-09-05', 'Desa Mulyoharjo RT 03/01, Jepara', '081325002003', 'Jepara', 'O', 'approved', NULL, '2026-07-23 20:03:03', '2026-07-27 02:42:48'),
(5, 3, 'Pembina Dummy', 'L', 'Pembina', 'Guru', 'penggalang', 'Pangkalan Dummy', 'Jepara', '1985-03-12', 'Jl. Pramuka', '081400000000', 'Jepara', 'A', 'approved', NULL, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(6, 4, 'Pembina Dummy', 'L', 'Pembina', 'Guru', 'penggalang', 'Pangkalan Dummy', 'Jepara', '1985-03-12', 'Jl. Pramuka', '081400000000', 'Jepara', 'A', 'approved', NULL, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(7, 5, 'Pembina Dummy', 'L', 'Pembina', 'Guru', 'penggalang', 'Pangkalan Dummy', 'Jepara', '1985-03-12', 'Jl. Pramuka', '081400000000', 'Jepara', 'A', 'approved', NULL, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(8, 7, 'Pembina Dummy', 'L', 'Pembina', 'Guru', 'penggalang', 'Pangkalan Dummy', 'Jepara', '1985-03-12', 'Jl. Pramuka', '081400000000', 'Jepara', 'A', 'pending', NULL, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(9, 8, 'Herman', 'L', 'Pembina', 'Guru', 'penegak', 'Mts Jepara', 'Kudus', '1995-06-07', 'Kudus', '087738117654', 'Jepara', NULL, 'approved', NULL, '2026-07-27 05:23:14', '2026-07-27 05:24:02');

-- --------------------------------------------------------

--
-- Struktur dari tabel `penilaians`
--

CREATE TABLE `penilaians` (
  `id` bigint UNSIGNED NOT NULL,
  `lomba_id` bigint UNSIGNED NOT NULL,
  `kontingen_id` bigint UNSIGNED NOT NULL,
  `juri_id` bigint UNSIGNED NOT NULL,
  `golongan` enum('siaga','penggalang','penegak','pandega') COLLATE utf8mb4_unicode_ci NOT NULL,
  `nomor_urut_tampil` int UNSIGNED DEFAULT NULL,
  `nilai_akhir_juri` decimal(5,2) DEFAULT NULL,
  `is_locked` tinyint(1) NOT NULL DEFAULT '1',
  `submitted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `penilaians`
--

INSERT INTO `penilaians` (`id`, `lomba_id`, `kontingen_id`, `juri_id`, `golongan`, `nomor_urut_tampil`, `nilai_akhir_juri`, `is_locked`, `submitted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 3, 'penggalang', 1, 99.00, 1, '2026-07-27 04:06:34', '2026-07-27 04:06:34', '2026-07-27 04:06:34'),
(2, 4, 3, 6, 'penggalang', 1, 84.67, 1, '2026-07-27 04:54:28', '2026-07-27 04:54:28', '2026-07-27 06:45:43'),
(3, 4, 3, 7, 'penggalang', 1, 92.00, 1, '2026-07-27 04:54:28', '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(4, 4, 4, 6, 'penggalang', 2, 84.00, 1, '2026-07-27 04:54:28', '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(5, 4, 4, 7, 'penggalang', 2, 86.00, 1, '2026-07-27 04:54:28', '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(6, 4, 5, 6, 'penggalang', 3, 79.00, 1, '2026-07-27 04:54:28', '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(7, 4, 5, 7, 'penggalang', 3, 81.00, 1, '2026-07-27 04:54:28', '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(8, 5, 4, 6, 'penggalang', 1, 90.00, 1, '2026-07-27 04:54:28', '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(9, 5, 4, 7, 'penggalang', 1, 94.00, 1, '2026-07-27 04:54:28', '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(10, 5, 5, 6, 'penggalang', 2, 87.00, 1, '2026-07-27 04:54:28', '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(11, 5, 5, 7, 'penggalang', 2, 89.00, 1, '2026-07-27 04:54:28', '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(12, 5, 3, 6, 'penggalang', 3, 77.00, 1, '2026-07-27 04:54:28', '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(13, 5, 3, 7, 'penggalang', 3, 79.00, 1, '2026-07-27 04:54:28', '2026-07-27 04:54:28', '2026-07-27 04:54:28');

-- --------------------------------------------------------

--
-- Struktur dari tabel `penilaian_details`
--

CREATE TABLE `penilaian_details` (
  `id` bigint UNSIGNED NOT NULL,
  `penilaian_id` bigint UNSIGNED NOT NULL,
  `kriteria_komponen_id` bigint UNSIGNED NOT NULL,
  `nilai` tinyint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `penilaian_details`
--

INSERT INTO `penilaian_details` (`id`, `penilaian_id`, `kriteria_komponen_id`, `nilai`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 99, '2026-07-27 04:06:34', '2026-07-27 04:06:34'),
(2, 2, 3, 78, '2026-07-27 04:54:28', '2026-07-27 06:45:43'),
(3, 2, 4, 88, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(4, 2, 5, 88, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(5, 3, 3, 92, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(6, 3, 4, 92, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(7, 3, 5, 92, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(8, 4, 3, 84, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(9, 4, 4, 84, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(10, 4, 5, 84, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(11, 5, 3, 86, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(12, 5, 4, 86, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(13, 5, 5, 86, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(14, 6, 3, 79, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(15, 6, 4, 79, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(16, 6, 5, 79, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(17, 7, 3, 81, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(18, 7, 4, 81, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(19, 7, 5, 81, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(20, 8, 6, 90, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(21, 8, 7, 90, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(22, 8, 8, 90, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(23, 9, 6, 94, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(24, 9, 7, 94, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(25, 9, 8, 94, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(26, 10, 6, 87, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(27, 10, 7, 87, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(28, 10, 8, 87, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(29, 11, 6, 89, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(30, 11, 7, 89, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(31, 11, 8, 89, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(32, 12, 6, 77, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(33, 12, 7, 77, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(34, 12, 8, 77, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(35, 13, 6, 79, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(36, 13, 7, 79, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(37, 13, 8, 79, '2026-07-27 04:54:28', '2026-07-27 04:54:28');

-- --------------------------------------------------------

--
-- Struktur dari tabel `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'web', '2026-07-22 08:42:07', '2026-07-22 08:42:07'),
(2, 'juri', 'web', '2026-07-22 08:42:07', '2026-07-22 08:42:07'),
(3, 'operator-sekolah', 'web', '2026-07-22 08:42:07', '2026-07-22 08:42:07');

-- --------------------------------------------------------

--
-- Struktur dari tabel `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('4Lmk1kFrGBCrbeofmzjqTTXtLpfw2WLRuTKh40n8', 6, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiIyUUhYWjRvaFc3VVJCNk9rRVM1Q0liUnJ0aWtmUmpBdUxpa1B3d3VpIiwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119LCJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI6NiwicGFzc3dvcmRfaGFzaF9zYW5jdHVtIjoiYmNmY2FiMzNiZGViYTIyYzMyYWMxMmVjM2M4ODk3ZTAwZWQxNTZhYzhmMDAyYzQyMDBmNDQ3ZTJlMjE0Yjk4YiIsIl9wcmV2aW91cyI6eyJ1cmwiOiJodHRwOlwvXC8xMjcuMC4wLjE6ODAwMFwvanVyaVwvcmVrYXAiLCJyb3V0ZSI6Imp1cmkucGVuaWxhaWFuLnJla2FwIn19', 1785161884),
('djm5s6B4S8N6ADtgCyXQjKPG5MzUXf4Xhpo7G7NG', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJFN0NaSnlrNVA3V3JWeVQwVmRDYmk4akQwQ2NzWDlXc2w2elNGWmQ1IiwidXJsIjp7ImludGVuZGVkIjoiaHR0cDpcL1wvMTI3LjAuMC4xOjgwMDBcL2p1cmlcL3Jla2FwIn0sIl9wcmV2aW91cyI6eyJ1cmwiOiJodHRwOlwvXC8xMjcuMC4wLjE6ODAwMFwvbG9naW4iLCJyb3V0ZSI6ImxvZ2luIn0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1785183474),
('SUcYf9VC6ljOz1tkwPnBDVyBK96zZNgxqL92SDZ1', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJrYVp2bjdWN3VKcDkzajlvS1VqTFNUaUNsMXM1dVFiaVF3Ym1MUHlUIiwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119LCJ1cmwiOnsiaW50ZW5kZWQiOiJodHRwOlwvXC8xMjcuMC4wLjE6ODAwMFwvYWRtaW5cL2tyaXRlcmlhcyJ9LCJfcHJldmlvdXMiOnsidXJsIjoiaHR0cDpcL1wvMTI3LjAuMC4xOjgwMDAiLCJyb3V0ZSI6InB1Ymxpay5sYW5kaW5nIn19', 1785183473),
('vtHaqIwJiQ42cMBJSv759NyAp9wn5FXMXXYmXuYt', 8, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJHdjBINzlBTk14dkxjWmEwT3FVRE8zWTB2NmRBZG9FUTZKbk5aT09OIiwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119LCJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI6OCwicGFzc3dvcmRfaGFzaF9zYW5jdHVtIjoiYmNmY2FiMzNiZGViYTIyYzMyYWMxMmVjM2M4ODk3ZTAwZWQxNTZhYzhmMDAyYzQyMDBmNDQ3ZTJlMjE0Yjk4YiIsIl9wcmV2aW91cyI6eyJ1cmwiOiJodHRwOlwvXC8xMjcuMC4wLjE6ODAwMFwvc2Vrb2xhaFwva29udGluZ2VuXC84XC9hbG9rYXNpIiwicm91dGUiOiJzZWtvbGFoLmFsb2thc2kuaW5kZXgifX0=', 1785162374);

-- --------------------------------------------------------

--
-- Struktur dari tabel `siswas`
--

CREATE TABLE `siswas` (
  `id` bigint UNSIGNED NOT NULL,
  `kontingen_id` bigint UNSIGNED NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nisn` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jenis_kelamin` enum('L','P') COLLATE utf8mb4_unicode_ci NOT NULL,
  `tempat_lahir` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `alamat` text COLLATE utf8mb4_unicode_ci,
  `nama_orang_tua` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_telp` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jenjang_pendidikan` enum('SD','MI','SMP','MTs','SMA','MA','SMK') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `golongan_pramuka` enum('siaga','penggalang','penegak','pandega') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `golongan_darah` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_verifikasi` enum('pending','approved','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `catatan_verifikasi` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `siswas`
--

INSERT INTO `siswas` (`id`, `kontingen_id`, `nama`, `nisn`, `jenis_kelamin`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `nama_orang_tua`, `no_telp`, `jenjang_pendidikan`, `golongan_pramuka`, `golongan_darah`, `status_verifikasi`, `catatan_verifikasi`, `created_at`, `updated_at`) VALUES
(3, 2, 'Ahmad Fauzi', '0011223301', 'L', 'Jepara', '2011-03-12', 'Desa Tahunan RT 02/01, Jepara', 'Bpk. Sulaiman', '081225001001', 'MTs', 'penggalang', 'A', 'approved', NULL, '2026-07-23 20:02:51', '2026-07-27 02:40:43'),
(4, 2, 'Siti Nurhaliza', '0011223302', 'P', 'Jepara', '2011-07-25', 'Desa Mulyoharjo RT 01/03, Jepara', 'Bpk. Ahmad Daroji', '081225001002', 'MTs', 'penggalang', 'B', 'approved', NULL, '2026-07-23 20:02:51', '2026-07-27 02:41:12'),
(5, 2, 'Muhammad Rizky', '0011223303', 'L', 'Kudus', '2010-11-08', 'Desa Ngabul RT 04/02, Jepara', 'Bpk. Hasanudin', '081225001003', 'MTs', 'penggalang', 'O', 'approved', NULL, '2026-07-23 20:02:51', '2026-07-27 02:41:06'),
(6, 2, 'Dewi Lestari', '0011223304', 'P', 'Jepara', '2011-01-19', 'Desa Purwogondo RT 02/04, Jepara', 'Ibu Siti Aminah', '081225001004', 'MTs', 'penggalang', 'AB', 'approved', NULL, '2026-07-23 20:02:51', '2026-07-27 02:40:45'),
(7, 2, 'Abdul Rohman', '0011223305', 'L', 'Jepara', '2010-09-30', 'Desa Krapyak RT 03/01, Jepara', 'Bpk. Masrukin', '081225001005', 'MTs', 'penggalang', 'A', 'approved', NULL, '2026-07-23 20:02:51', '2026-07-27 02:40:39'),
(8, 2, 'Fitri Handayani', '0011223306', 'P', 'Demak', '2011-05-14', 'Desa Bandengan RT 01/02, Jepara', 'Bpk. Nur Kholis', '081225001006', 'MTs', 'penggalang', 'B', 'approved', NULL, '2026-07-23 20:02:51', '2026-07-27 02:40:53'),
(9, 2, 'Zainal Abidin', '0011223307', 'L', 'Jepara', '2010-12-03', 'Desa Wonorejo RT 05/03, Jepara', 'Bpk. Fatchur Rozi', '081225001007', 'MTs', 'penggalang', 'O', 'approved', NULL, '2026-07-23 20:02:51', '2026-07-27 02:43:45'),
(10, 2, 'Nur Aisyah', '0011223308', 'P', 'Jepara', '2011-08-21', 'Desa Kedungcino RT 02/01, Jepara', 'Ibu Maryatun', '081225001008', 'MTs', 'penggalang', 'A', 'approved', NULL, '2026-07-23 20:02:51', '2026-07-27 02:41:09'),
(11, 2, 'Ilham Maulana', '0011223309', 'L', 'Jepara', '2011-02-17', 'Desa Saripan RT 03/02, Jepara', 'Bpk. Slamet Riyadi', '081225001009', 'MTs', 'penggalang', 'B', 'approved', NULL, '2026-07-23 20:02:51', '2026-07-27 02:40:58'),
(12, 2, 'Khoirun Nisa', '0011223310', 'P', 'Pati', '2010-10-09', 'Desa Jobokuto RT 01/01, Jepara', 'Bpk. Ahmad Muzaki', '081225001010', 'MTs', 'penggalang', 'O', 'approved', NULL, '2026-07-23 20:02:51', '2026-07-27 02:41:01'),
(14, 2, 'imam', '44324', 'L', 'jdd', NULL, 'dwdwd', 'dddd', '3', 'MA', NULL, 'A', 'approved', NULL, '2026-07-26 10:46:37', '2026-07-26 11:06:06'),
(15, 3, 'Siswa Dummy 1', '00310000', 'L', 'Jepara', '2011-05-12', 'Jl. Pramuka', 'Orang Tua 1', '081300000001', 'MTs', 'penggalang', 'O', 'approved', NULL, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(16, 3, 'Siswa Dummy 2', '00320000', 'P', 'Jepara', '2011-05-13', 'Jl. Pramuka', 'Orang Tua 2', '081300000002', 'MTs', 'penggalang', 'O', 'approved', NULL, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(17, 3, 'Siswa Dummy 3', '00330000', 'L', 'Jepara', '2011-05-14', 'Jl. Pramuka', 'Orang Tua 3', '081300000003', 'MTs', 'penggalang', 'O', 'approved', NULL, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(18, 3, 'Siswa Dummy 4', '00340000', 'P', 'Jepara', '2011-05-15', 'Jl. Pramuka', 'Orang Tua 4', '081300000004', 'MTs', 'penggalang', 'O', 'approved', NULL, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(19, 4, 'Siswa Dummy 1', '00410000', 'L', 'Jepara', '2011-05-12', 'Jl. Pramuka', 'Orang Tua 1', '081300000001', 'MTs', 'penggalang', 'O', 'approved', NULL, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(20, 4, 'Siswa Dummy 2', '00420000', 'P', 'Jepara', '2011-05-13', 'Jl. Pramuka', 'Orang Tua 2', '081300000002', 'MTs', 'penggalang', 'O', 'approved', NULL, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(21, 4, 'Siswa Dummy 3', '00430000', 'L', 'Jepara', '2011-05-14', 'Jl. Pramuka', 'Orang Tua 3', '081300000003', 'MTs', 'penggalang', 'O', 'approved', NULL, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(22, 4, 'Siswa Dummy 4', '00440000', 'P', 'Jepara', '2011-05-15', 'Jl. Pramuka', 'Orang Tua 4', '081300000004', 'MTs', 'penggalang', 'O', 'approved', NULL, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(23, 5, 'Siswa Dummy 1', '00510000', 'L', 'Jepara', '2011-05-12', 'Jl. Pramuka', 'Orang Tua 1', '081300000001', 'MTs', 'penggalang', 'O', 'approved', NULL, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(24, 5, 'Siswa Dummy 2', '00520000', 'P', 'Jepara', '2011-05-13', 'Jl. Pramuka', 'Orang Tua 2', '081300000002', 'MTs', 'penggalang', 'O', 'approved', NULL, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(25, 5, 'Siswa Dummy 3', '00530000', 'L', 'Jepara', '2011-05-14', 'Jl. Pramuka', 'Orang Tua 3', '081300000003', 'MTs', 'penggalang', 'O', 'approved', NULL, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(26, 5, 'Siswa Dummy 4', '00540000', 'P', 'Jepara', '2011-05-15', 'Jl. Pramuka', 'Orang Tua 4', '081300000004', 'MTs', 'penggalang', 'O', 'approved', NULL, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(27, 7, 'Siswa Dummy 1', '00710000', 'L', 'Jepara', '2011-05-12', 'Jl. Pramuka', 'Orang Tua 1', '081300000001', 'MTs', 'penggalang', 'O', 'pending', NULL, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(28, 7, 'Siswa Dummy 2', '00720000', 'P', 'Jepara', '2011-05-13', 'Jl. Pramuka', 'Orang Tua 2', '081300000002', 'MTs', 'penggalang', 'O', 'pending', NULL, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(29, 8, 'imam', '6888', 'L', 'Jakarta', '2006-10-17', 'Jepara', 'Budi', '087767665455', 'MA', 'penegak', 'AB', 'approved', NULL, '2026-07-27 05:19:41', '2026-07-27 05:36:53'),
(30, 8, 'Budi', '8998989', 'L', 'Jepara', '2007-05-07', 'Jl. sudirman Jkarta', 'Tono', '08774776722', NULL, 'penegak', 'B', 'approved', NULL, '2026-07-27 05:20:50', '2026-07-27 05:36:49');

-- --------------------------------------------------------

--
-- Struktur dari tabel `teams`
--

CREATE TABLE `teams` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `npsn` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jenjang` enum('SD','MI','SMP','MTs','SMA','MA','SMK') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alamat` text COLLATE utf8mb4_unicode_ci,
  `no_telp` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `personal_team` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `teams`
--

INSERT INTO `teams` (`id`, `user_id`, `name`, `npsn`, `jenjang`, `alamat`, `no_telp`, `logo_path`, `personal_team`, `created_at`, `updated_at`) VALUES
(1, 4, 'MTS JEPARA', '2929292', 'MTs', 'Jl.jepara', '087738117167', NULL, 0, '2026-07-22 11:04:10', '2026-07-22 11:04:10'),
(2, 5, 'ethtrrj', '12345432', 'SMK', 'uktktktu', '5432456543', NULL, 0, '2026-07-22 13:05:56', '2026-07-22 13:05:56'),
(3, 8, 'MTs NU Jepara', '20318001', 'MTs', 'Jl. Pramuka, Jepara', '081200008001', NULL, 0, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(4, 9, 'MA NU Kudus', '20318002', 'MA', 'Jl. Pramuka, Kudus', '081200008002', NULL, 0, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(5, 10, 'SMP NU Demak', '20318003', 'SMP', 'Jl. Pramuka, Demak', '081200008003', NULL, 0, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(6, 11, 'MI NU Pati', '20318004', 'MI', 'Jl. Pramuka, Pati', '081200008004', NULL, 0, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(7, 12, 'MTs NU Rembang', '20318005', 'MTs', 'Jl. Pramuka, Rembang', '081200008005', NULL, 0, '2026-07-27 04:54:28', '2026-07-27 04:54:28');

-- --------------------------------------------------------

--
-- Struktur dari tabel `team_invitations`
--

CREATE TABLE `team_invitations` (
  `id` bigint UNSIGNED NOT NULL,
  `team_id` bigint UNSIGNED NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `team_user`
--

CREATE TABLE `team_user` (
  `id` bigint UNSIGNED NOT NULL,
  `team_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_hp` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `two_factor_secret` text COLLATE utf8mb4_unicode_ci,
  `two_factor_recovery_codes` text COLLATE utf8mb4_unicode_ci,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_team_id` bigint UNSIGNED DEFAULT NULL,
  `profile_photo_path` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `no_hp`, `is_active`, `email_verified_at`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `two_factor_confirmed_at`, `remember_token`, `current_team_id`, `profile_photo_path`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'admin@persimanu.test', NULL, 1, NULL, '$2y$12$NZWOBo11sg5PX.Useu8k.u2yKMNXYw1T0xa62oHfGy5ABHAZYRp1O', NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-22 08:42:07', '2026-07-22 08:42:07'),
(2, 'Imam ganteng', 'khoirulimam7@gmail.com', '08776678876', 1, NULL, '$2y$12$CNLKAMxfeOjnivZ4wPCEb.bqhhtwyrcvQQ2WnP1e6PNCeCRjXIdYK', NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-22 09:05:53', '2026-07-22 09:41:52'),
(3, 'Irul', 'khoirulimam76@gmail.com', '0877338117156', 1, NULL, '$2y$12$p51yH8ctEDDlsRkiFBoVaeYDwYpGV3no4GRhqCwYqP9SUpFR9PTDa', NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-22 09:41:41', '2026-07-23 13:14:40'),
(4, 'Khoirul imam fazri', 'khoirulimam795@gmail.com', '087738117167', 1, NULL, '$2y$12$CbKRsS6oM88OG0uLWbWxaOlgQo25N978fZpfNpyvTOJFlOTNSoxOy', NULL, NULL, NULL, NULL, 1, NULL, '2026-07-22 11:04:10', '2026-07-22 11:04:10'),
(5, 'Khoirul imam fazri', 'khoirulimam5@gmail.com', '5432456543', 1, NULL, '$2y$12$OlOiyWpJPxc7hE7ak/OVMercg7PoQHsbm61c.Zi9as5bw7Av7qExO', NULL, NULL, NULL, NULL, 2, NULL, '2026-07-22 13:05:56', '2026-07-22 13:05:56'),
(6, 'Juri Satu', 'juri1@dummy.test', '081100000001', 1, '2026-07-27 04:54:28', '$2y$12$6.EfHl5mF9WZDc73Ak9B5.tG8TXUhK2KBo8FulvFbajloF2Lkpec2', NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(7, 'Juri Dua', 'juri2@dummy.test', '081100000002', 1, '2026-07-27 04:54:28', '$2y$12$6.EfHl5mF9WZDc73Ak9B5.tG8TXUhK2KBo8FulvFbajloF2Lkpec2', NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(8, 'Operator MTs NU Jepara', 'op0@dummy.test', '081200008001', 1, '2026-07-27 04:54:28', '$2y$12$6.EfHl5mF9WZDc73Ak9B5.tG8TXUhK2KBo8FulvFbajloF2Lkpec2', NULL, NULL, NULL, NULL, 3, NULL, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(9, 'Operator MA NU Kudus', 'op1@dummy.test', '081200008002', 1, '2026-07-27 04:54:28', '$2y$12$6.EfHl5mF9WZDc73Ak9B5.tG8TXUhK2KBo8FulvFbajloF2Lkpec2', NULL, NULL, NULL, NULL, 4, NULL, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(10, 'Operator SMP NU Demak', 'op2@dummy.test', '081200008003', 1, '2026-07-27 04:54:28', '$2y$12$6.EfHl5mF9WZDc73Ak9B5.tG8TXUhK2KBo8FulvFbajloF2Lkpec2', NULL, NULL, NULL, NULL, 5, NULL, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(11, 'Operator MI NU Pati', 'op3@dummy.test', '081200008004', 1, '2026-07-27 04:54:28', '$2y$12$6.EfHl5mF9WZDc73Ak9B5.tG8TXUhK2KBo8FulvFbajloF2Lkpec2', NULL, NULL, NULL, NULL, 6, NULL, '2026-07-27 04:54:28', '2026-07-27 04:54:28'),
(12, 'Operator MTs NU Rembang', 'op4@dummy.test', '081200008005', 1, '2026-07-27 04:54:28', '$2y$12$6.EfHl5mF9WZDc73Ak9B5.tG8TXUhK2KBo8FulvFbajloF2Lkpec2', NULL, NULL, NULL, NULL, 7, NULL, '2026-07-27 04:54:28', '2026-07-27 04:54:28');

-- --------------------------------------------------------

--
-- Struktur dari tabel `verifikasi_items`
--

CREATE TABLE `verifikasi_items` (
  `id` bigint UNSIGNED NOT NULL,
  `kontingen_id` bigint UNSIGNED NOT NULL,
  `item_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_id` bigint UNSIGNED NOT NULL,
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `catatan` text COLLATE utf8mb4_unicode_ci,
  `verified_by` bigint UNSIGNED DEFAULT NULL,
  `verified_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indeks untuk tabel yang dibuang
--

--
-- Indeks untuk tabel `activity_log`
--
ALTER TABLE `activity_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subject` (`subject_type`,`subject_id`),
  ADD KEY `causer` (`causer_type`,`causer_id`),
  ADD KEY `activity_log_log_name_index` (`log_name`);

--
-- Indeks untuk tabel `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indeks untuk tabel `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indeks untuk tabel `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`),
  ADD KEY `failed_jobs_connection_queue_failed_at_index` (`connection`,`queue`,`failed_at`);

--
-- Indeks untuk tabel `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indeks untuk tabel `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `juaras`
--
ALTER TABLE `juaras`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `juaras_lomba_kontingen_golongan_unique` (`lomba_id`,`kontingen_id`,`golongan`),
  ADD KEY `juaras_kontingen_id_foreign` (`kontingen_id`),
  ADD KEY `juaras_event_id_golongan_index` (`event_id`,`golongan`),
  ADD KEY `juaras_event_id_medali_index` (`event_id`,`medali`);

--
-- Indeks untuk tabel `kontingens`
--
ALTER TABLE `kontingens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `kontingens_event_team_unique` (`event_id`,`team_id`),
  ADD KEY `fk_kontingens_approved_by` (`approved_by`),
  ADD KEY `kontingens_team_id_status_index` (`team_id`,`status`);

--
-- Indeks untuk tabel `kriteria_komponens`
--
ALTER TABLE `kriteria_komponens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kriteria_komponens_lomba_id_golongan_index` (`lomba_id`,`golongan`);

--
-- Indeks untuk tabel `lombas`
--
ALTER TABLE `lombas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `lombas_slug_unique` (`slug`),
  ADD KEY `lombas_event_id_foreign` (`event_id`),
  ADD KEY `lombas_created_by_foreign` (`created_by`);

--
-- Indeks untuk tabel `lomba_juri`
--
ALTER TABLE `lomba_juri`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `lomba_juri_lomba_id_juri_id_unique` (`lomba_id`,`juri_id`),
  ADD KEY `lomba_juri_juri_id_foreign` (`juri_id`);

--
-- Indeks untuk tabel `lomba_kontingen`
--
ALTER TABLE `lomba_kontingen`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `lomba_kontingen_lomba_kontingen_golongan_unique` (`lomba_id`,`kontingen_id`,`golongan`),
  ADD KEY `lomba_kontingen_lomba_id_golongan_index` (`lomba_id`,`golongan`),
  ADD KEY `lomba_kontingen_kontingen_id_golongan_index` (`kontingen_id`,`golongan`),
  ADD KEY `lomba_kontingen_pendamping_id_foreign` (`pendamping_id`);

--
-- Indeks untuk tabel `lomba_kontingen_siswa`
--
ALTER TABLE `lomba_kontingen_siswa`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `lks_alokasi_siswa_unique` (`lomba_kontingen_id`,`siswa_id`),
  ADD KEY `lomba_kontingen_siswa_siswa_id_index` (`siswa_id`);

--
-- Indeks untuk tabel `lomba_peserta`
--
ALTER TABLE `lomba_peserta`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `media_uuid_unique` (`uuid`),
  ADD KEY `media_model_type_model_id_index` (`model_type`,`model_id`),
  ADD KEY `media_order_column_index` (`order_column`);

--
-- Indeks untuk tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indeks untuk tabel `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indeks untuk tabel `passkeys`
--
ALTER TABLE `passkeys`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `passkeys_credential_id_unique` (`credential_id`),
  ADD KEY `passkeys_user_id_index` (`user_id`);

--
-- Indeks untuk tabel `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indeks untuk tabel `pendampings`
--
ALTER TABLE `pendampings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pendampings_kontingen_id_foreign` (`kontingen_id`);

--
-- Indeks untuk tabel `penilaians`
--
ALTER TABLE `penilaians`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `penilaians_lomba_kontingen_juri_golongan_unique` (`lomba_id`,`kontingen_id`,`juri_id`,`golongan`),
  ADD KEY `penilaians_juri_id_foreign` (`juri_id`),
  ADD KEY `penilaians_lomba_id_golongan_index` (`lomba_id`,`golongan`),
  ADD KEY `penilaians_kontingen_id_golongan_index` (`kontingen_id`,`golongan`);

--
-- Indeks untuk tabel `penilaian_details`
--
ALTER TABLE `penilaian_details`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `penilaian_details_penilaian_kriteria_unique` (`penilaian_id`,`kriteria_komponen_id`),
  ADD KEY `penilaian_details_kriteria_komponen_id_foreign` (`kriteria_komponen_id`);

--
-- Indeks untuk tabel `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indeks untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indeks untuk tabel `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indeks untuk tabel `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indeks untuk tabel `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indeks untuk tabel `siswas`
--
ALTER TABLE `siswas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `siswas_kontingen_id_foreign` (`kontingen_id`);

--
-- Indeks untuk tabel `teams`
--
ALTER TABLE `teams`
  ADD PRIMARY KEY (`id`),
  ADD KEY `teams_user_id_index` (`user_id`);

--
-- Indeks untuk tabel `team_invitations`
--
ALTER TABLE `team_invitations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `team_invitations_team_id_email_unique` (`team_id`,`email`);

--
-- Indeks untuk tabel `team_user`
--
ALTER TABLE `team_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `team_user_team_id_user_id_unique` (`team_id`,`user_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indeks untuk tabel `verifikasi_items`
--
ALTER TABLE `verifikasi_items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `verifikasi_items_kontingen_item_unique` (`kontingen_id`,`item_type`,`item_id`),
  ADD KEY `verifikasi_items_verified_by_foreign` (`verified_by`),
  ADD KEY `verifikasi_items_item_type_item_id_index` (`item_type`,`item_id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `activity_log`
--
ALTER TABLE `activity_log`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `events`
--
ALTER TABLE `events`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `juaras`
--
ALTER TABLE `juaras`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `kontingens`
--
ALTER TABLE `kontingens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `kriteria_komponens`
--
ALTER TABLE `kriteria_komponens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `lombas`
--
ALTER TABLE `lombas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `lomba_juri`
--
ALTER TABLE `lomba_juri`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `lomba_kontingen`
--
ALTER TABLE `lomba_kontingen`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `lomba_kontingen_siswa`
--
ALTER TABLE `lomba_kontingen_siswa`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT untuk tabel `lomba_peserta`
--
ALTER TABLE `lomba_peserta`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `media`
--
ALTER TABLE `media`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT untuk tabel `passkeys`
--
ALTER TABLE `passkeys`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `pendampings`
--
ALTER TABLE `pendampings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `penilaians`
--
ALTER TABLE `penilaians`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT untuk tabel `penilaian_details`
--
ALTER TABLE `penilaian_details`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT untuk tabel `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `siswas`
--
ALTER TABLE `siswas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT untuk tabel `teams`
--
ALTER TABLE `teams`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `team_invitations`
--
ALTER TABLE `team_invitations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `team_user`
--
ALTER TABLE `team_user`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT untuk tabel `verifikasi_items`
--
ALTER TABLE `verifikasi_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `juaras`
--
ALTER TABLE `juaras`
  ADD CONSTRAINT `juaras_event_id_foreign` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `juaras_kontingen_id_foreign` FOREIGN KEY (`kontingen_id`) REFERENCES `kontingens` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `juaras_lomba_id_foreign` FOREIGN KEY (`lomba_id`) REFERENCES `lombas` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `kontingens`
--
ALTER TABLE `kontingens`
  ADD CONSTRAINT `fk_kontingens_approved_by` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_kontingens_event_id` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_kontingens_team_id` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `kriteria_komponens`
--
ALTER TABLE `kriteria_komponens`
  ADD CONSTRAINT `kriteria_komponens_lomba_id_foreign` FOREIGN KEY (`lomba_id`) REFERENCES `lombas` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `lombas`
--
ALTER TABLE `lombas`
  ADD CONSTRAINT `lombas_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `lombas_event_id_foreign` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `lomba_juri`
--
ALTER TABLE `lomba_juri`
  ADD CONSTRAINT `lomba_juri_juri_id_foreign` FOREIGN KEY (`juri_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `lomba_juri_lomba_id_foreign` FOREIGN KEY (`lomba_id`) REFERENCES `lombas` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `lomba_kontingen`
--
ALTER TABLE `lomba_kontingen`
  ADD CONSTRAINT `lomba_kontingen_kontingen_id_foreign` FOREIGN KEY (`kontingen_id`) REFERENCES `kontingens` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `lomba_kontingen_lomba_id_foreign` FOREIGN KEY (`lomba_id`) REFERENCES `lombas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `lomba_kontingen_pendamping_id_foreign` FOREIGN KEY (`pendamping_id`) REFERENCES `pendampings` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `lomba_kontingen_siswa`
--
ALTER TABLE `lomba_kontingen_siswa`
  ADD CONSTRAINT `lomba_kontingen_siswa_lomba_kontingen_id_foreign` FOREIGN KEY (`lomba_kontingen_id`) REFERENCES `lomba_kontingen` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `lomba_kontingen_siswa_siswa_id_foreign` FOREIGN KEY (`siswa_id`) REFERENCES `siswas` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `passkeys`
--
ALTER TABLE `passkeys`
  ADD CONSTRAINT `passkeys_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `pendampings`
--
ALTER TABLE `pendampings`
  ADD CONSTRAINT `pendampings_kontingen_id_foreign` FOREIGN KEY (`kontingen_id`) REFERENCES `kontingens` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `penilaians`
--
ALTER TABLE `penilaians`
  ADD CONSTRAINT `penilaians_juri_id_foreign` FOREIGN KEY (`juri_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `penilaians_kontingen_id_foreign` FOREIGN KEY (`kontingen_id`) REFERENCES `kontingens` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `penilaians_lomba_id_foreign` FOREIGN KEY (`lomba_id`) REFERENCES `lombas` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `penilaian_details`
--
ALTER TABLE `penilaian_details`
  ADD CONSTRAINT `penilaian_details_kriteria_komponen_id_foreign` FOREIGN KEY (`kriteria_komponen_id`) REFERENCES `kriteria_komponens` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `penilaian_details_penilaian_id_foreign` FOREIGN KEY (`penilaian_id`) REFERENCES `penilaians` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `siswas`
--
ALTER TABLE `siswas`
  ADD CONSTRAINT `siswas_kontingen_id_foreign` FOREIGN KEY (`kontingen_id`) REFERENCES `kontingens` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `team_invitations`
--
ALTER TABLE `team_invitations`
  ADD CONSTRAINT `team_invitations_team_id_foreign` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `verifikasi_items`
--
ALTER TABLE `verifikasi_items`
  ADD CONSTRAINT `verifikasi_items_kontingen_id_foreign` FOREIGN KEY (`kontingen_id`) REFERENCES `kontingens` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `verifikasi_items_verified_by_foreign` FOREIGN KEY (`verified_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
