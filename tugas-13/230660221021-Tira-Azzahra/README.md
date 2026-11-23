# Tugas 13: Test Case, Debugging, dan Bug Fixes

| | |
|:--|:--|
| **Nama** | Tira Azzahra |
| **NIM** | 230660221021 |
| **Kelas** | SI-VIIA |
| **Project** | SI Perpustakaan Kampus (Pengajuan Peminjaman Buku) |

## Deskripsi Singkat

Tugas ini mendokumentasikan pengujian fungsional, pengujian otomatis (`flutter_test`), analisis statis (`flutter analyze`), serta perbaikan bug berbasis bukti pada modul **Pengajuan Peminjaman Buku — SI Perpustakaan Kampus**. Pengujian mencakup 8 skenario test case (alur berhasil, input kosong, format NIM/email salah, batas durasi pinjam, ukuran lampiran > 5 MB, error sesi HTTP 401, dan penghapusan item) serta perbaikan **BUG-01** terkait duplikasi data akibat *double-tap* pada tombol kirim.

## Struktur Folder

```text
230660221021-Tira-Azzahra/
├── lib/
│   ├── main.dart                                  # Form pengajuan, daftar riwayat & perbaikan BUG-01
│   ├── validators/
│   │   └── pengajuan_validator.dart               # Validator input form & lampiran
│   └── services/
│       └── keamanan_perpustakaan_service.dart     # Validasi HTTPS, sesi token & pengiriman aman
├── test/
│   └── pengajuan_perpustakaan_test.dart           # 6 automated unit & widget test (flutter_test)
├── pubspec.yaml                                   # Konfigurasi package & flutter_test
├── README.md                                      # Dokumentasi tugas, perintah verifikasi & batasan
├── test-case.md                                   # Tabel 8 skenario test case & actual result
├── bug-report.md                                  # Laporan reproduksi BUG-01, perbaikan & regresi
├── jawaban-quiz-pertemuan-13.md                   # Jawaban 6 soal kuis formatif pertemuan 13
└── refleksi.md                                    # Refleksi 3 kalimat & deklarasi penggunaan AI
```

## Dependency

Pada `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
```

## Perintah Verifikasi & Cara Menjalankan

Salin direktori `lib/`, `test/`, dan `pubspec.yaml` ke dalam workspace project Flutter lengkap (yang memiliki folder `web/`), lalu jalankan seluruh perintah verifikasi berikut:

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d chrome
```

### Ringkasan Hasil Verifikasi

- **`flutter analyze`:** `No issues found!` (0 error, 0 warning).
- **`flutter test`:** `All tests passed!` (6 test otomatis lulus: 3 unit test validator + 3 widget test halaman termasuk uji regresi double-tap).
- **`flutter run -d chrome`:** Seluruh 8 skenario pada `test-case.md` telah diverifikasi secara manual dan berjalan sesuai expected result.

## Batasan Pengujian

- Penyimpanan daftar pengajuan pada sesi ini masih menggunakan state memori lokal (`_daftarPengajuan`) karena backend REST API SI Perpustakaan Kampus bersifat simulasi.
- Pengujian otomatis (`flutter test`) berjalan pada lingkungan *headless test runner*; pengujian interaksi kamera/galeri nyata tetap merujuk pada pengujian manual di Chrome sebagaimana didokumentasikan pada Tugas 11.
- Tidak ada token autentikasi nyata maupun data pribadi sensitif yang dicantumkan pada berkas uji maupun kode sumber.

## Refleksi dan Deklarasi AI

Refleksi 3 kalimat dan deklarasi penggunaan AI tersedia pada berkas `refleksi.md`.