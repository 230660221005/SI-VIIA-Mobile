# Test Case: Form Buat Laporan SiLapor Kampus

| | |
|:--|:--|
| **Nama** | Galih Permana Sidik |
| **NIM** | 230660221002 |
| **Kelas** | SI-VIIA |

Expected result ditulis sebelum pengujian. Kolom **Actual result** dan **Status** diisi dari hasil menjalankan skenario, bukan ditebak. Status: `Lulus` atau `Gagal`. Pengujian otomatis dijalankan dengan `flutter test`, pengujian manual dengan `flutter run -d chrome`.

**Target pengujian:** Chrome (web) di Windows. Pengujian otomatis dengan `flutter test`, pengujian manual dengan `flutter run -d chrome`. Kamera langsung dan penolakan izin pada perangkat nyata tidak diuji.

| ID | Skenario | Kondisi awal | Langkah | Expected result | Actual result | Status |
|:---|:---------|:-------------|:--------|:----------------|:--------------|:------:|
| TC-01 | Fitur berhasil: semua kolom valid | Form kosong | Manual. Isi lokasi, pilih kategori, pilih tanggal, isi deskripsi 10 karakter atau lebih, tekan Kirim laporan | Dialog "Ringkasan laporan" tampil berisi kategori, lokasi, tanggal, dan deskripsi | Sesuai. Dialog "Ringkasan laporan" tampil dengan "AC di ruang 6a", tanggal kejadian 20/11/2026, deskripsi "AC ruang 6a bocor", dan teks "Tanpa foto lampiran." | Lulus |
| TC-02 | Input tidak valid: form kosong | Form kosong | Otomatis (`widget_form_test.dart`, "form kosong menampilkan semua pesan wajib"). Tekan Kirim laporan tanpa mengisi | Muncul pesan wajib pada lokasi, kategori, tanggal, dan deskripsi. Dialog ringkasan tidak tampil | Widget test lulus. Setelah Kirim laporan ditekan pada form kosong, empat pesan wajib tampil dan dialog ringkasan tidak muncul | Lulus |
| TC-03 | Input tidak valid: deskripsi pendek | Form kosong | Otomatis (`widget_form_test.dart`, "deskripsi kurang dari 10 karakter"). Isi deskripsi "rusak", tekan Kirim laporan | Pesan "Deskripsi minimal 10 karakter." tampil | Widget test lulus. Pesan "Deskripsi minimal 10 karakter." tampil | Lulus |
| TC-04 | Input tidak valid: email tidak lengkap | Form kosong | Otomatis (`widget_form_test.dart`, "email tidak lengkap ditolak"). Isi email `dina@kampus`, tekan Kirim laporan | Pesan "Format email tidak valid." tampil | Widget test lulus. Pesan "Format email tidak valid." tampil | Lulus |
| TC-05 | Input tidak valid: email dengan titik beruntun (BUG-01) | Form kosong | Otomatis (`regresi_email_test.dart`, grup BUG-01). Validasi `dina@kampus..id` dan enam alamat serupa. Manual: isi email `dina@kampus..id`, tekan Kirim laporan | Setiap alamat ditolak dengan "Format email tidak valid." | Sebelum perbaikan: 7 dari 7 alamat lolos (`Actual: <null>`), test gagal. Setelah perbaikan: ketujuh ditolak dengan pesan yang diharapkan, test lulus. Pengujian manual: pesan "Format email tidak valid." tampil | Gagal (sebelum perbaikan), Lulus (sesudah) |
| TC-06 | Regresi: email valid tetap diterima | Form kosong | Otomatis (`regresi_email_test.dart`, grup regresi). Validasi `dina@kampus.ac.id`, `dina.p+lapor@mail.kampus.ac.id`, `a_b-c@x1.co`, `a@b.co`, dan email kosong | Semua diterima (tanpa pesan error) | Lulus pada kode lama dan pada kode perbaikan. Email valid tidak ikut tertolak | Lulus |
| TC-07 | Kondisi kosong: belum ada foto | Form baru dibuka | Otomatis (`widget_form_test.dart`, "kondisi awal menampilkan bagian foto kosong") | Teks "Belum ada foto. Foto membantu petugas menilai kerusakan." dan tombol Kamera serta Galeri tampil | Widget test lulus. Teks foto kosong beserta tombol Kamera dan Galeri tampil | Lulus |
| TC-08 | Pembatalan pemilihan foto | Sudah ada satu foto terpilih | Manual. Tekan Galeri, tutup dialog pilih berkas tanpa memilih | SnackBar "Pemilihan foto dibatalkan." tampil, foto sebelumnya tetap tampil, tidak ada pesan error | Sesuai dengan expected result. Pembatalan tidak menampilkan error | Lulus |
| TC-09 | Kondisi error: perangkat gagal | `FotoService.simulasi` diubah menjadi `SimulasiFoto.error` | Manual. Tekan Kamera atau Galeri | Kartu "Foto gagal diambil" dengan tombol Coba Lagi, tanpa stack trace | Sesuai dengan expected result. Kartu error dan tombol Coba Lagi tampil | Lulus |
| TC-10 | Input tidak valid: foto lebih dari 5 MB | Form baru dibuka | Otomatis (`validator_laporan_test.dart`, grup "berkas foto"). Manual: pilih foto lebih dari 5 MB | Pesan "Ukuran foto melebihi 5 MB. Pilih foto yang lebih kecil." tampil | Unit test `fotoBerkas` untuk ukuran lebih dari 5 MB lulus. Pengujian manual dengan foto lebih dari 5 MB belum dijalankan | Sebagian |
| TC-11 | Seluruh test otomatis | Dependency terpasang | `flutter test` | Seluruh tes pada folder `test/` lulus (49 tes) | `flutter test` memuat 49 tes dan seluruhnya lulus (`+49: All tests passed!`) setelah berkas template `test/widget_test.dart` dihapus | Lulus |
| TC-12 | Analisis statis | Dependency terpasang | `flutter analyze` | Tidak ada error baru | `flutter analyze`: `No issues found!` setelah `flutter_lints` dipasang dan berkas template dihapus | Lulus |

Kembalikan `FotoService.simulasi` ke `SimulasiFoto.tidakAda` setelah TC-09.

## Cakupan

| Jenis kondisi | Test case |
|:--------------|:----------|
| Fitur berhasil | TC-01, TC-06 |
| Input tidak valid | TC-02, TC-03, TC-04, TC-05, TC-10 |
| Kondisi kosong | TC-07 |
| Kondisi error | TC-09 |
| Pembatalan | TC-08 |
