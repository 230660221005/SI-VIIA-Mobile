# Tugas 13: Test Case dan Bug Fixes

| | |
|:--|:--|
| **Nama** | Galih Permana Sidik |
| **NIM** | 230660221002 |
| **Kelas** | SI-VIIA |
| **Project** | SiLapor Kampus (pelaporan kerusakan fasilitas kampus) |

## Deskripsi Singkat

Tugas ini menguji form Buat Laporan hasil Tugas 12. Disusun 12 test case (`test-case.md`), 5 widget test dan 44 tes unit dan pemindaian otomatis, serta satu bug yang ditemukan dan diperbaiki: validator email menerima alamat dengan titik tidak wajar (`bug-report.md`). Perbaikan diikuti test regresi untuk memastikan email yang valid tidak ikut tertolak.

## Struktur Folder

```text
230660221002-galih-permana-sidik/
├── lib/                              kode dari Tugas 12, validator email diperbaiki
├── test/
│   ├── validator_laporan_test.dart   28 unit test untuk enam validator
│   ├── keamanan_test.dart            4 pemindaian source (dari Tugas 12)
│   ├── regresi_email_test.dart       12 test untuk BUG-01 dan regresinya
│   └── widget_form_test.dart         5 widget test untuk form
├── pubspec.yaml
├── test-case.md
├── bug-report.md
├── jawaban-quiz-pertemuan-13
├── README.md
└── refleksi.md
```

## Perintah Verifikasi

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d chrome
```

Bila folder ini belum berupa project Flutter lengkap, jalankan `flutter create . --project-name silapor_kampus` sekali. Tes memakai `import 'package:silapor_kampus/...'`, jadi nama project harus `silapor_kampus`. Widget test memakai `tester.view`, yang membutuhkan Flutter 3.10 atau lebih baru.

Menguji satu berkas saja:

```bash
flutter test test/regresi_email_test.dart
flutter test test/widget_form_test.dart
```

## Hasil Verifikasi

Isi dengan keluaran yang benar-benar didapat:

| Pemeriksaan | Hasil |
|:------------|:------|
| `flutter analyze` (pertama kali) | 2 temuan, keduanya berasal dari berkas bawaan `flutter create` (lihat Catatan Hasil Verifikasi). Tidak ada temuan pada kode buatan sendiri |
| `flutter analyze` setelah perbaikan | `No issues found!` |
| `flutter test test/regresi_email_test.dart` sebelum perbaikan BUG-01 (pola email lama) | 5 lulus, 7 gagal (semua kegagalan pada grup BUG-01) |
| `flutter test test/regresi_email_test.dart` setelah perbaikan | 12 lulus, `All tests passed!` |
| `flutter test test/widget_form_test.dart` | 5 lulus, `All tests passed!` |
| `flutter test` (seluruh test, pertama kali) | 49 lulus, 1 berkas gagal dimuat (`test/widget_test.dart`, template bawaan) |
| `flutter test` setelah perbaikan | `+49: All tests passed!` |
| Pengujian manual TC-01, TC-05, TC-08, TC-09 | Seluruhnya sesuai expected result (lihat `test-case.md`) |

### Catatan Hasil Verifikasi

`flutter create .` menambahkan dua berkas bawaan yang tidak terkait project ini:

- `test/widget_test.dart`, template aplikasi penghitung yang memanggil `MyApp`. Class itu tidak ada pada SiLapor (class aplikasinya `SiLaporApp`), sehingga berkas gagal dikompilasi dan menjadi satu-satunya kegagalan pada `flutter test` serta satu error pada `flutter analyze`. Berkas ini dihapus karena menguji aplikasi yang tidak ada. Seluruh 49 tes milik project tidak terpengaruh dan lulus.
- `analysis_options.yaml` yang memuat `package:flutter_lints/flutter.yaml`. Package `flutter_lints` belum tercatat pada `pubspec.yaml`, sehingga muncul warning. Dipasang dengan `flutter pub add --dev flutter_lints`.

## Batasan Pengujian

- Target pengujian adalah Chrome (web). Kamera langsung dan penolakan izin pada perangkat nyata belum diuji.
- TC-08 dan TC-09 (pembatalan dan error pemilihan foto) masih manual, karena `image_picker` memerlukan platform channel palsu untuk diuji otomatis.
- Widget test tidak mencakup alur pengisian lengkap sampai dialog ringkasan, yang melibatkan pemilih tanggal dan dropdown. Alur itu diuji manual pada TC-01.
- Pengujian regex email dan validator memakai alamat contoh, bukan data pribadi nyata.
- Tes `keamanan_test.dart` memindai teks sederhana dan tidak menggantikan audit keamanan.
- Risiko lain yang belum ditangani ada pada `bug-report.md` bagian Risiko yang Masih Tersisa.

## Deklarasi Penggunaan AI

Claude dipakai untuk membantu menelaah pola regex validator email dan menemukan kelas alamat yang lolos secara keliru, menyusun variasi test case dan kerangka widget test, serta merapikan draf laporan bug. Penentuan expected result, pengujian pada kode sebelum dan sesudah perbaikan, pengisian hasil aktual, dan keputusan perbaikan saya lakukan dan verifikasi sendiri.
