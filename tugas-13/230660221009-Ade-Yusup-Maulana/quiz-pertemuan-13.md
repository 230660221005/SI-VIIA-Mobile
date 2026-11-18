# Quiz Pertemuan 13: Testing, Debugging, dan Perbaikan

**Mata Kuliah:** Pemrograman Aplikasi Bergerak  
**Pertemuan:** 13  
**CPMK:** CPMK-4  
**Nama:** Ade Yusup Maulana  
**NIM:** 230660221009

## Soal 1. Test Case

Test case merupakan dokumen yang berisi langkah-langkah pengujian untuk memastikan suatu fitur berjalan sesuai kebutuhan.

Komponen utama test case meliputi:

1. **Test Case ID:** Identitas atau kode pengujian.
2. **Skenario Pengujian:** Fitur yang akan diuji.
3. **Kondisi Awal:** Keadaan aplikasi sebelum pengujian.
4. **Langkah Pengujian:** Tahapan yang dilakukan penguji.
5. **Expected Result:** Hasil yang diharapkan.
6. **Actual Result:** Hasil yang benar-benar terjadi.
7. **Status:** Keterangan apakah pengujian berhasil atau gagal.

Perbedaan expected result dan actual result adalah expected result merupakan hasil yang seharusnya terjadi berdasarkan kebutuhan sistem, sedangkan actual result merupakan hasil nyata setelah pengujian dilakukan.

## Soal 2. Jenis Testing

Berikut perbedaan beberapa jenis pengujian aplikasi Flutter:

1. **Static Analysis:** Pemeriksaan kode tanpa menjalankan aplikasi. Contohnya menggunakan perintah `flutter analyze` untuk menemukan kesalahan dan masalah penulisan kode.
2. **Unit Test:** Pengujian bagian kecil dari program secara terpisah, seperti fungsi validasi format dan ukuran foto.
3. **Widget Test:** Pengujian komponen antarmuka Flutter, seperti tombol, teks, dan tampilan halaman.
4. **Integration Test:** Pengujian beberapa bagian sistem secara bersamaan untuk memastikan fitur saling terhubung dengan benar.
5. **Manual Functional Test:** Pengujian yang dilakukan secara langsung oleh pengguna atau penguji dengan mencoba fitur aplikasi dan membandingkan hasilnya dengan kebutuhan.

## Soal 3. Widget Test

Beberapa fungsi utama dalam widget test Flutter adalah:

1. `pumpWidget`: Menampilkan widget yang akan diuji ke dalam lingkungan pengujian.
2. `find`: Mencari widget tertentu berdasarkan teks, tipe, atau karakteristik lainnya.
3. `tap`: Melakukan simulasi tindakan menekan tombol atau widget.
4. `pump`: Memperbarui tampilan setelah terjadi perubahan pada widget.
5. `expect`: Memeriksa apakah hasil pengujian sesuai dengan kondisi yang diharapkan.

Contohnya, pada aplikasi bukti foto, widget test dapat digunakan untuk memastikan tombol Pilih dari Galeri tampil dan pesan awal aplikasi muncul.

## Soal 4. Debugging

Jika tombol simpan menghasilkan dua data ketika ditekan dua kali, langkah debugging yang dapat dilakukan adalah:

1. Mengulangi masalah dengan menekan tombol simpan dua kali.
2. Mengamati hasil penyimpanan dan mencatat apakah terdapat data ganda.
3. Memeriksa fungsi tombol simpan dan proses pengiriman data.
4. Memeriksa apakah tombol masih dapat ditekan ketika proses penyimpanan berlangsung.
5. Memeriksa log aplikasi dan proses penyimpanan untuk menemukan penyebab masalah.
6. Memperbaiki kode, misalnya dengan menonaktifkan tombol selama proses penyimpanan atau menerapkan mekanisme pencegahan duplikasi.
7. Menjalankan pengujian ulang untuk memastikan masalah sudah diperbaiki.

## Soal 5. Regresi

Regression testing adalah pengujian ulang terhadap fitur yang sebelumnya sudah berjalan untuk memastikan perubahan kode atau perbaikan bug tidak menimbulkan masalah baru.

Contohnya, ketika memperbaiki validasi foto pada form pengajuan, pengembang perlu menguji kembali pemilihan foto, validasi format, ukuran file, dan tampilan pratinjau.

Dengan demikian, perbaikan pada satu fitur tidak menyebabkan fitur lainnya mengalami kerusakan.

## Soal 6. Integritas Testing

Menghapus assertion atau mengubah expected result hanya agar test menjadi lulus merupakan praktik yang salah karena dapat menyembunyikan kesalahan sebenarnya pada aplikasi.

Assertion berfungsi memastikan hasil aktual sesuai dengan kebutuhan yang sudah ditentukan. Jika assertion dihapus tanpa alasan teknis yang benar, pengujian tidak lagi dapat memberikan bukti bahwa fitur bekerja sesuai harapan.

Perbaikan yang benar adalah mencari penyebab kegagalan, memperbaiki kode aplikasi, kemudian menjalankan kembali pengujian untuk memastikan hasilnya sesuai dengan kebutuhan.

## Kesimpulan

Dari materi Pertemuan 13, saya memahami bahwa testing, debugging, dan regression testing merupakan bagian penting dalam pengembangan aplikasi Flutter. Pengujian membantu menemukan kesalahan, memastikan fitur berjalan sesuai kebutuhan, dan menjaga kualitas aplikasi setelah dilakukan perbaikan.