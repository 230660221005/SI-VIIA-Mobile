# TEST CASE TUGAS 13

## Pengujian Aplikasi Validasi Foto

**Nama:** Ade Yusup Maulana  
**NIM:** 230660221009  
**Kelas:** SI-VIIA  
**Mata Kuliah:** Pemrograman Aplikasi Bergerak

## A. Unit Testing Validasi Foto

| ID | Skenario Pengujian | Kondisi Awal | Langkah Pengujian | Expected Result | Actual Result | Status |
|---|---|---|---|---|---|---|
| TC-01 | Validasi foto wajib dipilih | Foto belum dipilih | Jalankan unit test dengan nilai null | Sistem menolak karena foto wajib dipilih | Pesan Foto wajib dipilih muncul | Lulus |
| TC-02 | Menolak format PDF | File PDF tersedia | Jalankan unit test format PDF | Sistem menolak format PDF | Pesan format tidak didukung muncul | Lulus |
| TC-03 | Menerima ukuran foto di bawah 2 MB | Data foto 1 KB tersedia | Jalankan unit test ukuran foto | Foto diterima dari sisi validasi ukuran | Hasil validasi null | Lulus |
| TC-04 | Menolak ukuran foto lebih dari 2 MB | Data foto lebih dari 2 MB tersedia | Jalankan unit test ukuran foto | Sistem menolak foto | Pesan ukuran maksimal 2 MB muncul | Lulus |
| TC-05 | Menolak data foto kosong | Data foto kosong tersedia | Jalankan unit test data foto | Sistem menolak data kosong | Pesan data foto kosong muncul | Lulus |
| TC-06 | Menolak isi file bukan gambar | Data file tidak valid tersedia | Jalankan unit test isi file | Sistem menolak isi file | Pesan isi file tidak valid muncul | Lulus |
| TC-07 | Menerima tanda pengenal JPEG | Data tanda pengenal JPEG tersedia | Jalankan unit test JPEG | Tanda pengenal JPEG diterima | Hasil validasi null | Lulus |
| TC-08 | Menerima tanda pengenal PNG | Data tanda pengenal PNG tersedia | Jalankan unit test PNG | Tanda pengenal PNG diterima | Hasil validasi null | Lulus |

## B. Widget Testing

| ID | Skenario Pengujian | Expected Result | Actual Result | Status |
|---|---|---|---|---|
| TC-09 | Menampilkan aplikasi | Halaman utama berhasil ditampilkan | Widget test berhasil | Lulus |
| TC-10 | Menampilkan judul halaman | Judul Bukti Foto terlihat | Widget test berhasil menemukan judul | Lulus |
| TC-11 | Menampilkan tombol kamera dan galeri | Kedua tombol tersedia | Widget test berhasil menemukan kedua tombol | Lulus |
| TC-12 | Menampilkan pesan awal | Pesan awal aplikasi terlihat | Widget test berhasil menemukan pesan awal | Lulus |

## C. Regression Testing

| ID | Skenario Pengujian | Expected Result | Actual Result | Status |
|---|---|---|---|---|
| TC-13 | Menghapus pratinjau foto lama setelah memilih foto tidak valid | Foto lama tidak lagi ditampilkan dan pesan kesalahan muncul | Regression test berhasil memastikan nama file foto lama tidak ditemukan | Lulus |

## D. Pengujian Manual yang Belum Dilakukan

| ID | Skenario Pengujian | Hasil yang Diharapkan | Status |
|---|---|---|---|
| TC-14 | Memilih foto JPG melalui galeri | Foto berhasil dipilih jika memenuhi validasi | Belum diuji |
| TC-15 | Membatalkan pemilihan foto | Aplikasi tetap dapat digunakan | Belum diuji |

## E. Kesimpulan

Berdasarkan pengujian otomatis, terdapat 13 pengujian yang berhasil dijalankan, terdiri dari 8 unit test, 4 widget test, dan 1 regression test.

Seluruh 13 pengujian otomatis berhasil dengan hasil All tests passed.

Pengujian manual untuk pemilihan foto JPG melalui galeri dan pembatalan pemilihan foto masih perlu dilakukan pada perangkat yang mendukung fitur tersebut.

Dokumentasi ini membedakan hasil pengujian otomatis dan pengujian manual agar hasil pengujian tetap sesuai dengan kondisi sebenarnya.