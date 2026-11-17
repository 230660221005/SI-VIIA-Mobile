\# DOKUMENTASI VALIDASI INPUT

\## Tugas 12 - Validasi dan Keamanan Praktis



Nama: Ade Yusup Maulana  

NIM: 230660221009  

Program Studi: Sistem Informasi  

Kelas: SI-VIIA  



\## 1. Validasi Foto Wajib



\- Input: Foto yang dipilih pengguna.

\- Aturan: Pengguna wajib memilih foto sebelum diproses.

\- Pemeriksaan: Foto tidak boleh bernilai null.

\- Pesan kesalahan: Foto wajib dipilih.



\## 2. Validasi Format Foto



\- Input: Nama file foto.

\- Aturan: Format yang diperbolehkan adalah JPG, JPEG, dan PNG.

\- Pemeriksaan: Ekstensi nama file harus sesuai format yang diizinkan.

\- Pesan kesalahan: Format foto harus JPG, JPEG, atau PNG.



\## 3. Validasi Ukuran Foto



\- Input: Ukuran file foto.

\- Aturan: Ukuran maksimal adalah 2 MB.

\- Pemeriksaan: Ukuran file diperiksa menggunakan panjang data file.

\- Pesan kesalahan: Ukuran foto maksimal 2 MB.



\## 4. Validasi Data Foto



\- Input: Data foto dalam bentuk bytes.

\- Aturan: Data foto tidak boleh kosong.

\- Pemeriksaan: Memastikan data foto memiliki isi.

\- Pesan kesalahan: Data foto kosong.



\## 5. Validasi Isi File Foto



\- Input: Data biner foto.

\- Aturan: Isi file harus memiliki tanda pengenal JPEG atau PNG.

\- Pemeriksaan: Memeriksa signature awal file.

\- Pesan kesalahan: Isi file bukan gambar JPG/JPEG/PNG yang valid.



\## Pemeriksaan Sisi Server



Aplikasi belum menggunakan server atau API. Oleh karena itu, pemeriksaan sisi server belum diterapkan.



Jika aplikasi dikembangkan menggunakan server, validasi perlu dilakukan kembali di sisi server agar pengguna tidak dapat melewati pemeriksaan yang hanya dilakukan pada aplikasi.



\## Catatan Keamanan



Validasi saat ini dilakukan pada sisi aplikasi menggunakan Flutter. Pemeriksaan signature merupakan pemeriksaan awal dan belum menggantikan proses decoding gambar secara menyeluruh.

