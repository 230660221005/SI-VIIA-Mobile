# Dokumen Fitur Perangkat – SIAngkut

## 1. Identitas Aplikasi

- **Nama:** Clara Desmiati
- **NIM:** 230660221005
- **Kelas:** SI-VIIA
- **Mata Kuliah:** Pemrograman Aplikasi Bergerak
- **Nama Aplikasi:** SIAngkut

## 2. Fitur Perangkat yang Dipilih

Fitur perangkat yang diterapkan adalah pemilihan foto dari galeri menggunakan package `image_picker`.

Fitur ini ditambahkan pada halaman Buat Laporan Pengangkutan agar warga dapat melampirkan foto sebagai bukti ketika melaporkan permasalahan pengangkutan sampah.

## 3. Latar Belakang

SIAngkut merupakan aplikasi layanan informasi pengangkutan sampah yang membantu warga memperoleh informasi dan menyampaikan laporan terkait pelayanan pengangkutan sampah.

Dalam proses pelaporan, informasi berupa tulisan terkadang belum cukup untuk menggambarkan kondisi yang terjadi di lapangan. Oleh karena itu, diperlukan foto sebagai bukti pendukung agar pihak pengelola dapat memahami permasalahan dengan lebih jelas.

Contoh permasalahan yang dapat dilaporkan adalah sampah belum diangkut, keterlambatan pengangkutan, dan penumpukan sampah.

## 4. Aktor yang Terlibat

Aktor yang menggunakan fitur ini adalah warga sebagai pengguna aplikasi SIAngkut.

Warga dapat mengisi formulir laporan dan memilih foto dari galeri perangkat untuk dijadikan bukti pendukung.

## 5. Tujuan Proses Bisnis

Tujuan penerapan fitur ini adalah mendukung proses pelaporan permasalahan pengangkutan sampah dengan menyediakan bukti visual.

Dengan adanya foto, informasi laporan diharapkan menjadi lebih lengkap sehingga memudahkan pihak pengelola dalam memahami kondisi yang disampaikan warga.

## 6. Data Keluaran

Data yang diperoleh dari proses pemilihan foto meliputi:

1. Objek `XFile` yang dikembalikan oleh package `image_picker`.
2. Nama file foto yang dipilih.
3. Lokasi atau path file yang diberikan oleh plugin.
4. Data gambar dalam bentuk byte yang digunakan untuk menampilkan pratinjau.

Data tersebut digunakan oleh aplikasi untuk menampilkan foto yang telah dipilih pada halaman laporan.

## 7. Alur Kerja Fitur

1. Warga membuka aplikasi SIAngkut.
2. Warga masuk ke halaman Buat Laporan Pengangkutan.
3. Warga mengisi nama, alamat, dan keterangan laporan.
4. Warga menekan tombol Pilih Foto dari Galeri.
5. Widget memanggil fungsi `pilihFoto()` pada `FotoService`.
6. `FotoService` menjalankan proses pemilihan foto secara asynchronous menggunakan `image_picker`.
7. Jika foto berhasil dipilih, aplikasi menerima objek `XFile`.
8. Aplikasi membaca data gambar dan menampilkan pratinjau foto.
9. Warga dapat melanjutkan pengisian laporan.
10. Jika pemilihan dibatalkan atau terjadi kesalahan, aplikasi memberikan respons sesuai kondisi yang terjadi.

## 8. Pemisahan Service dan Widget

Implementasi fitur dibagi menjadi dua bagian utama.

**a. FotoService**

File: `lib/services/foto_service.dart`

Service bertugas:
- Memanggil package `image_picker`.
- Membuka pemilih foto dari galeri.
- Menjalankan proses secara asynchronous.
- Mengembalikan objek `XFile` apabila foto berhasil dipilih.
- Mengembalikan `null` apabila pengguna membatalkan pemilihan.
- Menangani kesalahan yang berkaitan dengan akses fitur perangkat.

**b. Widget FormLaporan**

File: `lib/main.dart`

Widget bertugas:
- Menampilkan tombol pemilihan foto.
- Menampilkan indikator loading.
- Menyimpan hasil foto yang dipilih.
- Menampilkan pratinjau gambar.
- Menampilkan informasi keberhasilan, pembatalan, dan kesalahan.

Pemisahan tersebut dilakukan agar proses akses fitur perangkat tidak bercampur dengan pengelolaan tampilan aplikasi.

## 9. Permission dan Hak Akses

Fitur pemilihan foto menggunakan mekanisme akses galeri yang disediakan oleh platform melalui package `image_picker`.

Kebutuhan akses dapat berbeda berdasarkan platform dan versi sistem operasi.

- **Web/Chrome:** Pengguna memilih file melalui dialog file picker browser.
- **Android:** Akses foto mengikuti mekanisme pemilih foto dan ketentuan permission Android yang berlaku.
- **iOS:** Penggunaan galeri mengikuti mekanisme akses foto dan konfigurasi yang dipersyaratkan oleh plugin.

Jika pengguna menolak atau tidak memberikan izin yang dibutuhkan, aplikasi perlu menampilkan informasi bahwa foto tidak dapat diakses.

Konfigurasi platform native perlu diperiksa berdasarkan dokumentasi resmi `image_picker` sebelum aplikasi dijalankan atau didistribusikan pada perangkat Android dan iOS.

## 10. Penanganan Pembatalan dan Kesalahan

Aplikasi perlu membedakan pembatalan pengguna dengan kesalahan sistem.

| Kondisi | Respons Aplikasi |
|---|---|
| Foto berhasil dipilih | Menampilkan pratinjau foto |
| Pengguna membatalkan | Mengembalikan nilai `null` dan mempertahankan foto sebelumnya |
| Izin ditolak | Menampilkan informasi penolakan akses |
| Kesalahan plugin | Menampilkan pesan kegagalan |
| Kesalahan perangkat | Menampilkan informasi dan memberikan kesempatan mencoba kembali |

Pembatalan pemilihan foto tidak dianggap sebagai kesalahan. Hal ini penting agar aplikasi tidak menghapus foto sebelumnya hanya karena pengguna membatalkan pemilihan foto baru.

## 11. Target Platform dan Batasan Pengujian

Pengembangan menggunakan Flutter dengan target pemeriksaan kode dan pengujian alur pemilihan file melalui Chrome.

Pengujian pada Chrome tidak sepenuhnya mewakili perilaku galeri dan permission pada perangkat Android atau iOS. Oleh karena itu, pengujian native tetap diperlukan untuk memastikan fitur berjalan sesuai mekanisme sistem operasi.

## 12. Kesimpulan

Fitur pemilihan foto dari galeri pada aplikasi SIAngkut diterapkan untuk membantu warga memberikan bukti visual saat menyampaikan laporan permasalahan pengangkutan sampah.

Implementasi menggunakan package `image_picker`, pemisahan service dan widget, serta penanganan kondisi berhasil, pembatalan, dan kesalahan. Dengan fitur ini, proses pelaporan diharapkan menjadi lebih informatif dan mudah dipahami oleh pihak pengelola layanan.