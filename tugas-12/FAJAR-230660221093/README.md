# Tugas 12 — Validasi dan Keamanan Praktis (Glazent.pro)

| | |
|:--|:--|
| **Nama** | Fajar |
| **NIM** | 230660221093 |
| **Kelas** | SI-VIIA |
| **Domain** | Usaha mikro jasa — Glazent.pro (glass cleaning & nanocoating) |

---

Pembaruan project Flutter (domain **Glazent.pro**, jasa glass cleaning & nanocoating) untuk memenuhi arahan Pertemuan 12: validasi input dan keamanan praktis.

## Isi folder
- `security-checklist.md` — checklist keamanan (>= 10 pemeriksaan), status, dan bukti.
- `validasi-input.md` — tabel aturan validasi client, pemeriksaan server, dan pesan error (>= 5 input).
- `refleksi.md` — refleksi tiga kalimat.
- `kode-project/` — salinan berkas kode utama yang diperbarui/dibuat untuk fitur Tugas 12.
- `README.md` — dokumen ini.

## Perubahan kode (di project)
- **`lib/services/validasi_input.dart`** (baru): validator murni `namaPemohon`, `email`, `catatan`, `tanggalLayanan`, dan sanitasi `trim`.
- **`lib/halaman-validasi-pesanan.dart`** (baru): `Form` dengan `TextFormField` + validator, simulasi kirim aman via HTTPS (konstanta endpoint), catatan token/secure storage & permission, pesan error aman.
- **`lib/main.dart`** (diperbarui): tombol AppBar untuk membuka halaman "Form validasi & keamanan".
- Fitur perangkat & validasi foto yang sudah ada: `lib/services/foto_service.dart`, `lib/services/validasi_foto.dart`, `lib/halaman-bukti-pekerjaan.dart` (permission saat fitur digunakan, penanganan izin ditolak/pembatalan).

## Dependency
- `flutter` (SDK)
- `cupertino_icons: ^1.0.8`
- `http: ^1.3.0` — integrasi REST API
- `image_picker: ^1.2.4` — kamera/galeri bukti pekerjaan (permission sesuai fitur)
- Dev: `flutter_test`, `flutter_lints`

Tidak ada dependency secure storage produksi yang ditambahkan pada build ini; pengelolaan token didokumentasikan secara konseptual (mis. `flutter_secure_storage`) dan wajib mengikuti dokumentasi resmi per platform bila diimplementasikan.

## Cara menjalankan
Dari root project:

```bash
flutter pub get
flutter analyze
flutter run -d chrome
```

- Buka ikon perisai **"Form validasi & keamanan"** di AppBar untuk menguji validator (kondisi gagal/sukses).
- Buka salah satu kartu pesanan untuk alur bukti foto (fitur perangkat) bila tersedia pada target.

## Target pengujian
- **Web (Chrome)**: validasi form, alur UI, simulasi pengiriman. Fitur kamera/galeri bergantung dukungan browser/perangkat; pembatalan dan validasi file tetap ditangani.
- **Android/iOS (jika dijalankan)**: diperlukan untuk menguji permission kamera/galeri dan penyimpanan aman token secara native.

## Batasan keamanan
- API yang digunakan untuk daftar/progres adalah **API simulasi** (`jsonplaceholder`); tidak ada backend Glazent.pro production, tidak ada autentikasi/token nyata, dan data tidak disimpan permanen.
- Token dan HTTPS dijelaskan/dicontohkan secara konseptual; server tetap pemeriksa otoritatif aturan bisnis.
- Belum ada login/logout nyata, refresh token, enkripsi at-rest khusus aplikasi, atau threat modeling/audit formal.
- Tidak ada secret, token, password, atau data pribadi nyata dalam repository.

## Deklarasi penggunaan AI
Pengembangan/perbaikan kode dan dokumen Tugas 12 dibantu oleh AI coding assistant. Seluruh perubahan ditinjau dan disesuaikan dengan kebutuhan project, dokumen pertemuan, dan batasan keamanan yang dicantumkan.
