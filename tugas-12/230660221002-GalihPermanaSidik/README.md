# Tugas 12: Security Checklist dan Validasi Project

| | |
|:--|:--|
| **Nama** | Galih Permana Sidik |
| **NIM** | 230660221002 |
| **Kelas** | SI-VIIA |
| **Project** | SiLapor Kampus (pelaporan kerusakan fasilitas kampus) |

## Deskripsi Singkat

Tugas ini memeriksa aspek keamanan project SiLapor dan memperbaiki yang dapat diperbaiki. Form Buat Laporan dari Tugas 11 diberi enam validator yang terpisah dari widget sehingga dapat diuji otomatis, dan source code dipindai oleh tes untuk memastikan tidak ada alamat `http://`, pemanggilan log, atau secret tertulis. Hasil pemeriksaan dicatat pada `security-checklist.md` dan `validasi-input.md`.

## Struktur Folder

```text
230660221002-galih-permana-sidik/
├── lib/
│   ├── main.dart                        form laporan yang diperbarui
│   ├── validators/
│   │   └── validator_laporan.dart       enam validator (fungsi murni)
│   └── services/
│       └── foto_service.dart            dari Tugas 11, memakai validator foto
├── test/
│   ├── validator_laporan_test.dart      kasus lolos dan gagal tiap validator
│   └── keamanan_test.dart               pemindaian source: http://, log, secret
├── jawaban-quiz-pertemuan-12
├── pubspec.yaml
├── security-checklist.md
├── validasi-input.md
├── README.md
└── refleksi.md
```

## Dependency

```yaml
dependencies:
  image_picker: ^1.1.2
dev_dependencies:
  flutter_test:
    sdk: flutter
```

## Menjalankan dan Menguji

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d chrome
```


**Target pengujian:** Chrome (web). Permission kamera dan penolakan izin pada perangkat nyata belum diuji.

### Hasil Pengujian

- `flutter test`: seluruh tes validasi lulus pada Chrome (Windows), termasuk kasus gagal dan lolos untuk keenam validator.
- `flutter analyze`: "No issues found"

## Token dan Permission

**Token:** belum digunakan. SiLapor belum memiliki login dan backend autentikasi, dan endpoint simulasi tidak memerlukan token. Karena itu belum ada token yang disimpan atau dihapus, dan baris 6 pada checklist berstatus Belum. Saat login ditambahkan, rencananya adalah menyimpan token dengan `flutter_secure_storage` melalui antarmuka `TokenStorage` (`simpan`, `baca`, `hapus`), memanggil `hapus()` saat logout, dan tidak pernah mencetak token pada log. Token tidak boleh disimpan pada `shared_preferences`, karena nilainya tersimpan tanpa enkripsi dan dapat dibaca dari perangkat.

**Permission:** hanya kamera atau galeri lewat `image_picker`, dan hanya diminta saat pengguna menekan tombol Kamera atau Galeri, bukan saat aplikasi dibuka. Tidak ada permission lokasi, file, atau notification karena fitur itu tidak dipakai. Rincian konfigurasi platform ada pada `tugas-11/230660221002-galih-permana-sidik/dokumen-fitur-perangkat.md`.

## Batasan Keamanan

- Validasi pada aplikasi hanya pemeriksaan client. Aturan yang sama harus ditegakkan server, dan daftarnya ada pada `validasi-input.md`.
- Backend SiLapor belum ada, sehingga pemeriksaan server, autentikasi, dan hak akses (perbedaan 401 dan 403) belum dapat diuji.
- Tes `keamanan_test.dart` hanya memindai teks pada `lib/` dengan pola sederhana. Tes itu tidak menggantikan audit keamanan.
- Form belum mengirim data ke server. Email kontak dan foto hanya ada di memori selama form terbuka.
- Temuan: pesan error pada `tugas-9/.../service-api.dart` masih meneruskan teks error asli (`$e`) pada kegagalan tak terduga. Sudah diperbaiki pada Tugas 10, tetapi Tugas 9 yang telah dikumpulkan belum diubah.
- Tidak ada token, password, atau data pribadi nyata pada repository.

## Deklarasi Penggunaan AI

Claude dipakai untuk membantu menyusun daftar kasus uji validator, memisahkan aturan validasi ke fungsi murni agar bisa diuji, dan menulis draf tes pemindaian source serta kerangka tabel checklist dan validasi. Penentuan aturan data, penilaian status tiap baris checklist, dan pengujian saya periksa dan jalankan sendiri.
