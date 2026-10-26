# Tugas 3 – Layout dan Widget Flutter

**Nama:** Sesi Pramesti  
**NIM:** 230660221017  
**Program Studi:** Sistem Informasi

## 1. Nama Aplikasi
SI-FASKAM (Sistem Informasi Pengaduan Fasilitas Kampus).

## 2. Deskripsi Aplikasi
SI-FASKAM merupakan rancangan antarmuka aplikasi untuk membantu mahasiswa melihat daftar pengaduan fasilitas kampus. Aplikasi menampilkan nama fasilitas, lokasi kerusakan, dan status penanganan laporan. Data yang ditampilkan masih berupa data statis untuk keperluan pembelajaran Flutter.

## 3. Domain Sistem Informasi
Domain yang digunakan adalah Sistem Informasi Pelayanan dan Pengaduan Fasilitas Kampus.

## 4. Widget yang Digunakan
- MaterialApp untuk konfigurasi aplikasi.
- Scaffold untuk struktur halaman.
- AppBar untuk judul aplikasi.
- Padding untuk mengatur jarak konten.
- Column untuk menyusun komponen secara vertikal.
- Row untuk menyusun komponen secara horizontal.
- ListView.builder untuk menampilkan daftar pengaduan.
- Card dan ListTile untuk menyajikan informasi fasilitas.
- FloatingActionButton untuk tombol tambah laporan.

## 5. Refleksi
Bagian yang paling menantang bagi saya adalah mengatur ListView.builder di dalam Column karena daftar harus dapat ditampilkan tanpa menyebabkan overflow. Saya menggunakan Expanded agar daftar pengaduan menempati ruang yang tersedia dan dapat digulir. Dari tugas ini, saya memahami bahwa pemilihan dan penyusunan widget sangat berpengaruh terhadap kerapian serta kenyamanan tampilan aplikasi.