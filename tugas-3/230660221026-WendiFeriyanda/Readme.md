# Tugas 3 — Halaman Aplikasi Sederhana

## Identitas

| Keterangan    | Data                          |
| ------------- | ----------------------------- |
| Nama          | Wendi Feriyanda               |
| NIM           | 230660221026                  |
| Program Studi | Sistem Informasi              |
| Mata Kuliah   | Pemrograman Aplikasi Bergerak |

## Nama Aplikasi

**SI RAKUS (Sistem Rak Kampus)**

## Domain Sistem Informasi

**Perpustakaan Kampus**

## Deskripsi Halaman

Pada Tugas 3 ini saya membuat halaman katalog buku untuk aplikasi SI RAKUS (Sistem Rak Kampus). Halaman ini digunakan untuk menampilkan beberapa data buku yang ada di perpustakaan, seperti judul buku, penulis, dan jumlah stok yang tersedia. Dalam pembuatannya saya menggunakan beberapa widget Flutter seperti `MaterialApp`, `Scaffold`, `Column`, `Padding`, `Row`, `Expanded`, dan `ListView.builder` untuk mengatur tampilan agar data buku dapat ditampilkan dengan rapi dalam satu halaman.

## Data yang Ditampilkan

Data buku yang digunakan pada halaman ini terdiri dari empat buku, yaitu:

1. Dasar Pemrograman Dart
2. Sistem Informasi
3. Flutter untuk Pemula
4. Basis Data

Setiap data buku memiliki informasi judul, penulis, dan stok buku.

## Widget yang Digunakan

Widget utama yang digunakan pada halaman SI RAKUS yaitu:

* `MaterialApp` untuk struktur utama aplikasi.
* `Scaffold` untuk membuat struktur halaman.
* `AppBar` untuk menampilkan judul aplikasi.
* `Column` untuk menyusun beberapa bagian secara vertikal.
* `Padding` untuk memberikan jarak pada konten.
* `ListView.builder` untuk menampilkan daftar buku.
* `Row` untuk menyusun informasi buku secara horizontal.
* `Expanded` untuk mengatur ruang informasi judul dan penulis.
* `Text` dan `Icon` untuk menampilkan informasi buku.

## Screenshot

Screenshot hasil halaman aplikasi disimpan pada file:

```text
screenshot-halaman.png
```

## Widget Tree

Diagram widget tree disimpan pada:

```text
widget-tree.png
widget-tree.mmd
```

## Refleksi

Widget layout yang paling sulit saya rangkai adalah `ListView.builder` karena harus ditempatkan dengan benar di dalam `Column`. Saya perlu menggunakan pengaturan yang sesuai agar daftar buku dapat ditampilkan tanpa menyebabkan masalah pada layout. Dari tugas ini saya menjadi lebih memahami hubungan antara `Column`, `Row`, `Padding`, dan `ListView.builder` dalam membuat tampilan aplikasi Flutter.
