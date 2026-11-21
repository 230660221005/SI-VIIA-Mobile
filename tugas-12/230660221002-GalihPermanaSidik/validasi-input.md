# Validasi Input: Form Buat Laporan

| | |
|:--|:--|
| **Nama** | Galih Permana Sidik |
| **NIM** | 230660221002 |
| **Kelas** | SI-VIIA |

Aturan client sudah diterapkan dan diuji. Kolom **Pemeriksaan server** menuliskan apa yang wajib dilakukan backend SiLapor. Backend itu belum ada (data simulasi JSONPlaceholder tidak memeriksa apa pun), jadi kolom tersebut adalah kebutuhan, bukan fitur yang sudah berjalan.

| Input | Aturan client | Pemeriksaan server | Pesan error |
|:------|:--------------|:-------------------|:------------|
| Lokasi | Wajib. Setelah `trim()` tidak kosong dan maksimal 100 karakter (`ValidatorLaporan.lokasi`) | Tipe string, panjang maksimal 100, tolak karakter kontrol | "Lokasi wajib diisi." / "Lokasi maksimal 100 karakter." |
| Kategori | Wajib dipilih dan harus termasuk daftar Proyektor, AC, Keran, Kursi (`ValidatorLaporan.kategori`) | Nilai harus ada pada daftar kategori resmi di server, karena request dapat dibuat tanpa aplikasi | "Kategori wajib dipilih." / "Kategori tidak dikenal." |
| Tanggal kejadian | Wajib. Tidak boleh setelah hari ini dan paling lama 30 hari ke belakang (`ValidatorLaporan.tanggalKejadian`). Kolom hanya dapat diisi lewat pemilih tanggal | Format tanggal valid, rentang diperiksa memakai jam server, bukan jam perangkat yang bisa diubah pengguna | "Tanggal kejadian wajib dipilih." / "...tidak boleh di masa depan." / "...maksimal 30 hari ke belakang." |
| Deskripsi | Wajib. Setelah `trim()` antara 10 dan 500 karakter (`ValidatorLaporan.deskripsi`). Kolom juga membatasi `maxLength` 500 | Panjang 10 sampai 500, simpan sebagai teks biasa dan tampilkan dengan escaping agar tidak menjadi markup | "Deskripsi wajib diisi." / "Deskripsi minimal 10 karakter." / "Deskripsi maksimal 500 karakter." |
| Email kontak (opsional) | Boleh kosong. Bila diisi, format `x@y.z` dan maksimal 254 karakter (`ValidatorLaporan.email`) | Format, panjang, dan keunikan akun. Email tidak dianggap terverifikasi sebelum ada konfirmasi | "Format email tidak valid." / "Email maksimal 254 karakter." |
| Foto lampiran (opsional) | Format JPG atau PNG dan maksimal 5 MB (`ValidatorLaporan.fotoBerkas`, dipakai `FotoService`) | Periksa tipe berdasarkan isi berkas, bukan nama atau ekstensi, batasi ukuran, dan hapus metadata seperti koordinat GPS sebelum disimpan | "Format foto tidak didukung. Gunakan JPG atau PNG." / "Ukuran foto melebihi 5 MB. Pilih foto yang lebih kecil." |

## Data yang Perlu Dilindungi

| Data | Alasan | Perlakuan saat ini |
|:-----|:-------|:-------------------|
| Email kontak | Data pribadi | Hanya ditampilkan pada dialog ringkasan, tidak disimpan dan tidak dikirim ke mana pun |
| Foto | Dapat memuat wajah orang atau metadata lokasi | Hanya disimpan di memori selama form terbuka, tidak diunggah |
| Lokasi, kategori, deskripsi | Informasi fasilitas, bukan data sensitif | Hanya ditampilkan pada ringkasan |

## Lokasi Validator dan Cara Mengujinya

Semua validator ada di `lib/validators/validator_laporan.dart` dan dipasang pada kolom form di `lib/main.dart`.

**Pengujian otomatis**

```bash
flutter test test/validator_laporan_test.dart
```

Berkas itu memuat kasus gagal dan kasus lolos untuk keenam validator.

**Pengujian manual di aplikasi** (`flutter run -d chrome`), tekan **Kirim laporan** dengan kondisi berikut:

| No | Kondisi uji | Hasil yang diharapkan | Hasil pengujian |
|:--:|:------------|:----------------------|:----------------|
| 1 | Form kosong | Pesan wajib diisi pada lokasi, kategori, tanggal, dan deskripsi. Email dan foto tidak menghalangi karena opsional | Sesuai |
| 2 | Lokasi lebih dari 100 karakter | "Lokasi maksimal 100 karakter." | Sesuai |
| 3 | Deskripsi "rusak" | "Deskripsi minimal 10 karakter." | Sesuai |
| 4 | Email "dina@kampus" | "Format email tidak valid." | Sesuai |
| 5 | Tanggal belum dipilih | "Tanggal kejadian wajib dipilih." Pemilih tanggal membatasi pilihan pada 30 hari terakhir | Sesuai |
| 6 | Foto GIF atau lebih dari 5 MB | Kartu "Foto tidak dapat dipakai" dengan alasan format atau ukuran | Sesuai |
| 7 | Semua kolom valid | Dialog ringkasan laporan tampil | Sesuai |

**Pengujian otomatis:** `flutter test` lulus seluruhnya, termasuk kasus gagal dan lolos untuk keenam validator pada `test/validator_laporan_test.dart`.

## Catatan

Validasi client hanya memberi umpan balik cepat. Siapa pun dapat membuat request tanpa melewati aplikasi, sehingga seluruh aturan pada kolom Pemeriksaan server harus ditegakkan di backend.