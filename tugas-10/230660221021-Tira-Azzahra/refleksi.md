# Refleksi Pengerjaan — Tugas 10

1. **Bagian integrasi data yang paling sulit:**
   Menyelaraskan pemetaan key JSON dari API simulasi ke domain SI Perpustakaan Kampus serta memastikan pencocokan `userId` dari data pengajuan buku ke `id` anggota perpustakaan tidak menimbulkan error *null* apabila terdapat ID anggota yang tidak ditemukan.

2. **Cara menangani response kosong atau error:**
   Halaman memisahkan state `_sedangMemuat`, `_pesanError`, dan `_daftarPeminjaman`. Jika terjadi *timeout* atau gagal koneksi, blok `try-catch` menangkap error dan menampilkan pesan yang mudah dipahami beserta tombol **Coba Lagi**. Jika request berhasil namun list kosong, aplikasi menampilkan pesan status kosong tanpa menganggapnya sebagai error jaringan.

3. **Alasan pemisahan service dan widget:**
   Pemisahan `PerpustakaanService` dari widget membuat struktur kode lebih rapi dan fokus pada tanggung jawab masing-masing. Seluruh request paralel `Future.wait` dan penggabungan model dikelola di service layer tanpa mengotori method `build` pada antarmuka pengguna.

## Deklarasi Penggunaan AI
Deklarasi penggunaan AI: Gemini — digunakan untuk membantu menyusun struktur `PerpustakaanService` dengan `Future.wait` serta pemetaan `Map<int, AnggotaPerpustakaan>` pada domain SI Perpustakaan Kampus; penyesuaian kode dan pengujian dilakukan serta diverifikasi oleh penulis.