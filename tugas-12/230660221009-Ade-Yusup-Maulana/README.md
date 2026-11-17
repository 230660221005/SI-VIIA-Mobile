# Tugas 12: Validasi dan Keamanan Praktis

## Identitas Mahasiswa

- **Nama:** Ade Yusup Maulana
- **NIM:** 230660221009
- **Program Studi:** Sistem Informasi
- **Kelas:** SI-VIIA
- **Mata Kuliah:** Pemrograman Aplikasi Bergerak
- **Pertemuan:** 12

## Deskripsi Aplikasi

Aplikasi ini merupakan pengembangan aplikasi Flutter dari Tugas 11 yang mengintegrasikan fitur kamera dan galeri menggunakan package `image_picker`.

Pada Tugas 12, aplikasi dikembangkan dengan menambahkan validasi input foto untuk memastikan file yang dipilih memenuhi ketentuan format, ukuran, dan isi data sebelum diproses.

## Fitur Aplikasi

1. Mengambil foto menggunakan kamera.
2. Memilih foto dari galeri.
3. Menampilkan pratinjau gambar.
4. Menampilkan indikator loading.
5. Menangani pembatalan pemilihan gambar.
6. Menampilkan pesan ketika terjadi kesalahan.
7. Memvalidasi foto wajib dipilih.
8. Membatasi format foto JPG, JPEG, dan PNG.
9. Membatasi ukuran foto maksimal 2 MB.
10. Memeriksa data foto agar tidak kosong.
11. Memeriksa signature awal file JPEG dan PNG.

## Teknologi yang Digunakan

- Flutter
- Dart
- Package `image_picker`
- Flutter Test

## Struktur Folder

```text
tugas-12/
├── lib/
│   ├── main.dart
│   ├── pages/
│   │   └── halaman_foto.dart
│   ├── services/
│   │   └── foto_service.dart
│   └── validators/
│       └── validasi_foto.dart
├── test/
│   ├── validasi_foto_test.dart
│   └── widget_test.dart
├── android/
├── ios/
├── web/
├── pubspec.yaml
├── README.md
├── security-checklist.md
├── validasi-input.md
└── refleksi.md
```

## Instalasi Dependensi

Jalankan perintah berikut pada terminal:

```bash
flutter pub get
```

Package utama:

```yaml
image_picker: ^1.2.4
```

## Cara Menjalankan Aplikasi

Untuk menjalankan aplikasi melalui Chrome:

```bash
flutter run -d chrome
```

Untuk menjalankan pada perangkat Android:

```bash
flutter devices
flutter run -d <device_id>
```

## Pemeriksaan Kode

Untuk memeriksa kesalahan kode:

```bash
flutter analyze
```

Untuk menjalankan seluruh pengujian:

```bash
flutter test
```

## Dokumentasi Validasi dan Keamanan

- `security-checklist.md`: daftar pemeriksaan keamanan aplikasi.
- `validasi-input.md`: dokumentasi aturan validasi input.
- `lib/validators/validasi_foto.dart`: implementasi lima validasi foto.
- `test/validasi_foto_test.dart`: pengujian validasi foto.
- `test/widget_test.dart`: pengujian tampilan aplikasi.
- `refleksi.md`: refleksi pengerjaan Tugas 12.

## Token, Permission, dan HTTPS

Aplikasi belum menggunakan autentikasi pengguna, token, maupun API atau server. Oleh karena itu, penyimpanan token dan komunikasi HTTPS belum diterapkan.

Akses kamera dan galeri menggunakan package `image_picker`. Pengujian izin pada perangkat Android secara langsung masih perlu dilakukan.

## Batasan Keamanan

1. Validasi dilakukan pada sisi aplikasi.
2. Pemeriksaan signature merupakan pemeriksaan awal dan belum melakukan decoding gambar secara menyeluruh.
3. Validasi sisi server belum tersedia karena aplikasi belum terhubung dengan server.
4. Pengujian izin kamera dan galeri pada perangkat Android masih diperlukan.

## Pernyataan Penggunaan AI

AI digunakan sebagai alat bantu untuk memahami materi