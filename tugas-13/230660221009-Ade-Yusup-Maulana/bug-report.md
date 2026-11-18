\# BUG REPORT TUGAS 13

\## Laporan Pengujian dan Perbaikan Bug



\*\*Nama:\*\* Ade Yusup Maulana  

\*\*NIM:\*\* 230660221009  

\*\*Kelas:\*\* SI-VIIA  

\*\*Mata Kuliah:\*\* Pemrograman Aplikasi Bergerak



\### BUG-01: Pratinjau Foto Lama Tidak Terhapus



\*\*1. Deskripsi Bug\*\*



Ketika pengguna sudah memilih foto yang valid, kemudian memilih foto baru dengan format yang tidak didukung, aplikasi menampilkan pesan kesalahan tetapi foto sebelumnya masih terlihat pada pratinjau dan nama file.



\*\*2. Kondisi Awal\*\*



\- Aplikasi sudah dibuka.

\- Pengguna berhasil memilih foto JPG atau PNG yang valid.

\- Foto berhasil ditampilkan pada pratinjau.



\*\*3. Langkah Reproduksi\*\*



1\. Buka aplikasi.

2\. Pilih foto PNG yang valid.

3\. Pastikan foto berhasil ditampilkan.

4\. Pilih kembali foto dari galeri.

5\. Pilih file dengan format TXT.

6\. Periksa pesan validasi dan pratinjau foto.



\*\*4. Hasil yang Diharapkan\*\*



Aplikasi menolak file dengan format tidak didukung, menghapus foto sebelumnya dari pratinjau, dan menampilkan pesan kesalahan.



\*\*5. Hasil Aktual Sebelum Perbaikan\*\*



Aplikasi menampilkan pesan kesalahan format, tetapi nama file dan pratinjau foto sebelumnya masih ditampilkan.



\*\*6. Penyebab Bug\*\*



Pada kode sebelumnya, ketika validasi format, ukuran, data, atau isi file gagal, aplikasi hanya memperbarui pesan kesalahan. Variabel `\_foto` dan `\_dataFoto` tidak dikosongkan.



\*\*7. Perbaikan\*\*



Menambahkan fungsi `\_hapusFotoLama()` untuk menghapus data foto sebelumnya ketika foto baru gagal melewati validasi.



Fungsi tersebut mengosongkan:

\- `\_foto`

\- `\_dataFoto`



Kemudian memperbarui pesan kesalahan sesuai hasil validasi.



\*\*8. Pengujian Setelah Perbaikan\*\*



File pengujian: `test/bug\_pratinjau\_test.dart`



Hasil pengujian:



\- Foto valid berhasil diproses.

\- Foto dengan format TXT ditolak.

\- Nama foto lama tidak lagi ditampilkan.

\- Pengujian otomatis berhasil.



\*\*Status:\*\* BERHASIL DIPERBAIKI



\*\*9. Regression Testing\*\*



Pengujian dilakukan kembali untuk memastikan fitur pemilihan foto dan validasi tetap berjalan setelah perbaikan.



Perintah pengujian:



```bash

flutter test test/bug\_pratinjau\_test.dart

```



Hasil:



```text

00:02 +1: All tests passed!

```



\### Kesimpulan



Bug pratinjau foto lama berhasil ditemukan, direproduksi, diperbaiki, dan diuji kembali menggunakan pengujian widget Flutter.

