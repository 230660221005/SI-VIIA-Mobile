# Security Checklist — Tugas 12 (Glazent.pro)

Domain project: **Glazent.pro** (jasa glass cleaning & nanocoating), konsisten dengan Tugas 1–11.

| No. | Risiko atau pemeriksaan | Status | Bukti |
|:---:|:------------------------|:------:|:------|
| 1 | Input wajib divalidasi | Selesai | `lib/services/validasi_input.dart` (validator `namaPemohon`, `email`, `catatan`, `tanggalLayanan`), `lib/halaman-validasi-pesanan.dart` (`Form` + `TextFormField.validator`), `validasi-input.md` |
| 2 | Format input diperiksa | Selesai | Validasi format email (regex) dan format/tanggal valid (`DateTime.tryParse`) di `lib/services/validasi_input.dart` |
| 3 | HTTPS digunakan untuk data sensitif | Sebagian | Konstanta endpoint contoh `https://api.glazent.pro/pengajuan` di `lib/halaman-validasi-pesanan.dart` dan asersi `startsWith('https://')`. Integrasi API simulasi saat ini masih memakai `https://jsonplaceholder.typicode.com` (bukan data sensitif produksi) di `lib/services/integrasi_service.dart` dan `lib/service-api.dart`. Perlu endpoint backend production HTTPS untuk data akun/token nyata. |
| 4 | Token tidak ditulis pada source code | Selesai | Tidak ada token/kredensial hardcoded. Abstraksi `TokenStorage` di `lib/halaman-validasi-pesanan.dart` tanpa nilai token. Pemeriksaan manual pada kode project. |
| 5 | Token tidak dicetak pada log | Selesai | Tidak ada `print/log` header `Authorization` atau body sensitif. Logging error di `lib/services/integrasi_service.dart` hanya mencatat kejadian umum tanpa kredensial; UI menampilkan pesan aman. |
| 6 | Token dihapus saat logout | Belum | Fitur login/logout dan token backend belum diimplementasikan. Kontrak `TokenStorage.hapus()` didokumentasikan untuk alur logout saat backend tersedia. |
| 7 | Permission sesuai fitur | Selesai | Permission kamera/galeri hanya relevan saat melampirkan bukti foto pekerjaan (`lib/halaman-bukti-pekerjaan.dart`, `lib/services/foto_service.dart`, dependency `image_picker`). Form validasi tidak meminta permission. |
| 8 | Permission ditolak ditangani | Selesai | `IzinDitolakException` dan pesan/tombol coba lagi di `lib/services/foto_service.dart` dan `lib/halaman-bukti-pekerjaan.dart`; pembatalan pemilihan diperlakukan bukan error. |
| 9 | Pesan error tidak membocorkan data | Selesai | Pesan ke pengguna bersifat umum (contoh: "Pengajuan gagal diproses. Silakan coba lagi." di `lib/halaman-validasi-pesanan.dart`, pesan `ApiException` tanpa stack trace di service). |
| 10 | Dependency dan batasan didokumentasikan | Selesai | `pubspec.yaml`, `README.md` (root), dan `tugas-12/README.md` mencantumkan dependency, cara menjalankan, target pengujian, batasan keamanan. |

## Catatan bukti
- Bukti berupa berkas kode dan dokumen dalam repository/branch tugas.
- Pengujian kondisi gagal validator dapat dilakukan melalui halaman "Form validasi & keamanan" (ikon perisai pada AppBar halaman utama).
- Tidak ada token, password, atau data pribadi nyata yang disertakan.
