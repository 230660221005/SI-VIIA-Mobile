# Refleksi Tugas 10 — Integrasi Data dan Proses Bisnis

**Nama:** Clara Desmiati  
**NIM:** 230660221005  
**Kelas:** SI-VIIA  
**Aplikasi:** SIAngkut

## 1. Bagian yang Paling Menantang

Bagian yang paling menantang adalah menggabungkan data dari dua endpoint yang berbeda. Saya harus memahami hubungan antara data pengguna dan data pengajuan menggunakan identifier userId. Selain itu, saya juga perlu memastikan data JSON dapat diubah menjadi model Dart.

## 2. Penanganan Kondisi Kosong dan Error

Kondisi kosong dan error memiliki arti yang berbeda. Kondisi kosong terjadi ketika request berhasil tetapi tidak ada data yang diterima. Sementara itu, error terjadi ketika request gagal, misalnya karena koneksi internet bermasalah atau server memberikan respons yang tidak sesuai. Karena itu, keduanya ditampilkan dengan pesan yang berbeda.

## 3. Pemisahan Service dan Widget

Service digunakan untuk mengatur komunikasi dengan API, parsing JSON, dan penggabungan data. Widget digunakan untuk menampilkan hasil integrasi kepada pengguna. Pemisahan ini membuat kode lebih mudah dibaca dan memudahkan perbaikan jika terjadi kesalahan.

## 4. Hal yang Dipelajari

Melalui tugas ini, saya belajar menggunakan metode GET dan POST, memahami Future.wait, membuat model dari JSON, serta menggabungkan data berdasarkan identifier. Saya juga belajar menangani loading, sukses, kosong, dan error pada aplikasi Flutter.

## 5. Batasan Implementasi

API JSONPlaceholder hanya menyediakan data simulasi. Oleh karena itu, data yang tampil bukan data warga sebenarnya dan pengiriman POST tidak menyimpan data secara permanen.

## 6. Deklarasi Penggunaan AI

ChatGPT (OpenAI) digunakan sebagai alat bantu untuk memahami error, memperbaiki kode, dan menyusun dokumentasi tugas. Penulis tetap melakukan proses menjalankan aplikasi, memeriksa hasil, dan mempelajari implementasi yang digunakan.
