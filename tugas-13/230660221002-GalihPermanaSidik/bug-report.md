# Bug Report

| | |
|:--|:--|
| **Nama** | Galih Permana Sidik |
| **NIM** | 230660221002 |
| **Kelas** | SI-VIIA |

## BUG-01: Email dengan titik tidak wajar lolos validasi

| Bagian | Isi |
|:-------|:----|
| ID bug | BUG-01 |
| Cara ditemukan | Telaah pola regex pada validator email Tugas 12 dan uji nilai batas (alamat dengan titik beruntun, titik di awal atau akhir). Bukan dari crash |
| Skenario reproduksi | 1. Jalankan `flutter run -d chrome`. 2. Isi kolom Email kontak dengan `dina@kampus..id`. 3. Isi kolom lain dengan nilai valid. 4. Tekan Kirim laporan. Cara lain: jalankan `flutter test test/regresi_email_test.dart` pada kode sebelum perbaikan |
| Expected result | Pesan "Format email tidak valid." tampil dan dialog ringkasan tidak muncul |
| Actual result (sebelum perbaikan) | Validator mengembalikan `null`, form lolos, dan dialog ringkasan tampil dengan email tersebut. Tujuh alamat yang sama sekali tidak wajar diterima: `dina@kampus..id`, `dina..x@kampus.id`, `.dina@kampus.id`, `dina.@kampus.id`, `dina@-kampus.id`, `dina@kampus.id.`, dan `dina@kampus.i`. Pada pemeriksaan pola dengan skrip terpisah, pola lama menerima ketujuhnya. Hasil menjalankan `flutter test test/regresi_email_test.dart` pada kode lama: 5 tes lulus dan 7 tes gagal. Ketujuh yang gagal adalah grup BUG-01, dengan pesan `Expected: 'Format email tidak valid.'`, `Actual: <null>` (contoh: `dina@kampus.i`). Lima yang lulus adalah grup regresi (email valid dan email kosong) |
| Dugaan penyebab | Pola `^[^\s@]+@[^\s@]+\.[^\s@]+$` memakai kelas `[^\s@]` yang berarti "karakter apa pun selain spasi dan @". Titik termasuk di dalamnya, sehingga pola tidak membedakan titik sebagai pemisah dari titik sebagai karakter biasa. Pola hanya mensyaratkan ada satu titik di domain |
| Perbaikan | Pada `lib/validators/validator_laporan.dart`, pola diganti menjadi `^[A-Za-z0-9_%+\-]+(?:\.[A-Za-z0-9_%+\-]+)*@(?:[A-Za-z0-9](?:[A-Za-z0-9\-]*[A-Za-z0-9])?\.)+[A-Za-z]{2,}$`. Bagian lokal dan tiap label domain dipecah per titik. Setiap label harus berisi minimal satu karakter, label domain tidak boleh diawali atau diakhiri strip, dan TLD minimal dua huruf. Hanya satu baris pola yang diubah, bagian lain validator tidak disentuh |
| Test regresi | `test/regresi_email_test.dart`: grup "BUG-01" (7 alamat ditolak) gagal pada kode lama dan lulus setelah perbaikan. Grup "regresi" (4 alamat valid dan email kosong) memastikan email valid tidak ikut tertolak. TC-05 dan TC-06. Tes email yang sudah ada pada `test/validator_laporan_test.dart` dijalankan ulang |
| Hasil setelah perbaikan | `flutter test test/regresi_email_test.dart`: 12 tes lulus (`All tests passed!`). `flutter test` keseluruhan: 49 tes lulus. `flutter analyze`: `No issues found!` |
| Status | Diperbaiki |

### Cara Mereproduksi Kondisi Sebelum Perbaikan

Untuk mendapatkan actual result yang asli, jalankan test regresi pada pola lama terlebih dahulu:

1. Pada `lib/validators/validator_laporan.dart`, ganti sementara isi `_polaEmail` dengan `RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$')`.
2. Jalankan `flutter test test/regresi_email_test.dart`. Tujuh test pada grup BUG-01 seharusnya gagal.
3. Kembalikan pola ke versi perbaikan, lalu jalankan ulang. Seluruh test seharusnya lulus.

## Risiko yang Masih Tersisa

- **Email Unicode ditolak.** Pola hanya menerima ASCII, sehingga alamat berkarakter non-ASCII ditolak. Untuk pengguna kampus saat ini hal ini jarang terjadi, tetapi tetap batasan.
- **Pola hanya memeriksa bentuk.** Alamat yang bentuknya benar belum tentu ada. Verifikasi alamat menjadi urusan server.
- **Batas 30 hari memakai `Duration(days: 30)`.** Pada zona waktu yang memiliki pergantian waktu musim panas, pengurangan jam dapat menggeser batas sejauh satu hari. Di Indonesia hal ini tidak terjadi, tetapi belum diuji pada zona lain. Perbaikannya dengan menghitung tanggal kalender, bukan durasi jam.
- **Pesan error Tugas 9.** `tugas-9/.../service-api.dart` masih meneruskan teks error asli (`$e`) pada kegagalan tak terduga. Sudah diperbaiki pada Tugas 10 tetapi Tugas 9 yang telah dikumpulkan belum diubah.
- **Permission nyata.** Penolakan izin kamera hanya diuji lewat simulasi pada web, belum pada perangkat.
- **`FotoService` belum punya test otomatis.** Pemanggilan `image_picker` memerlukan platform channel palsu, sehingga TC-08 dan TC-09 masih manual.
