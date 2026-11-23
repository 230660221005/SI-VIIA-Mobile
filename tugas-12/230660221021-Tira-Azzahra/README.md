# Tugas 12: Validasi Input dan Keamanan Praktis

| | |
|:--|:--|
| **Nama** | Tira Azzahra |
| **NIM** | 230660221021 |
| **Kelas** | SI-VIIA |
| **Project** | SI Perpustakaan Kampus (Pengajuan Peminjaman Buku) |

## Deskripsi Singkat

Form **Pengajuan Peminjaman Buku** pada SI Perpustakaan Kampus kini dilengkapi lapisan validasi input pada sisi client dan pemeriksaan keamanan praktis sebelum transaksi dikirim. Seluruh aturan validasi (field wajib, pola NIM 12 digit, format email, batas panjang judul buku, rentang durasi pinjam 1–14 hari, serta batas ukuran lampiran foto maksimal 5 MB) dipisahkan ke dalam `PengajuanValidator`, sementara pengecekan protokol `https://`, pengelolaan sesi token sementara, dan penghapusan token saat logout ditangani oleh `KeamananPerpustakaanService`.

## Struktur Folder

```text
230660221021-Tira-Azzahra/
├── lib/
│   ├── main.dart                                  # Form pengajuan bervalidator & kontrol sesi
│   ├── validators/
│   │   └── pengajuan_validator.dart               # Kumpulan validator input form & file
│   └── services/
│       └── keamanan_perpustakaan_service.dart     # Validasi HTTPS, manajemen token sesi & logout
├── pubspec.yaml                                   # Konfigurasi dependency project
├── README.md                                      # Dokumentasi lengkap tugas, konfigurasi & pengujian
├── security-checklist.md                          # 10 pemeriksaan risiko keamanan & bukti verifikasi
├── validasi-input.md                              # Matriks aturan validasi client vs server
├── jawaban-quiz-pertemuan-12.md                   # Jawaban kuis formatif pertemuan 12
└── refleksi.md                                    # Refleksi 3 kalimat & deklarasi penggunaan AI
```

## Dependency

Pada `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
```

*(Seluruh validator menggunakan Dart core `RegExp`, `Form`, dan `TextFormField` tanpa menambah package eksternal yang tidak perlu, sesuai prinsip meminimalkan permukaan risiko dependency).*

## Konfigurasi Keamanan & Permission

| Aspek | Konfigurasi & Penerapan |
|:--|:--|
| **Protokol Transport** | Seluruh request wajib melalui `https://` yang diverifikasi oleh `KeamananPerpustakaanService.isEndpointAman()`. |
| **Penyimpanan Token** | Menggunakan abstraksi `TokenStorage` (`MemoryTokenStorage` untuk simulasi; `flutter_secure_storage` untuk target production Android/iOS). Token tidak pernah ditulis pada source code maupun dicetak pada `print()` / log. |
| **Penghapusan Sesi** | Tombol **Logout** memanggil `_keamananService.logout()` yang mengosongkan token aktif dari storage. |
| **Permission Perangkat** | Menerapkan prinsip *least privilege*: permission kamera/galeri dari Tugas 11 hanya diminta saat pengguna menekan tombol lampiran foto, bukan saat halaman dibuka. |

## Target Verifikasi

- **Chrome (web):** Pengujian interaktif 6 validator input (kosong, format NIM salah, format email salah, judul buku terlalu pendek/panjang, durasi di luar 1–14 hari, dan ukuran lampiran > 5 MB), pengecekan status token sesi (HTTP 401 saat belum login), serta penghapusan token saat logout.
- **Static Analysis:** `flutter analyze` untuk memastikan bebas error dan warning.
- **Android / iOS (rencana lanjutan):** Diperlukan apabila `flutter_secure_storage` berbasis Keystore/Keychain diaktifkan pada tahap backend nyata.

## Menjalankan Aplikasi

```bash
flutter pub get
flutter analyze
flutter run -d chrome
```

Bila folder ini belum berupa project Flutter lengkap (belum ada direktori `web/`), jalankan `flutter create .` sekali pada folder ini atau salin folder `lib/` dan `pubspec.yaml` ke project Flutter uji yang sudah ada.

## Kondisi Validasi & Keamanan pada Halaman

