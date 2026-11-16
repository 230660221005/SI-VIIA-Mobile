# Tugas 13 — Test Case dan Bug Fixes

| | |
|:--|:--|
| **Nama** | Fajar |
| **NIM** | 230660221093 |
| **Kelas** | SI-VIIA |
| **Domain** | Usaha mikro jasa — Glazent.pro (glass cleaning & nanocoating) |
| **test case & bug report** | Melakukan Test pada beberapa fitur |

---

Folder ini berisi artefak Tugas 13 untuk project **Glazent.pro** (Flutter) pada mata kuliah PAB.

## Isi folder

- `test-case.md` — minimal 8 test case (berhasil, input tidak valid, kosong/error/kondisi integrasi).
- `bug-report.md` — laporan BUG-01 (submit ganda potensial pada form pengajuan) beserta perbaikan dan bukti regresi.
- `test/tugas13_validasi_dan_form_test.dart` — salinan test otomatis Tugas 13 (4 unit test `ValidasiInput` + 1 widget test form).
- `refleksi.md` — refleksi pengerjaan dan deklarasi penggunaan AI.

Perubahan kode perbaikan bug dilakukan pada project utama: `lib/halaman-validasi-pesanan.dart` (guard `_sedangKirim`).

## Perintah verifikasi

Jalankan dari root project Flutter (`pab_p1_230660221093`):

```bash
flutter pub get
flutter analyze
flutter test
# atau hanya test Tugas 13:
flutter test test/tugas13_validasi_dan_form_test.dart
```

## Hasil verifikasi (aktual)

- `flutter analyze`: **No issues found!**
- `flutter test test/tugas13_validasi_dan_form_test.dart`: **All tests passed!** (5 test)
- Test suite project yang sudah ada sebelumnya tetap dipertahankan; perbaikan bersifat lokal pada guard submit form.

## Batasan pengujian

- Widget test form memverifikasi tampilan pesan validasi; tidak mensimulasikan pengiriman HTTP nyata (submit menggunakan delay/simulasi pada implementasi halaman).
- Skenario permission kamera/galeri dan perilaku perangkat nyata tidak diuji otomatis di sini; fitur tersebut tercakup oleh test dan implementasi tugas sebelumnya (`foto_service`, `halaman_bukti_pekerjaan`).
- Pengujian perangkat fisik/emulator memerlukan Android SDK/perangkat yang terkonfigurasi; pengujian otomatis dijalankan di environment test Flutter/Dart.
- Test case manual yang bergantung API simulasi/jaringan di luar test tiruan didokumentasikan melalui skenario integrasi yang sudah memakai pengambil data tiruan pada test project.
