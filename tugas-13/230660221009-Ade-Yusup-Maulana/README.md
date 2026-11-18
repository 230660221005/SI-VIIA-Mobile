
# TUGAS 13: TESTING, DEBUGGING, DAN BUG FIXES

## Identitas Mahasiswa

- **Nama:** Ade Yusup Maulana
- **NIM:** 230660221009
- **Kelas:** SI-VIIA
- **Mata Kuliah:** Pemrograman Aplikasi Bergerak
- **Pertemuan:** 13
- **Materi:** Testing, Debugging, dan Bug Fixes

## 1. Deskripsi Proyek

Tugas ini merupakan pengembangan aplikasi Flutter untuk pemilihan dan validasi foto sebagai bukti dokumentasi.

Aplikasi menyediakan fitur pengambilan foto melalui kamera dan pemilihan gambar melalui galeri. Foto yang dipilih akan diperiksa melalui lima tahap validasi sebelum ditampilkan pada pratinjau.

## 2. Fitur Aplikasi

1. Mengambil foto menggunakan kamera.
2. Memilih foto dari galeri.
3. Memeriksa apakah foto sudah dipilih.
4. Memvalidasi format JPG, JPEG, dan PNG.
5. Membatasi ukuran foto maksimal 2 MB.
6. Memeriksa data foto agar tidak kosong.
7. Memeriksa tanda pengenal isi file gambar.
8. Menampilkan pratinjau foto.
9. Menampilkan pesan keberhasilan atau kesalahan validasi.
10. Menghapus foto lama ketika foto baru gagal melewati validasi.

## 3. Struktur Folder

```text
230660221009-Ade-Yusup-Maulana/
├── lib/
│   ├── main.dart
│   ├── pages/
│   │   └── halaman_foto.dart
│   ├── services/
│   │   └── foto_service.dart
│   └── validators/
│       └── validasi_foto.dart
├── test/
│   ├── widget_test.dart
│   ├── validasi_foto_test.dart
│   └── bug_pratinjau_test.dart
├── test-case.md
├── bug-report.md
├── README.md
├── refleksi.md
└── pubspec.yaml
```

## 4. Pengujian Aplikasi

Pengujian dilakukan menggunakan Flutter Test dan Flutter Analyze.

### Perintah Pengujian

**Memasang dependensi:**

```bash
flutter pub get
```

**Memeriksa kode program:**

```bash
flutter analyze
```

**Menjalankan seluruh pengujian:**

```bash
flutter test
```

**Menjalankan pengujian bug:**

```bash
flutter test test/bug_pratinjau_test.dart
```

## 5. Hasil Pengujian

| Pengujian | Hasil |
|---|---|
| Flutter pub get | Berhasil |
| Flutter analyze | No issues found |
| Unit test validasi foto | 8 tes berhasil |
| Widget test | 4 tes berhasil |
| Regression test | 1 tes berhasil |

**Hasil akhir:** Sebanyak 13 pengujian otomatis berhasil dijalankan, terdiri dari 8 unit test, 4 widget test, dan 1 regression test. Seluruh pengujian menunjukkan hasil `All tests passed!`.

## 6. Debugging dan Perbaikan Bug

Ditemukan masalah ketika pengguna memilih foto valid, kemudian memilih file baru dengan format tidak didukung.

Sebelum perbaikan, foto lama masih tampil meskipun aplikasi sudah menampilkan pesan kesalahan.

Perbaikan dilakukan dengan menambahkan fungsi `_hapusFotoLama()` pada `halaman_foto.dart`. Fungsi tersebut menghapus data foto dan pratinjau ketika foto baru gagal melewati validasi.

Pengujian ulang menunjukkan bahwa masalah berhasil diperbaiki.

Dokumentasi lengkap tersedia pada file `bug-report.md`.

## 7. Batasan Pengujian

- Pengujian otomatis dilakukan menggunakan Flutter Test.
- Pengujian kamera dan galeri secara langsung masih memerlukan perangkat yang mendukung fitur tersebut.
- Pengujian otomatis tidak menggantikan pengujian langsung pada perangkat fisik.
- Pemeriksaan tanda pengenal file merupakan pemeriksaan awal, bukan pemeriksaan menyeluruh terhadap keamanan dan keutuhan gambar.

## 8. Kesimpulan

Berdasarkan hasil pengujian, aplikasi dapat menjalankan fungsi validasi foto dengan baik pada skenario yang telah diuji.

Proses debugging berhasil menemukan dan memperbaiki masalah pratinjau foto lama. Seluruh 13 pengujian otomatis berhasil dijalankan.

Tugas ini memberikan pemahaman mengenai pengujian unit, pengujian widget, analisis kode, proses debugging, perbaikan bug, dan regression testing.

## 9. Refleksi dan Pernyataan Penggunaan AI

Dokumentasi refleksi pembelajaran selama mengerjakan Tugas 13 serta pernyataan penggunaan Artificial Intelligence (AI) dapat dilihat pada file berikut:

**[Buka Refleksi Tugas 13](refleksi.md)**

Dokumen refleksi tersebut berisi:

1. Pemahaman mengenai pengujian otomatis.
2. Pengalaman menggunakan `flutter analyze`, unit test, widget test, dan regression test.
3. Pengalaman menemukan dan memperbaiki bug.
4. Pernyataan penggunaan ChatGPT sebagai alat bantu pengerjaan tugas.
