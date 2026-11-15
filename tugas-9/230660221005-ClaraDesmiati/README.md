# TUGAS 9 — IMPLEMENTASI REST API PADA FLUTTER

## Identitas Mahasiswa

- Nama: Clara Desmiati
- NIM: 230660221005
- Kelas: SI-VIIA
- Mata Kuliah: Pemrograman Aplikasi Bergerak
- Nama Aplikasi: SIAngkut

## Deskripsi

Tugas ini merupakan pengembangan aplikasi SIAngkut dengan menerapkan integrasi REST API menggunakan Flutter.

API yang digunakan adalah JSONPlaceholder sebagai layanan simulasi untuk mengambil dan mengirim data laporan pengangkutan sampah.

## Fitur yang Diimplementasikan

1. **GET:** Mengambil dan menampilkan daftar data dari REST API.
2. **POST:** Mengirim laporan melalui formulir aplikasi.
3. **Loading:** Menampilkan proses pengambilan data.
4. **Success:** Menampilkan data yang berhasil diterima.
5. **Error:** Menampilkan pesan kesalahan dan tombol Coba Lagi.

## Daftar File

| Nama File | Keterangan |
|---|---|
| `service-api.dart` | Model data dan layanan GET serta POST |
| `halaman-api.dart` | Tampilan daftar data dan formulir laporan |
| `catatan-integrasi-api.md` | Dokumentasi integrasi REST API |
| `screenshot-loading.png` | Bukti tampilan loading |
| `screenshot-sukses.png` | Bukti keberhasilan pengiriman laporan |
| `screenshot-error.png` | Bukti tampilan error |

## Deklarasi Penggunaan AI

Dalam pengerjaan tugas ini, saya menggunakan AI sebagai alat bantu untuk memahami konsep REST API, menyusun kode program, dan membantu mengatasi kesalahan saat proses pengembangan. Kode yang digunakan tetap diperiksa dan diuji kembali agar sesuai dengan kebutuhan aplikasi SIAngkut.

## Refleksi

Melalui tugas ini, saya belajar menghubungkan aplikasi Flutter dengan REST API menggunakan metode GET dan POST. Saya juga memahami cara mengubah data JSON menjadi objek Dart serta menangani kondisi loading, success, dan error. Dari proses ini, saya menjadi lebih memahami bagaimana aplikasi dapat melakukan komunikasi dengan layanan API.