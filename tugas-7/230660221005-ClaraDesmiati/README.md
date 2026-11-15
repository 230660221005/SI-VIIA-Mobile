# Tugas 7 — MVP Awal dengan Data Lokal

**Nama:** Clara Desmiati  
**NIM:** 230660221005
**Mata Kuliah:** Pemrograman Aplikasi Bergerak

## Deskripsi Tugas

Tugas ini mengembangkan aplikasi SiAngkut dengan fitur pengelolaan jadwal pengangkutan sampah menggunakan operasi CRUD (*Create, Read, Update,* dan *Delete*). Pengguna dapat menambahkan jadwal baru, melihat daftar jadwal, mengedit informasi jadwal, serta menghapus jadwal setelah menyetujui konfirmasi. Data pada prototipe disimpan sementara di dalam state aplikasi dan belum menggunakan penyimpanan permanen.

## Refleksi

Bagian yang paling sulit bagi saya adalah menjaga konsistensi antara field pada model data dan operasi CRUD yang digunakan untuk mengelola jadwal. Saya menggunakan `id` unik agar proses edit dan hapus tetap mengarah pada data yang benar meskipun posisi data dalam daftar berubah. Saya juga belajar bahwa setiap perubahan data harus menggunakan `setState` agar tampilan daftar diperbarui sesuai dengan kondisi data terbaru.

## Deklarasi Penggunaan AI

Deklarasi penggunaan AI: ChatGPT — membantu memahami model data, operasi CRUD, validasi form, dan penanganan konfirmasi penghapusan; hasilnya diperiksa dan disesuaikan oleh penulis.