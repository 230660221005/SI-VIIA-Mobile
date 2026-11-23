# Tugas 10 — Integrasi Data dan Proses Bisnis

- **Nama:** Tira Azzahra
- **NIM:** 230660221021
- **Kelas:** SI-VIIA
- **Domain:** SI Perpustakaan Kampus (Pengajuan Peminjaman Buku)

## Endpoint dan Metode HTTP
Aplikasi mengintegrasikan dua endpoint REST API simulasi publik (`https://jsonplaceholder.typicode.com`):
1. `GET /users` — Mengambil daftar data anggota perpustakaan (mahasiswa peminjam).
2. `GET /posts` — Mengambil daftar pengajuan peminjaman buku.

## Pemetaan Field JSON ke Model Dart

| Endpoint | Key JSON | Field Model Dart | Tipe Data | Keterangan |
|:---|:---|:---|:---|:---|
| `/users` | `id` | `AnggotaPerpustakaan.id` | `int` | Primary key anggota perpustakaan |
| `/users` | `name` | `AnggotaPerpustakaan.nama` | `String` | Nama lengkap mahasiswa peminjam |
| `/users` | `email` | `AnggotaPerpustakaan.email` | `String` | Email mahasiswa peminjam |
| `/posts` | `id` | `PengajuanBuku.id` | `int` | Primary key transaksi pengajuan buku |
| `/posts` | `userId` | `PengajuanBuku.userId` | `int` | Foreign key penghubung ke `AnggotaPerpustakaan.id` |
| `/posts` | `title` | `PengajuanBuku.judulBuku` | `String` | Judul buku yang diajukan untuk dipinjam |
| `/posts` | `body` | `PengajuanBuku.catatanKeperluan` | `String` | Catatan keperluan peminjaman buku |
| `/posts` | *(simulasi)* | `PengajuanBuku.status` | `String` | Status proses bisnis (`menunggu`, `disetujui`, `ditolak`) |

## Identifier Penghubung & Alasan `Future.wait`
- **Identifier:** `userId` pada `PengajuanBuku` dicocokkan dengan `id` pada `AnggotaPerpustakaan` menggunakan `Map<int, AnggotaPerpustakaan>` agar pencocokan data peminjam berjalan efisien dalam waktu $O(1)$.
- **Penggunaan `Future.wait`:** Endpoint `/users` dan `/posts` bersifat independen (tidak saling bergantung saat request dilakukan), sehingga dieksekusi secara paralel menggunakan `Future.wait` untuk mempercepat pemuatan daftar peminjaman dibanding memanggilnya secara berurutan.

## Cara Menjalankan
1. Buat project Flutter atau gunakan project pengujian: `flutter create app_uji && cd app_uji && flutter pub add http`
2. Salin folder `models/`, `services/`, dan `main.dart` ke dalam folder `lib/` project Flutter.
3. Jalankan perintah `flutter analyze` lalu `flutter run -d chrome`.

## Batasan API Simulasi
API publik `jsonplaceholder.typicode.com` tidak memiliki field `status` peminjaman buku maupun katalog judul buku secara spesifik, sehingga field `title` dipetakan sebagai judul buku yang diajukan dan `status` (`menunggu`, `disetujui`, `ditolak`) disimulasikan di dalam `PengajuanBuku.fromJson`.