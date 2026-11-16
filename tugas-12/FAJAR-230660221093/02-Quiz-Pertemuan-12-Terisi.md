# Quiz Pertemuan 12 — Validasi dan Keamanan Praktis

**Mata Kuliah:** Pemrograman Aplikasi Bergerak  
**Pertemuan:** 12 | **CPMK:** CPMK-4

## Petunjuk

- Waktu: 20 menit.
- Jawab seluruh 5 soal.
- Jelaskan alasan teknis, bukan hanya menyebut istilah.
- Jangan memasukkan token, password, atau data nyata dalam jawaban.

## Soal 1 — Validasi Client dan Server

Jelaskan perbedaan validasi client dan server. Mengapa validasi pada form Flutter tidak cukup untuk melindungi aturan bisnis?

**Jawaban:**

Validasi client adalah pemeriksaan data yang dilakukan pada perangkat pengguna sebelum data dikirim ke server. Pada aplikasi Flutter, contohnya memeriksa apakah kolom wajib sudah diisi, format email benar, atau panjang password memenuhi ketentuan. Validasi ini membantu memberikan umpan balik dengan cepat dan mengurangi kesalahan input.

Validasi server adalah pemeriksaan yang dilakukan oleh backend setelah menerima permintaan dari aplikasi. Server memeriksa kembali format, kelengkapan, hak akses pengguna, serta aturan bisnis sebelum memproses atau menyimpan data.

Validasi pada form Flutter saja tidak cukup karena aplikasi client dapat dimodifikasi, permintaan API dapat dikirim tanpa melalui tampilan aplikasi, dan data yang dikirim dapat dimanipulasi. Karena itu, aturan penting—misalnya hak pengguna mengubah data, jumlah stok tidak boleh negatif, atau transaksi tidak boleh melebihi batas—harus diperiksa di server. Validasi client digunakan untuk kenyamanan pengguna, sedangkan validasi server menjadi pemeriksaan yang menentukan apakah data boleh diproses.

## Soal 2 — HTTPS dan Token

Sebuah aplikasi mengirim token melalui endpoint `http://api.example.com`. Jelaskan risiko yang mungkin terjadi dan perbaikan yang harus dilakukan.

**Jawaban:**

Pengiriman token melalui HTTP tidak terenkripsi. Jika pengguna terhubung ke jaringan publik atau jaringan yang telah disusupi, pihak lain berpotensi menyadap komunikasi dan memperoleh token. Token yang dicuri dapat digunakan untuk menyamar sebagai pengguna selama token tersebut masih berlaku. Komunikasi juga berisiko dimanipulasi oleh pihak di tengah koneksi (*man-in-the-middle*).

Perbaikannya adalah:

1. Menggunakan endpoint HTTPS agar komunikasi antara aplikasi dan server dienkripsi menggunakan TLS.
2. Memastikan sertifikat TLS server valid dan tidak menonaktifkan pemeriksaan sertifikat.
3. Tidak mengirim token melalui URL atau parameter query; kirim token melalui header otorisasi, misalnya `Authorization: Bearer <token>`.
4. Mengatur masa berlaku token dan mekanisme pencabutan atau pembaruan token sesuai kebutuhan.
5. Menghindari pencatatan token ke log aplikasi maupun server.

Dengan HTTPS, token lebih terlindungi saat dikirim melalui jaringan, meskipun penyimpanan token dan pengelolaan akses tetap harus diamankan.

## Soal 3 — Secure Storage

Mengapa token sebaiknya disimpan menggunakan penyimpanan aman platform, bukan ditulis pada source code atau log? Jelaskan juga tindakan saat pengguna logout.

**Jawaban:**

Token merupakan kredensial yang dapat digunakan untuk mengakses akun atau layanan pengguna. Jika token ditulis langsung pada source code, token berisiko terbaca ketika kode dibagikan, diunggah ke repositori, atau aplikasi dibongkar. Jika token dimasukkan ke log, token dapat ikut tersimpan dalam catatan debug dan terekspos kepada pihak yang tidak berwenang.

Karena itu, token sebaiknya disimpan menggunakan penyimpanan aman yang memanfaatkan mekanisme keamanan platform, seperti Keychain pada iOS atau Keystore pada Android melalui plugin secure storage Flutter. Penyimpanan ini memberikan perlindungan yang lebih baik dibandingkan menyimpan token sebagai teks biasa pada source code atau penyimpanan umum.

