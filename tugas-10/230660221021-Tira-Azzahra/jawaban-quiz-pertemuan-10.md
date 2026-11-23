#### `jawaban-quiz-pertemuan-10.md`
```markdown
# Jawaban Quiz Pertemuan 10 — Integrasi Data dan Proses Bisnis Sistem Informasi

- **Nama:** Tira Azzahra
- **NIM:** 230660221021
- **Kelas:** SI-VIIA
- **Domain Project:** SI Perpustakaan Kampus (Pengajuan Peminjaman Buku)

## Soal 1 — Integrasi Data
Integrasi data pada aplikasi mobile adalah proses menggabungkan data dari beberapa sumber endpoint REST API agar membentuk satu kesatuan informasi proses bisnis yang utuh di antarmuka aplikasi. Contohnya pada **SI Perpustakaan Kampus**: daftar pengajuan peminjaman buku dari endpoint `/posts` digabungkan dengan profil mahasiswa peminjam dari endpoint `/users` sehingga petugas maupun mahasiswa dapat melihat nama peminjam beserta buku yang diajukan dalam satu kartu. Identifier yang menghubungkan kedua data tersebut adalah `userId` (foreign key pada model `PengajuanBuku`) yang dicocokkan dengan `id` (primary key pada model `AnggotaPerpustakaan`).

## Soal 2 — `Future.wait`
`Future.wait` digunakan ketika beberapa request HTTP tidak saling bergantung satu sama lain sehingga dapat dijalankan secara paralel untuk menghemat waktu tunggu jaringan, misalnya mengambil daftar anggota (`/users`) dan daftar pengajuan buku (`/posts`) secara bersamaan. Sebaliknya, request wajib dijalankan secara berurutan (sequential dengan `await` satu per satu) apabila request kedua membutuhkan parameter atau identifier yang baru diperoleh dari hasil response request pertama (contoh: login untuk mendapatkan `userId` anggota terlebih dahulu sebelum mengambil riwayat peminjaman khusus anggota tersebut).

## Soal 3 — Model dan `fromJson`
Model `PengajuanBuku` (atau `DataPengajuan`) membutuhkan field `id` (ID transaksi), `userId` (identifier penghubung ke anggota perpustakaan), `judulBuku` (informasi buku yang dipinjam), serta `status` proses bisnis (`menunggu`, `disetujui`, `ditolak`). Untuk menangani field yang tidak tersedia atau bernilai `null` pada response JSON, factory `fromJson` menggunakan operator *null-aware* (`??`) untuk memberikan nilai default yang aman (seperti `json['userId'] as int? ?? 0` atau `json['status'] as String? ?? 'menunggu'`) agar aplikasi tidak mengalami *runtime type error*.

## Soal 4 — Service Layer
Service layer (`PerpustakaanService`) bertanggung jawab menangani komunikasi jaringan HTTP (`http.get`), validasi status code, penanganan timeout, parsing JSON menjadi model Dart, serta menggabungkan data antar-endpoint; sedangkan widget (`HalamanPeminjamanTerintegrasi`) hanya bertanggung jawab merender tampilan sesuai state. Penggabungan data tidak boleh ditulis langsung di dalam widget agar kode UI tetap bersih, mudah diuji secara terpisah, serta mencegah logika penggabungan data dieksekusi ulang setiap kali widget mengalami *rebuild*.

## Soal 5 — Status Halaman
Halaman integrasi data perlu menangani empat state utama: **loading** (saat request ke API sedang berjalan), **sukses/data tersedia** (menampilkan `ListView` pengajuan buku), **data kosong** (*empty state* ketika daftar pengajuan berjumlah nol), dan **error** (menampilkan pesan kegagalan beserta tombol **Coba Lagi**). Kondisi data kosong wajib dibedakan dari kondisi error karena data kosong menandakan komunikasi ke server berhasil dengan HTTP 200 tetapi memang belum ada transaksi peminjaman buku, sedangkan error menandakan gangguan teknis (jaringan terputus, timeout, atau server bermasalah) yang memerlukan tindakan pemulihan.