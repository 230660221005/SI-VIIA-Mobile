# Catatan Keputusan Data — SiAngkut

**Nama:** Clara Desmiati  
**NIM:** 230660221005 
**Mata Kuliah:** Pemrograman Aplikasi Bergerak

| Keputusan | Pilihan | Alasan |
|---|---|---|
| Field model | `id`, `hari`, `wilayah`, `status`, dan `keterangan` | Field tersebut dibutuhkan untuk menampilkan serta mengelola jadwal pengangkutan sampah SiAngkut. |
| Kunci data (`id`) | Menggunakan ID integer yang unik | ID menjaga agar proses edit dan hapus tetap mengarah pada jadwal yang benar, meskipun urutan daftar berubah. |
| Operasi CRUD | Tambah dan tampilkan jadwal, edit data berdasarkan ID, serta hapus setelah konfirmasi | CRUD mendukung pengelolaan data jadwal sesuai kebutuhan aplikasi. |
| Keputusan persistensi | Data disimpan sementara pada state aplikasi | Tugas ini berfokus pada CRUD lokal tanpa package tambahan; data belum disimpan permanen setelah aplikasi ditutup. |

## Kesimpulan

Model `JadwalPengangkutan` digunakan sebagai struktur data utama untuk fitur CRUD SiAngkut. Operasi update mengganti objek yang memiliki ID sama, sedangkan delete menggunakan `removeWhere` berdasarkan ID setelah pengguna menyetujui dialog konfirmasi.