| Kondisi | Tampilan |
|:--|:--|
| **Input Kosong / Format Salah** | Pesan error spesifik muncul di bawah kolom terkait secara *real-time* (`AutovalidateMode.onUserInteraction`) dan pengiriman diblokir. |
| **Ukuran Lampiran > 5 MB** | Kartu peringatan merah muncul dengan pesan *"Ukuran file lampiran maksimal 5 MB."* |
| **Belum Aktifkan Sesi (Token Kosong)** | Pengiriman ditolak dengan pesan *"Sesi akses tidak ditemukan (HTTP 401). Silakan aktifkan sesi terlebih dahulu."* |
| **Sesi Aktif & Seluruh Input Valid** | Kartu konfirmasi hijau muncul menampilkan ringkasan data tervalidasi siap kirim melalui `https://`. |
| **Logout Ditekan** | Token dihapus dari `TokenStorage`, status sesi kembali menjadi *"Belum Login (Token Kosong)"*. |

## Security Checklist — SI Perpustakaan Kampus

| No. | Risiko atau Pemeriksaan | Status | Bukti |
|:---:|:------------------------|:------:|:------|
| 1 | Input wajib divalidasi | Selesai | `lib/validators/pengajuan_validator.dart` (fungsi `validasiNama`, `validasiNim`, `validasiEmail`, `validasiJudulBuku`, `validasiDurasiHari` menolak input kosong/spasi) dan diuji pada form Chrome. |
| 2 | Format input diperiksa | Selesai | `PengajuanValidator.validasiNim` memeriksa 12 digit angka (`^\d{12}$`), `validasiEmail` memeriksa pola email, dan `validasiDurasiHari` membatasi rentang 1–14 hari. |
| 3 | HTTPS digunakan untuk data sensitif | Selesai | `KeamananPerpustakaanService.baseUrl` menggunakan `https://jsonplaceholder.typicode.com` dan diverifikasi melalui method `isEndpointAman()`. |
| 4 | Token tidak ditulis pada source code | Selesai | Pemeriksaan seluruh berkas di folder `lib/` menunjukkan tidak ada hardcoded API key, password, atau Bearer token statis. |
| 5 | Token tidak dicetak pada log | Selesai | Tidak terdapat pemanggilan `print()` atau `debugPrint()` yang menampilkan isi token pada `keamanan_perpustakaan_service.dart` maupun `main.dart`. |
| 6 | Token dihapus saat logout | Selesai | Method `KeamananPerpustakaanService.logout()` memanggil `_tokenStorage.hapus()` yang mengosongkan token aktif ketika tombol **Logout** ditekan. |
| 7 | Permission sesuai fitur | Selesai | Menerapkan prinsip *least privilege*: aplikasi hanya memakai kamera/galeri saat lampiran foto diminta dan tidak meminta permission lokasi/kontak yang tidak relevan. |
| 8 | Permission ditolak ditangani | Selesai | Ditangani pada `LampiranFotoService` (Tugas 11) dengan menangkap `PlatformException` dan menampilkan pesan panduan izin tanpa *crash*. |
| 9 | Pesan error tidak membocorkan data | Selesai | Blok `try-catch` pada `main.dart` menampilkan pesan ringkas yang ramah pengguna tanpa memunculkan stack trace, kredensial, atau struktur internal server. |
| 10 | Dependency dan batasan didokumentasikan | Selesai | Tercatat lengkap pada bagian *Dependency*, *Konfigurasi Keamanan & Permission*, dan *Batasan Keamanan*. |

## Batasan Keamanan

- Backend SI Perpustakaan Kampus belum tersedia secara *live*, sehingga autentikasi token menggunakan simulasi `MemoryTokenStorage` pada sisi client.
- Validasi pada Flutter (`PengajuanValidator`) berfungsi sebagai pertahanan lapis pertama untuk kenyamanan pengguna; validasi otoritatif tetap wajib dilakukan ulang di sisi server API.
- Tidak ada token nyata, password, maupun data pribadi sensitif yang dicantumkan pada source code atau repository.

## Refleksi dan Deklarasi AI

Refleksi 3 kalimat dan deklarasi penggunaan AI tersedia lengkap pada berkas `refleksi.md`.