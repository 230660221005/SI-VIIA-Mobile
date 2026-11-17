# REFLEKSI TUGAS 12
## Validasi dan Keamanan Praktis

Risiko keamanan yang paling penting dalam aplikasi ini adalah pengguna memilih file dengan format yang tidak sesuai, ukuran terlalu besar, atau isi file yang tidak valid.  
Untuk mengurangi risiko tersebut, saya menerapkan lima validasi foto, yaitu pemeriksaan foto wajib dipilih, format file, ukuran maksimal 2 MB, data kosong, dan signature awal file.  
Perbaikan berikutnya adalah menambahkan validasi gambar yang lebih menyeluruh, melakukan pengujian izin kamera dan galeri pada perangkat Android, serta menerapkan validasi sisi server apabila aplikasi sudah terhubung dengan API.