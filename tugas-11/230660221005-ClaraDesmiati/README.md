# Tugas 11 – Integrasi Fitur Perangkat SIAngkut

## 1. Identitas Mahasiswa

- **Nama:** Clara Desmiati
- **NIM:** 230660221005
- **Kelas:** SI-VIIA
- **Mata Kuliah:** Pemrograman Aplikasi Bergerak
- **Nama Aplikasi:** SIAngkut

## 2. Deskripsi Aplikasi

SIAngkut merupakan aplikasi layanan informasi pengangkutan sampah yang membantu warga memperoleh informasi jadwal pengangkutan dan menyampaikan laporan apabila terjadi kendala pelayanan.

Pada Tugas 11, aplikasi dikembangkan dengan menambahkan integrasi fitur perangkat berupa pemilihan foto dari galeri. Foto digunakan sebagai bukti pendukung ketika warga melaporkan permasalahan, seperti sampah belum diangkut, penumpukan sampah, atau keterlambatan pengangkutan.

## 3. Tujuan Penggunaan Fitur Perangkat

Fitur pemilihan foto dari galeri diterapkan untuk:

1. Memudahkan warga melampirkan bukti visual pada laporan.
2. Membantu petugas memahami kondisi permasalahan yang dilaporkan.
3. Memberikan informasi tambahan agar laporan lebih jelas.
4. Mendukung proses penyampaian laporan melalui aplikasi SIAngkut.

**Aktor:** Warga sebagai pengguna aplikasi.

**Tujuan proses bisnis:** Menyampaikan laporan permasalahan pengangkutan sampah dengan menyertakan foto pendukung.

**Data keluaran:** File foto dengan tipe `XFile` yang dipilih pengguna dari galeri perangkat.

## 4. Dependency yang Digunakan

Paket yang digunakan adalah `image_picker` versi `^1.1.2`.

Paket ini berfungsi untuk mengakses fitur pemilihan gambar dari galeri perangkat.

Konfigurasi pada `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  image_picker: ^1.1.2
```

Instalasi dependency dilakukan menggunakan perintah:

```bash
flutter pub get
```

## 5. Struktur Implementasi

Bagian utama implementasi fitur perangkat terdiri dari:

```text
lib/
├── main.dart
└── services/
    └── foto_service.dart
```

Penjelasan:

- `main.dart`: Mengatur tampilan halaman laporan, tombol pemilihan foto, indikator loading, pratinjau foto, dan pesan kepada pengguna.
- `services/foto_service.dart`: Menangani proses pemilihan foto menggunakan paket `image_picker`, serta mengelola hasil pemilihan dan kesalahan yang terjadi.

Pemisahan tersebut dilakukan agar proses akses fitur perangkat tidak dicampur langsung dengan kode tampilan aplikasi.

## 6. Alur Penggunaan Fitur

1. Pengguna membuka aplikasi SIAngkut.
2. Pengguna masuk ke halaman Buat Laporan Pengangkutan.
3. Pengguna mengisi nama, alamat, dan keterangan laporan.
4. Pengguna menekan tombol Pilih Foto dari Galeri.
5. Aplikasi menjalankan proses pemilihan foto melalui `FotoService`.
6. Pengguna memilih salah satu foto dari galeri.
7. Aplikasi menampilkan foto yang dipilih sebagai pratinjau.
8. Pengguna dapat melanjutkan pengisian laporan.
9. Jika pengguna membatalkan pemilihan, aplikasi mempertahankan foto sebelumnya apabila sudah ada.

## 7. Pengelolaan Kondisi dan Kesalahan

Aplikasi menangani beberapa kondisi selama proses pemilihan foto:

| Kondisi | Penanganan |
|---|---|
| Foto berhasil dipilih | Foto ditampilkan sebagai pratinjau |
| Pengguna membatalkan pemilihan | Foto sebelumnya tetap dipertahankan |
| Izin akses ditolak | Aplikasi menampilkan informasi penolakan izin |
| Terjadi kesalahan plugin atau perangkat | Aplikasi menampilkan pesan kesalahan |
| Proses pemilihan berlangsung | Aplikasi menampilkan indikator loading |

Jika pemilihan foto dibatalkan, service mengembalikan nilai `null`. Kondisi tersebut dibedakan dari kesalahan agar pembatalan oleh pengguna tidak dianggap sebagai kegagalan aplikasi.

## 8. Konfigurasi Permission dan Platform

Fitur dikembangkan menggunakan paket `image_picker`.

Pada platform web, pemilihan gambar dilakukan melalui file picker yang disediakan browser. Akses kamera dan permission perangkat native tidak diuji hanya dengan menjalankan aplikasi melalui Chrome.

Untuk platform Android dan iOS, konfigurasi mengikuti dokumentasi dan kebutuhan versi plugin yang digunakan. Pengujian permission native perlu dilakukan pada perangkat atau emulator yang mendukung platform tersebut.

## 9. Cara Menjalankan Aplikasi

Pastikan Flutter dan dependency sudah tersedia.

Jalankan perintah berikut pada terminal:

```bash
flutter pub get
flutter analyze
flutter run -d chrome
```

Perintah tersebut digunakan untuk memasang dependency, memeriksa kode, dan menjalankan aplikasi melalui Chrome apabila dukungan web tersedia.

## 10. Hasil Pemeriksaan dan Pengujian

Pemeriksaan kode menggunakan perintah `flutter analyze` telah dilakukan dan menghasilkan:

```text
No issues found!
```

Pengujian fitur meliputi:

1. Pemilihan foto dari galeri.
2. Pembatalan pemilihan foto.
3. Penolakan izin akses.
4. Kesalahan plugin atau perangkat.

Hasil masing-masing skenario dicatat dalam dokumen `skenario-pengujian.md`. Pengujian yang belum dilakukan secara langsung tetap dicatat sebagai belum diuji agar hasil laporan sesuai dengan kondisi sebenarnya.

## 11. Keterbatasan Pengujian

Pengujian melalui Chrome hanya digunakan untuk memeriksa alur pemilihan file melalui browser. Perilaku permission dan akses galeri pada Android atau iOS dapat berbeda sehingga perlu dilakukan pengujian tambahan pada perangkat native.

## 12. Kesimpulan

Melalui Tugas 11, aplikasi SIAngkut telah dikembangkan dengan penambahan fitur pemilihan foto dari galeri sebagai bukti laporan pengangkutan sampah. Implementasi menggunakan paket `image_picker` dan memisahkan proses akses fitur perangkat ke dalam service.

Fitur ini diharapkan dapat membantu warga menyampaikan laporan yang lebih jelas melalui bukti visual. Selain itu, penerapan loading, penanganan pembatalan, dan pesan kesalahan membantu aplikasi memberikan respons yang lebih informatif kepada pengguna.