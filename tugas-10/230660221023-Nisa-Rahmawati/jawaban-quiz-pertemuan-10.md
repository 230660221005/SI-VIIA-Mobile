# Jawaban Quiz Pertemuan 10 — Integrasi Data dan Proses Bisnis Sistem Informasi

- **Nama:** Nisa Rahmawati
- **NIM:** 230660221023
- **Kelas:** SI-VIIA
- **Mata Kuliah:** Pemrograman Aplikasi Bergerak

---

### Soal 1 — Integrasi Data

**Pengertian:**
Integrasi data pada aplikasi mobile adalah proses menggabungkan, menyelaraskan, dan menyajikan data yang berasal dari dua atau lebih sumber/endpoint REST API yang terpisah ke dalam satu struktur informasi yang utuh agar mendukung alur proses bisnis pengguna secara lengkap.

**Contoh pada Project Sistem Informasi Perpustakaan Kampus:**
Pada fitur **Daftar Transaksi Peminjaman Buku**, aplikasi menggabungkan data master mahasiswa peminjam dari endpoint `/users` (`AnggotaModel`) dengan data transaksi peminjaman buku dari endpoint `/todos` (`PeminjamanModel`) menjadi `DetailPeminjamanModel`. Dengan integrasi ini, petugas perpustakaan dapat langsung melihat judul buku, status peminjaman, sekaligus nama mahasiswa dan program studi peminjam dalam satu tampilan kartu.

**Identifier Penghubung:**
Data tersebut dihubungkan menggunakan identifier **`userId`** pada `PeminjamanModel` yang merujuk pada primary key **`id`** pada `AnggotaModel` (`peminjaman.userId == anggota.id`).

---

### Soal 2 — `Future.wait`

**Kapan `Future.wait` Digunakan:**
`Future.wait` digunakan ketika aplikasi perlu memanggil beberapa endpoint API secara **bersamaan (paralel)** dan seluruh request tersebut **bersifat independen** (tidak saling membutuhkan hasil satu sama lain untuk membentuk URL atau parameter request).
- *Contoh pada project perpustakaan:* Pemanggilan `ambilDaftarAnggota()` (`/users`) dan `ambilDaftarPeminjaman()` (`/todos`) dijalankan secara paralel lewat `Future.wait` sehingga total waktu tunggu hanya mengikuti durasi request yang paling lama, bukan penjumlahan waktu keduanya.

**Kondisi yang Mengharuskan Request Dijalankan Secara Berurutan (Sequential):**
Request wajib dijalankan secara berurutan (menggunakan `await` satu per satu) apabila **output dari request pertama menjadi input/parameter wajib bagi request kedua**.
- *Contoh:* Aplikasi harus memanggil endpoint `GET /anggota?nim=230660221023` terlebih dahulu untuk memperoleh nilai `userId`, baru kemudian memanggil endpoint `GET /peminjaman?userId={id}` berdasarkan `userId` yang didapat dari respons pertama.

---

### Soal 3 — Model dan `fromJson`

**Field yang Dibutuhkan Model Gabungan (`DetailPeminjamanModel` / `DataPengajuan`):**
Untuk menghubungkan entitas pengguna (mahasiswa) dan transaksi (peminjaman/pengajuan), model gabungan membutuhkan:
1. **Identifier transaksi & penghubung:** `idPeminjaman` (ID unik transaksi) dan `userId` (foreign key penghubung).
2. **Atribut dari endpoint pengguna:** `namaPeminjam`, `nimPeminjam`, dan `prodiPeminjam`.
3. **Atribut dari endpoint transaksi:** `judulBuku`, `sudahKembali`, dan `statusPeminjaman`.

**Cara `fromJson` Menangani Field yang Tidak Tersedia pada Response:**
1. **Null-aware operator (`??`) dan *safe type casting* (`as Tipe?`):** Memberikan nilai cadangan (*default value*) jika kunci JSON bernilai `null` atau tidak dikirim server, misalnya `json['name'] as String? ?? 'Mahasiswa Tanpa Nama'`.
2. **Validasi string kosong dan pemetaan turunan:** Memeriksa `.trim().isNotEmpty` sebelum memakai string dari server, serta menurunkan nilai status yang mudah dipahami pengguna dari field boolean (misalnya `completed == true` dipetakan menjadi `'Sudah Dikembalikan'`).

---

### Soal 4 — Service Layer

**Tanggung Jawab Service Layer vs Widget:**
- **Service Layer (`PerpustakaanIntegrasiService`):** Bertanggung jawab atas seluruh komunikasi jaringan (`http.get`), pengaturan `timeout`, validasi HTTP `statusCode`, penanganan eksepsi (`try-catch`), penguraian JSON menjadi objek model Dart, serta penggabungan data antar-endpoint (`Future.wait` + pencocokan `userId`).
- **Widget (`HalamanPeminjamanPerpustakaan`):** Bertanggung jawab mengelola state tampilan (*loading*, *sukses*, *kosong*, *error*), merender komponen UI berdasarkan daftar model Dart yang diterima, serta meneruskan aksi pengguna (seperti menekan tombol *Refresh* atau *Coba Lagi*) ke *service*.

**Alasan Penggabungan Data Tidak Boleh Ditulis di Dalam Widget:**
1. **Performa dan Siklus Render:** Method `build()` dapat dipanggil berulang kali oleh Flutter setiap kali terjadi perubahan frame atau state; menaruh proses HTTP dan penggabungan data di dalamnya akan memicu request berulang kali yang membuat aplikasi lambat atau *freeze*.
2. **Pemeliharaan dan Pengujian (*Maintainability & Testability*):** Mencampur logika bisnis/jaringan dengan kode tampilan menghasilkan *tight coupling*, sehingga perubahan struktur API akan memaksa perubahan pada kode UI dan menyulitkan pengujian unit secara terpisah.

---

### Soal 5 — Status Halaman

**State yang Perlu Ditangani Halaman Integrasi Data:**
1. **Loading State (`_sedangMemuat = true`):** Menampilkan indikator proses (`CircularProgressIndicator`) saat `Future.wait` sedang mengambil data dari server.
2. **Success State (`_daftarTerintegrasi.isNotEmpty`):** Menampilkan daftar data hasil penggabungan lengkap dengan informasi peminjam dan buku.
3. **Empty State (`_daftarTerintegrasi.isEmpty`):** Menampilkan pesan bahwa data memang belum tersedia (0 baris) beserta tombol muat ulang.
4. **Error State (`_pesanError != null`):** Menampilkan keterangan penyebab kegagalan (misalnya HTTP 404, timeout, atau jaringan terputus) beserta tombol **Coba Lagi** untuk memicu ulang request.

**Mengapa Kondisi Data Kosong Perlu Dibedakan dari Kondisi Error:**
- **Secara Teknis:** Data kosong berarti komunikasi jaringan dan server **berhasil** (`HTTP 200 OK`), hanya saja belum ada catatan transaksi pada basis data. Sebaliknya, kondisi *error* berarti proses pengambilan data **gagal** akibat masalah jaringan, timeout, atau kesalahan endpoint (`HTTP 4xx/5xx`).
- **Secara Pengalaman Pengguna (UX):** Membedakan keduanya mencegah kebingungan pengguna—pengguna tahu bahwa aplikasi berjalan normal saat melihat status *"Data Peminjaman Kosong"*, dan hanya diminta memeriksa koneksi atau menekan *"Coba Lagi"* ketika benar-benar terjadi kegagalan sistem.