Saat pengguna logout, aplikasi sebaiknya:

1. Mengirim permintaan logout ke server jika tersedia mekanisme untuk mencabut atau mengakhiri sesi/token.
2. Menghapus access token, refresh token, dan data autentikasi lain dari secure storage.
3. Menghapus data sesi pengguna dari memori aplikasi atau state manajemen aplikasi.
4. Mengarahkan pengguna kembali ke halaman login.
5. Memastikan halaman atau fitur yang memerlukan autentikasi tidak lagi dapat diakses tanpa login kembali.

Penghapusan token di perangkat mencegah aplikasi menggunakan kembali kredensial lokal, sedangkan pencabutan token di server membantu mencegah token yang sudah dicuri tetap digunakan.

## Soal 4 — Permission

Aplikasi meminta permission kamera saat pertama kali dibuka, padahal fitur foto hanya digunakan pada form tertentu. Analisis masalah tersebut dan usulkan alur permission yang lebih tepat.

**Jawaban:**

Meminta permission kamera saat aplikasi pertama kali dibuka kurang tepat karena pengguna belum tentu memahami alasan aplikasi membutuhkan akses kamera. Permintaan yang terlalu awal dapat mengurangi kepercayaan pengguna dan membuat pengguna menolak permission, padahal fitur lain tetap dapat digunakan tanpa kamera. Prinsip yang lebih baik adalah meminta izin sesuai konteks ketika fitur yang membutuhkan izin akan digunakan.

Alur yang lebih tepat adalah:

1. Pengguna membuka form yang memiliki fitur pengambilan foto.
2. Aplikasi menjelaskan secara singkat tujuan penggunaan kamera, misalnya untuk mengambil foto bukti atau dokumentasi.
3. Ketika pengguna memilih tombol ambil foto, aplikasi memeriksa status permission kamera.
4. Jika izin belum diberikan, aplikasi menampilkan permintaan permission melalui mekanisme resmi sistem operasi.
5. Jika izin diberikan, aplikasi membuka kamera dan melanjutkan proses pengambilan foto.
6. Jika izin ditolak, aplikasi menampilkan penjelasan dan menyediakan alternatif, misalnya memilih gambar dari galeri jika sesuai kebutuhan.
7. Jika izin ditolak secara permanen, aplikasi dapat mengarahkan pengguna ke pengaturan perangkat untuk mengaktifkannya kembali.

Dengan alur ini, permission diminta hanya ketika diperlukan, tujuan akses lebih mudah dipahami, dan pengguna tetap memiliki kendali atas privasinya.

## Soal 5 — Security Checklist

Tuliskan lima pemeriksaan keamanan untuk project mobile dan satu bukti yang dapat digunakan untuk setiap pemeriksaan.

**Jawaban:**

| No. | Pemeriksaan Keamanan | Bukti yang Dapat Digunakan |
|---|---|---|
| 1 | Memastikan seluruh komunikasi aplikasi dengan API menggunakan HTTPS dan sertifikat TLS yang valid. | Konfigurasi base URL HTTPS dan hasil pemeriksaan koneksi/sertifikat. |
| 2 | Memastikan input divalidasi di sisi client dan server, termasuk pemeriksaan aturan bisnis. | Kode validasi Flutter, kode validasi backend, serta hasil pengujian input tidak valid. |
| 3 | Memastikan token autentikasi disimpan di secure storage dan tidak ditulis pada source code atau log. | Kode penggunaan secure storage dan pemeriksaan log yang tidak menampilkan token. |
| 4 | Memastikan permission perangkat diminta sesuai kebutuhan fitur dan penolakan izin ditangani dengan baik. | Kode pemeriksaan/request permission serta tangkapan layar alur izin kamera. |
| 5 | Memastikan endpoint API memeriksa autentikasi dan otorisasi sebelum mengakses atau mengubah data. | Kode middleware autentikasi/otorisasi dan hasil pengujian akses tanpa token atau dengan hak akses yang tidak sesuai. |

Kelima pemeriksaan tersebut dapat digunakan sebagai checklist dasar sebelum aplikasi mobile dirilis. Setiap pemeriksaan perlu disertai bukti berupa kode, konfigurasi, tangkapan layar, atau hasil pengujian agar penerapannya dapat diverifikasi.
