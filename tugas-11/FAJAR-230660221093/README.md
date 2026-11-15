# Tugas 11 — Integrasi Fitur Perangkat

| | |
|:--|:--|
| **Nama** | Fajar |
| **NIM** | 230660221093 |
| **Kelas** | SI-VIIA |
| **Domain** | Usaha mikro jasa — Glazent.pro (glass cleaning & nanocoating) |
| **Fitur perangkat** | Kamera dan galeri (`image_picker`) |

---

## 1. Deskripsi Singkat

Tugas ini menambahkan fitur kamera dan galeri pada aplikasi Glazent.pro untuk memenuhi **F-05** (teknisi melampirkan foto kondisi kaca sebelum dan sesudah pengerjaan). Halaman "Bukti Pekerjaan" memiliki dua slot foto. Hasil foto dipakai pada alur bisnis: tombol **Tandai Selesai** (F-06) hanya aktif bila kedua foto sudah dilampirkan.

Service `FotoService` memisahkan package dari widget dan membedakan empat hasil: foto berhasil, **dibatalkan** (`null`, bukan error), **izin ditolak**, dan **error**. Halaman menangani loading, berhasil, dibatalkan, izin ditolak, error, dan validasi gagal, masing-masing dengan tombol "Coba Lagi" bila relevan.

Analisis pemilihan fitur, permission, siklus kondisi, dan keterbatasan ada pada [`dokumen-fitur-perangkat.md`](dokumen-fitur-perangkat.md) ini juga sebagai jawaban dari quiz 02-Quiz-Pertemuan-11.md.

## 2. Struktur Proyek

```text
tugas-11/<nim>-<nama>/
├── lib/
│   ├── main.dart                     # halaman dan widget (tanpa image_picker langsung)
│   └── services/
│       ├── foto_service.dart         # image_picker, pembedaan batal/izin/error
│       └── validasi_foto.dart        # aturan format dan ukuran
├── pubspec.yaml
├── README.md
├── dokumen-fitur-perangkat.md
├── diagram-state-foto.png
└── refleksi.md
```

## 3. Dependency

Pada `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  image_picker: ^1.1.2
```

## 4. Konfigurasi Permission

| Platform | Konfigurasi |
|:---------|:------------|
| Web | Tidak diperlukan |
| Android | Mengikuti dokumentasi `image_picker`; umumnya tidak memerlukan deklarasi izin tambahan |
| iOS | Tambahkan `NSCameraUsageDescription` dan `NSPhotoLibraryUsageDescription` pada `ios/Runner/Info.plist` |

Isi `Info.plist` dan penjelasan lengkap ada pada [`dokumen-fitur-perangkat.md`](dokumen-fitur-perangkat.md), bagian 3.

## 5. Target Verifikasi

Web (Chrome) pada Windows. Android dan iOS belum diuji.

## 6. Cara Menjalankan

Dari folder project Flutter (target web):

```bash
flutter pub add image_picker
```

Salin folder `lib/` dari tugas ini ke project (menimpa `lib/` yang lama), atau buat project baru dengan `flutter create glazent_fitur_perangkat` lalu salin `lib/` dan `pubspec.yaml`. Kemudian:

```bash
flutter pub get
flutter analyze
flutter run -d chrome
```

Tidak ada token atau data pribadi pada source code.

## 7. Batasan Pengujian pada Web

- Pada Chrome desktop, tombol **Kamera** umumnya membuka pemilih file, bukan kamera langsung. Kamera langsung memerlukan perangkat Android atau iOS.
- Web tidak menampilkan dialog izin untuk memilih file, sehingga skenario **izin ditolak** dan **error package** tidak dapat dipicu sungguhan. Keduanya diuji dengan mode simulasi.
- Pengujian izin sungguhan dan kamera langsung memerlukan perangkat Android atau iOS.

### Mode simulasi

Pada `lib/services/foto_service.dart` terdapat konstanta:

```dart
static const SimulasiFoto simulasi = SimulasiFoto.tidak;
```

Ubah sementara menjadi `SimulasiFoto.izinDitolak` atau `SimulasiFoto.error` untuk menguji kedua skenario pada web, lalu kembalikan ke `SimulasiFoto.tidak`.

## 8. Keterbatasan

- Foto belum dikirim ke server dan hanya tersimpan pada state aplikasi.
- Data tugas pada halaman berupa contoh statis.
- Setiap slot hanya menampung satu foto.

## 9. Deklarasi Penggunaan AI

Deklarasi penggunaan AI: Claude (Anthropic) — membantu menyusun kerangka service fitur perangkat (pembedaan batal, izin ditolak, error), validasi foto, halaman dua slot foto, diagram, dan dokumentasi berdasarkan domain Glazent.pro dari Tugas 4 dan 10; perbaikan kode, pengujian, dan penjelasan dilakukan serta diverifikasi oleh penulis.
