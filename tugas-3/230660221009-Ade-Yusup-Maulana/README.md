\# Tugas 3 - Halaman Aplikasi Sederhana



\## Identitas



| Data | Keterangan |

|---|---|

| Nama | Ade Yusup Maulana |

| NIM | 230660221009 |

| Program Studi | Sistem Informasi |

| Mata Kuliah | Pemrograman Aplikasi Bergerak |

| Tugas | Tugas 3 - Halaman Aplikasi Sederhana |



\## Deskripsi Aplikasi



Aplikasi yang dibuat merupakan halaman sederhana untuk Sistem Informasi Penjualan dan Transaksi Warung. Halaman aplikasi menampilkan daftar produk warung beserta harga dan status ketersediaannya.



\## Widget dan Layout yang Digunakan



| Widget | Fungsi |

|---|---|

| MaterialApp | Menjadi struktur utama aplikasi Flutter |

| Scaffold | Menyediakan struktur halaman aplikasi |

| AppBar | Menampilkan judul halaman |

| Column | Menyusun widget secara vertikal |

| Row | Menyusun informasi produk secara horizontal |

| Padding | Memberikan jarak pada isi halaman |

| ListView.builder | Menampilkan daftar produk |

| Card | Membuat tampilan produk dalam bentuk kartu |

| Expanded | Mengatur penggunaan ruang pada halaman |

| FloatingActionButton | Menampilkan tombol aksi |



\## Data Statis



Aplikasi menggunakan 4 data produk:



1\. Nasi Goreng - Rp15.000 - Tersedia

2\. Mie Instan - Rp8.000 - Tersedia

3\. Kopi - Rp5.000 - Tersedia

4\. Teh Manis - Rp4.000 - Habis



\## Struktur Widget



Widget tree aplikasi dibuat mulai dari `MyApp`, `MaterialApp`, `HalamanUtama`, `Scaffold`, kemudian bercabang ke `AppBar`, `Body`, `Padding`, `Column`, `ListView.builder`, `Card`, `Row`, dan `FloatingActionButton`.



\## Dokumentasi



\### Screenshot Halaman Aplikasi



File dokumentasi tampilan aplikasi:



`screenshot-halaman.png`



\### Widget Tree



File dokumentasi struktur widget:



`widget-tree.png`



\## Cara Menjalankan



Aplikasi dijalankan menggunakan Flutter pada browser Chrome dengan perintah:



```bash

flutter run -d chrome

