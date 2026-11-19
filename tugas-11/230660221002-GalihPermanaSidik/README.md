# Tugas 11: Integrasi Fitur Perangkat
| | |
|:--|:--|
| **Nama** | Galih Permana Sidik |
| **NIM** | 230660221002 |
| **Kelas** | SI-VIIA |
| **Project** | SiLapor Kampus (pelaporan kerusakan fasilitas kampus) |

## Deskripsi Singkat

Form Buat Laporan kini dapat melampirkan foto kerusakan dari kamera atau galeri memakai `image_picker`. Pemilihan foto dibedakan menjadi berhasil, dibatalkan (state sebelumnya dipertahankan), izin ditolak, format atau ukuran tidak valid, dan error perangkat. Package hanya dikenal oleh `FotoService`, sedangkan widget memilih tampilan berdasarkan hasilnya. Alasan memilih fitur ini ada pada [`dokumen-fitur-perangkat.md`](dokumen-fitur-perangkat.md).

## Struktur Folder

```text
230660221002-galih-permana-sidik/
├── lib/
│   ├── main.dart                  form laporan dan bagian foto
│   └── services/
│       └── foto_service.dart      satu-satunya pengguna image_picker
├── pubspec.yaml
├── README.md
├── dokumen-fitur-perangkat.md     analisis kebutuhan, permission, diagram kondisi
├── skenario-pengujian.md          skenario, expected dan actual result
├── jawaban-quiz-pertemuan-11
└── refleksi.md
```

## Dependency

Pada `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  image_picker: ^1.1.2
```

## Konfigurasi Permission

| Platform | Konfigurasi |
|:---------|:------------|
| Web | Tidak ada |
| Android | Tidak ada tambahan untuk `image_picker`. Bila `CAMERA` dideklarasikan pada manifest, izin diminta saat runtime |
| iOS | `NSCameraUsageDescription` dan `NSPhotoLibraryUsageDescription` pada `ios/Runner/Info.plist` |

Rincian dan alasan ada pada dokumen fitur bagian 4. Konfigurasi mengikuti dokumentasi package.

## Target Verifikasi

- **Chrome (web):** alur galeri, validasi, pembatalan, state, dan tampilan.
- **Simulasi:** izin ditolak dan error perangkat, lewat `FotoService.simulasi`.
- **Android atau iOS:** diperlukan untuk kamera langsung dan penolakan izin yang sebenarnya. Isi target yang benar-benar dipakai pada `skenario-pengujian.md`.

## Menjalankan Aplikasi

```bash
flutter pub get
flutter analyze
flutter run -d chrome
```

Bila folder ini belum berupa project Flutter lengkap (belum ada `web/`), jalankan `flutter create .` sekali pada folder ini, lalu pastikan `image_picker` masih tercatat pada `pubspec.yaml`. Alternatifnya, salin `lib/` dan `pubspec.yaml` ke project `silapor_kampus` yang sudah ada.

## Kondisi pada Bagian Foto

| Kondisi | Tampilan |
|:--------|:---------|
| Loading | Indikator dan "Memproses foto...", tombol Kamera, Galeri, dan Kirim nonaktif |
| Berhasil | Preview gambar, nama, ukuran, tombol hapus |
| Dibatalkan | SnackBar singkat. Foto sebelumnya tetap tampil, bukan pesan error |
| Izin ditolak | Kartu "Izin ditolak" dengan langkah membuka Pengaturan dan tombol Coba Lagi |
| Tidak valid | Kartu dengan alasan (format atau ukuran) dan tombol Coba Lagi |
| Error | Kartu "Foto gagal diambil" dan tombol Coba Lagi |

## Batasan

- Foto disimpan di state form dan hilang saat form ditutup. Penyimpanan lokal permanen dan unggah ke server belum ada karena backend SiLapor belum tersedia.
- Tombol Kirim hanya menampilkan ringkasan laporan.
- Kamera langsung dan penolakan izin pada perangkat nyata belum dibuktikan pada web.
- Pengaturan lebar 1600 px dan kualitas 80 mungkin diabaikan pada web, sehingga validasi ukuran 5 MB menjadi pengaman utama.
- Tidak ada token atau data pribadi pada source code.

## Refleksi dan Deklarasi AI

Ada pada [`refleksi.md`](refleksi.md).
