# Jawaban Quiz Pertemuan 10 — Integrasi Data dan Proses Bisnis Sistem Informasi

**Mata Kuliah:** Pemrograman Aplikasi Bergerak  
**Pertemuan:** 10  
**CPMK:** CPMK-3

**Nama:** Dede Dian Permana  
**NIM:** 230660221010  
**Kelas:** SI-VIIA

## Soal 1 — Integrasi Data

Integrasi data pada aplikasi mobile merupakan proses menggabungkan data dari beberapa sumber atau endpoint agar dapat digunakan secara bersamaan dalam aplikasi. Integrasi ini bertujuan menghasilkan informasi yang saling berhubungan dan memudahkan pengguna dalam memperoleh informasi.

Contohnya pada aplikasi SiRuang Kampus, aplikasi mengambil data pengguna dari endpoint `/users` dan data pengajuan dari endpoint `/posts`. Kedua data tersebut kemudian digabungkan agar setiap pengajuan dapat menampilkan nama pengguna yang mengajukannya.

Identifier yang digunakan untuk menghubungkan kedua data tersebut adalah `userId` pada data pengajuan yang dicocokkan dengan `id` pada data pengguna.

## Soal 2 — Future.wait

`Future.wait` digunakan ketika aplikasi perlu menjalankan beberapa proses asynchronous secara bersamaan dan proses tersebut tidak saling bergantung satu sama lain.

Pada aplikasi SiRuang Kampus, `Future.wait` digunakan untuk mengambil data pengguna dan data pengajuan secara bersamaan karena kedua endpoint dapat diakses secara independen. Setelah keduanya selesai diambil, data kemudian digabungkan berdasarkan `userId`.

Request harus dijalankan secara berurutan apabila request berikutnya membutuhkan hasil dari request sebelumnya. Contohnya, aplikasi harus mengambil ID pengguna terlebih dahulu sebelum menggunakan ID tersebut untuk meminta data pengajuan khusus milik pengguna tersebut.

## Soal 3 — Model dan fromJson

Model `DataPengajuan` membutuhkan beberapa field, yaitu:

- `id`: identitas unik pengajuan.
- `userId`: identitas pengguna yang membuat pengajuan.
- `namaPengguna`: nama pengguna yang mengajukan.
- `judul`: judul pengajuan.
- `deskripsi`: keterangan atau isi pengajuan.

Field yang paling penting untuk menghubungkan data pengguna dan pengajuan adalah `userId`.

Method `fromJson` digunakan untuk mengubah data JSON dari API menjadi objek Dart. Apabila terdapat field yang tidak tersedia atau bernilai null, aplikasi dapat memberikan nilai default menggunakan operator `??`.

Contohnya, `json['title'] ?? 'Pengajuan tanpa judul'` akan memberikan judul pengganti apabila field `title` tidak tersedia. Dengan demikian, proses pengolahan data dapat lebih aman dan mengurangi risiko kesalahan akibat nilai kosong.

## Soal 4 — Service Layer

Service layer bertanggung jawab menangani proses komunikasi dengan API, seperti mengirim HTTP request, menerima response, memeriksa status HTTP, mengubah JSON menjadi model Dart, serta menggabungkan data dari beberapa endpoint.

Sementara itu, widget bertanggung jawab mengatur tampilan aplikasi, seperti menampilkan daftar pengajuan, indikator loading, pesan error, dan tombol untuk mencoba kembali.

Pada aplikasi SiRuang Kampus, proses pengambilan dan penggabungan data ditempatkan pada `IntegrasiService`, sedangkan `main.dart` digunakan untuk menampilkan hasil integrasi kepada pengguna.

Penggabungan data sebaiknya tidak ditulis langsung di dalam widget karena dapat membuat kode menjadi sulit dibaca, sulit dipelihara, dan sulit digunakan kembali. Pemisahan tersebut membuat struktur program lebih terorganisasi.

## Soal 5 — Status Halaman

Halaman integrasi data perlu menangani beberapa state, yaitu:

1. **Loading:** Kondisi ketika aplikasi sedang mengambil data dari API.
2. **Success:** Kondisi ketika data berhasil diterima dan ditampilkan.
3. **Empty:** Kondisi ketika request berhasil, tetapi tidak terdapat data yang dapat ditampilkan.
4. **Error:** Kondisi ketika proses pengambilan atau pengolahan data mengalami kegagalan.
5. **Retry:** Fitur untuk mengulangi proses pengambilan data setelah terjadi kesalahan.

Kondisi data kosong perlu dibedakan dari kondisi error karena keduanya memiliki arti yang berbeda. Data kosong menunjukkan bahwa komunikasi dengan API berhasil, tetapi tidak ada data yang tersedia. Sementara itu, error menunjukkan bahwa proses komunikasi atau pengolahan data mengalami masalah.

Dengan membedakan kedua kondisi tersebut, aplikasi dapat memberikan informasi yang lebih tepat kepada pengguna. Misalnya, ketika data kosong aplikasi menampilkan pesan bahwa belum ada pengajuan, sedangkan ketika terjadi error aplikasi menampilkan pesan kegagalan dan tombol untuk mencoba kembali.