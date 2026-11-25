# Refleksi Tugas 11 – Integrasi Fitur Perangkat

## Identitas Mahasiswa

- **Nama:** Clara Desmiati
- **NIM:** 230660221005
- **Kelas:** SI-VIIA
- **Mata Kuliah:** Pemrograman Aplikasi Bergerak
- **Nama Aplikasi:** SIAngkut

## 1. Pengalaman Pengerjaan

Pada Tugas 11 ini saya menerapkan integrasi fitur perangkat berupa pemilihan foto dari galeri menggunakan package `image_picker` pada aplikasi SIAngkut. Fitur ini ditambahkan pada halaman laporan pengangkutan sampah agar warga dapat menyertakan foto sebagai bukti ketika melaporkan permasalahan, seperti sampah yang belum diangkut atau penumpukan sampah.

Dalam proses pengerjaan, saya menyesuaikan halaman form laporan dengan menambahkan tombol untuk memilih foto, menampilkan pratinjau gambar, serta memberikan informasi kepada pengguna setelah proses pemilihan dilakukan.

## 2. Hal yang Dipelajari

Dari pengerjaan tugas ini, saya memahami bahwa integrasi fitur perangkat tidak hanya dilakukan dengan memasang package dan memanggil fungsinya. Ada beberapa hal yang perlu diperhatikan, yaitu:

1. **Asynchronous:** Proses pemilihan foto membutuhkan waktu sehingga perlu menggunakan `async` dan `await`.
2. **Pemisahan service:** Proses pemilihan foto ditempatkan pada `FotoService`, sedangkan `main.dart` mengatur tampilan dan interaksi pengguna.
3. **Permission:** Aplikasi perlu memperhatikan izin akses yang dibutuhkan oleh platform.
4. **Pembatalan:** Jika pengguna membatalkan pemilihan foto, hasilnya berupa `null` dan tidak boleh dianggap sebagai kesalahan.
5. **Penanganan error:** Aplikasi perlu memberikan pesan yang jelas apabila terjadi masalah saat mengakses fitur perangkat.

## 3. Kendala dan Cara Mengatasinya

Kendala yang saya pelajari selama pengerjaan adalah perbedaan cara kerja fitur pemilihan file pada browser dan perangkat Android atau iOS. Pada Chrome, pemilihan gambar dilakukan melalui file picker browser, sedangkan pada perangkat native proses akses galeri dan permission mengikuti sistem operasi.

Selain itu, saya perlu memperhatikan pemisahan antara kode tampilan dan kode layanan agar implementasi lebih mudah dipahami dan dikelola. Hal tersebut diterapkan dengan membuat `FotoService` sebagai tempat untuk menjalankan proses pemilihan foto.

Untuk memeriksa kesalahan pada kode, saya menggunakan perintah `flutter analyze`. Hasil pemeriksaan menunjukkan tidak ditemukan masalah pada kode yang dianalisis.

## 4. Hasil yang Diperoleh

Hasil pengerjaan tugas ini adalah penambahan fitur pemilihan foto dari galeri pada halaman laporan SIAngkut. Pengguna dapat memilih foto dan melihat pratinjaunya sebelum melanjutkan proses pengisian laporan.

Aplikasi juga disiapkan untuk menangani kondisi pembatalan pemilihan, penolakan izin, dan kesalahan ketika proses pemilihan foto berlangsung. Pengujian setiap kondisi dicatat dalam dokumen `skenario-pengujian.md`, sesuai dengan kondisi yang benar-benar sudah diuji.

## 5. Kesimpulan dan Pembelajaran

Melalui tugas ini saya mendapatkan pemahaman yang lebih baik mengenai cara mengintegrasikan fitur perangkat ke dalam aplikasi Flutter. Saya juga belajar bahwa sebuah fitur tidak cukup hanya dapat dijalankan, tetapi perlu memperhatikan pengalaman pengguna, kondisi gagal, pembatalan, dan perbedaan platform.

Penerapan fitur pemilihan foto pada SIAngkut diharapkan dapat membantu warga memberikan laporan pengangkutan sampah dengan informasi yang lebih jelas melalui bukti visual.

## 6. Pernyataan Penggunaan AI

## 6. Pernyataan Penggunaan AI

Dalam pengerjaan Tugas 11 ini menggunakan **ChatGPT dari OpenAI** sebagai alat bantu untuk memahami materi integrasi fitur perangkat, memperoleh arahan dalam implementasi kode Flutter, membantu menemukan dan memperbaiki kesalahan kode, serta menyusun dokumentasi tugas seperti README dan refleksi. Seluruh hasil bantuan AI disesuaikan kembali dengan kebutuhan aplikasi SIAngkut. Saya tetap bertanggung jawab untuk memahami, memeriksa, dan menguji hasil implementasi yang digunakan.