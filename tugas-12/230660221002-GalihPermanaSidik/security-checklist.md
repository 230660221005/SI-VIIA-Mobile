# Security Checklist: SiLapor Kampus

| | |
|:--|:--|
| **Nama** | Galih Permana Sidik |
| **NIM** | 230660221002 |
| **Kelas** | SI-VIIA |


Konteks: SiLapor belum memiliki backend dan belum memiliki fitur login. Kondisi ini memengaruhi baris 4 sampai 6 dan dijelaskan pada kolom bukti.

| No. | Risiko atau pemeriksaan | Status | Bukti |
|:---:|:------------------------|:------:|:------|
| 1 | Input wajib divalidasi | Selesai | `lib/validators/validator_laporan.dart` (validator `lokasi`, `kategori`, `deskripsi`, `tanggalKejadian`), terpasang pada kolom form di `lib/main.dart`. Kasus kosong diuji pada `test/validator_laporan_test.dart` |
| 2 | Format input diperiksa | Selesai | Validator `email` (format dan panjang), `tanggalKejadian` (rentang 30 hari ke belakang), `fotoBerkas` (JPG/PNG, maksimal 5 MB) pada `lib/validators/validator_laporan.dart`. Kasus gagal tiap validator diuji pada `test/validator_laporan_test.dart` |
| 3 | HTTPS digunakan untuk data sensitif | Selesai | Tes "tidak ada alamat http:// tanpa TLS" pada `test/keamanan_test.dart`. Pemeriksaan manual: pemanggilan HTTP pada `tugas-9/230660221002-galih-permana-sidik/service-api.dart` dan `tugas-10/230660221002-galih-permana-sidik/lib/services/integrasi_service.dart` seluruhnya memakai `Uri.https`, dan pencarian `http://` pada kode Tugas 9, 10, dan 11 tidak menemukan hasil. Batasan: endpoint yang dipakai adalah API simulasi publik dan belum membawa data sensitif |
| 4 | Token tidak ditulis pada source code | Selesai | Tes "tidak ada secret atau token tertulis" pada `test/keamanan_test.dart`. Pencarian manual pola password, secret, token, API key, dan `Bearer ` pada kode Tugas 9 sampai 12 tidak menemukan hasil. Berlaku karena SiLapor belum memiliki token. Periksa ulang saat login ditambahkan |
| 5 | Token tidak dicetak pada log | Selesai | Tes "tidak ada print atau debugPrint" pada `test/keamanan_test.dart`. Pencarian manual pada kode Tugas 9 sampai 12 tidak menemukan `print` atau `debugPrint`. Berlaku karena belum ada token dan belum ada logging. Periksa ulang saat logging ditambahkan |
| 6 | Token dihapus saat logout | Belum | Belum ada fitur login dan logout, sehingga belum ada token yang dihapus. Rencana: antarmuka `TokenStorage` dengan `flutter_secure_storage`, serta `hapus()` dipanggil saat logout, setelah backend autentikasi tersedia. Lihat README bagian Token dan Permission |
| 7 | Permission sesuai fitur | Selesai | Permission kamera atau galeri hanya terpicu saat tombol Kamera atau Galeri ditekan (`_pilihFoto` pada `lib/main.dart`), tidak saat aplikasi dibuka. Alasan pemilihan fitur ada pada `tugas-11/230660221002-galih-permana-sidik/dokumen-fitur-perangkat.md`. Tidak ada permission lokasi, file, atau notification |
| 8 | Permission ditolak ditangani | Sebagian | Ditangani pada `lib/services/foto_service.dart` (`FotoException` jenis `izinDitolak`) dan tampil sebagai kartu "Izin ditolak" dengan tombol Coba Lagi. Skenario 3 pada `tugas-11/230660221002-galih-permana-sidik/skenario-pengujian.md` diuji lewat simulasi pada Chrome. Belum diuji pada perangkat Android atau iOS sungguhan |
| 9 | Pesan error tidak membocorkan data | Sebagian | `lib/services/foto_service.dart` dan `tugas-10/230660221002-galih-permana-sidik/lib/services/integrasi_service.dart` memakai pesan umum pada kegagalan tak terduga (`catch (_)`), tanpa teks error asli. Temuan: `tugas-9/230660221002-galih-permana-sidik/service-api.dart` baris `ApiException('Terjadi kegagalan yang tidak terduga: $e')` meneruskan teks error ke layar. Sudah diperbaiki pada Tugas 10, tetapi Tugas 9 yang sudah dikumpulkan belum diubah |
| 10 | Dependency dan batasan didokumentasikan | Selesai | `README.md` bagian Dependency dan Batasan Keamanan, serta `pubspec.yaml` (`image_picker`, `flutter_test`). Validasi dan pemeriksaan server yang dibutuhkan ada pada `validasi-input.md` |

## Ringkasan

| Status | Jumlah |
|:-------|:------:|
| Selesai | 7 |
| Sebagian | 2 |
| Belum | 1 |

Checklist ini menunjukkan pemeriksaan yang sudah dilakukan, bukan bukti bahwa aplikasi bebas risiko. Tes pemindaian teks pada `test/keamanan_test.dart` hanya mendeteksi pola sederhana dan tidak menggantikan audit keamanan.
