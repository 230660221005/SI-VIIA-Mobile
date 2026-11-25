# Jawaban Quiz Pertemuan 11
## Integrasi Fitur Perangkat

**Nama:** Clara Desmiati  
**NIM:** 230660221005  
**Kelas:** SI-VIIA  
**Mata Kuliah:** Pemrograman Aplikasi Bergerak  
**Nama Aplikasi:** SIAngkut

### 1. Bagaimana menentukan fitur perangkat yang sesuai dengan kebutuhan aplikasi?

Fitur perangkat ditentukan berdasarkan kebutuhan pengguna dan proses bisnis yang dijalankan aplikasi. Sebelum memilih fitur, pengembang perlu memahami masalah yang ingin diselesaikan serta manfaat fitur tersebut bagi pengguna.

Pada aplikasi SIAngkut, fitur pemilihan foto dari galeri dipilih karena warga membutuhkan bukti visual ketika melaporkan permasalahan pengangkutan sampah, seperti sampah belum diangkut atau penumpukan sampah. Foto tersebut membantu petugas memperoleh gambaran kondisi yang dilaporkan sehingga informasi menjadi lebih lengkap.

### 2. Mengapa aplikasi harus memperhatikan permission ketika mengakses fitur perangkat?

Permission diperlukan untuk menjaga privasi dan memberikan kendali kepada pengguna terhadap akses aplikasi ke fitur atau data perangkat.

Pada SIAngkut, akses foto harus mengikuti mekanisme yang berlaku pada platform. Jika akses ditolak, aplikasi tidak boleh memaksakan proses pemilihan foto. Aplikasi perlu menampilkan informasi yang mudah dipahami dan tetap memungkinkan pengguna menggunakan bagian aplikasi lainnya yang tidak membutuhkan akses tersebut.

### 3. Apa arti nilai `null` ketika menggunakan package `image_picker`?

Nilai `null` menunjukkan bahwa proses pemilihan foto tidak menghasilkan file pilihan, misalnya karena pengguna membatalkan pemilihan.

Kondisi tersebut berbeda dengan error karena pembatalan merupakan tindakan pengguna yang normal. Pada aplikasi SIAngkut, ketika hasil pemilihan bernilai `null`, aplikasi mempertahankan foto sebelumnya jika sudah ada dan tidak menganggap pembatalan sebagai kegagalan sistem.

### 4. Mengapa proses akses fitur perangkat sebaiknya ditempatkan dalam service?

Pemisahan service dan widget bertujuan agar kode memiliki tanggung jawab yang jelas dan lebih mudah dikelola.

Pada aplikasi SIAngkut, `FotoService` ditempatkan pada file `lib/services/foto_service.dart` untuk menangani proses pemilihan foto menggunakan `image_picker`. Sementara itu, widget `FormLaporan` pada `main.dart` bertanggung jawab mengatur tampilan, indikator loading, pratinjau foto, dan informasi kepada pengguna.

Dengan pemisahan tersebut, kode akses perangkat tidak bercampur dengan kode tampilan sehingga lebih mudah diperiksa, diperbaiki, dan dikembangkan.

### 5. Bagaimana aplikasi menangani berbagai kondisi ketika menggunakan fitur perangkat?

Aplikasi perlu menangani setiap kondisi agar pengguna mendapatkan respons yang sesuai. Beberapa kondisi yang perlu diperhatikan adalah:

- **Kondisi awal:** Pengguna belum memilih foto.
- **Loading:** Aplikasi sedang membuka pemilih foto dan menunggu hasilnya.
- **Berhasil:** Foto berhasil dipilih dan ditampilkan sebagai pratinjau.
- **Dibatalkan:** Pengguna membatalkan pemilihan sehingga aplikasi mempertahankan foto sebelumnya.
- **Permission ditolak:** Aplikasi memberikan informasi bahwa akses foto tidak dapat dilakukan.
- **Error:** Aplikasi menampilkan pesan kesalahan jika terjadi masalah pada plugin atau perangkat.

Pada SIAngkut, penanganan kondisi tersebut dilakukan agar proses pemilihan foto lebih informatif dan aplikasi tidak langsung berhenti ketika terjadi pembatalan atau kesalahan.