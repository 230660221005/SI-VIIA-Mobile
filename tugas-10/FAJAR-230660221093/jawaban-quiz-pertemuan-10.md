# Jawaban Quiz Pertemuan 10 — Integrasi Data dan Proses Bisnis

Nama: Fajar | NIM: 230660221093 | Kelas: SI-VIIA

Draf jawaban dengan contoh dari project Glazent.pro. Tulis ulang dengan kata-kata Anda sendiri sebelum dikumpulkan.

---

## Soal 1 — Integrasi Data

Integrasi data pada aplikasi mobile adalah menghubungkan beberapa sumber data (biasanya beberapa endpoint) agar aplikasi dapat menampilkan satu proses bisnis secara lengkap, bukan potongan data yang terpisah.

Contoh pada Glazent.pro: daftar pesanan perlu menampilkan layanan yang dipesan (endpoint pesanan), nama dan kota pemesan (endpoint pelanggan), dan status pengerjaan (endpoint progres pekerjaan teknisi). Identifier yang menghubungkannya adalah `userId` pada pesanan yang sama dengan `id` pelanggan, dan `id` pesanan yang sama dengan `id` pada data progres.

## Soal 2 — `Future.wait`

`Future.wait` digunakan ketika beberapa request tidak saling bergantung, yaitu tidak ada request yang membutuhkan hasil request lain sebagai masukan. Ketiganya dijalankan bersamaan sehingga waktu tunggu mengikuti request yang paling lambat, bukan jumlah semuanya. Pada Glazent.pro, data pelanggan, pesanan, dan progres diambil dengan `Future.wait`.

Request harus berurutan bila request kedua membutuhkan identifier dari hasil request pertama. Contohnya, bila detail pelanggan hanya bisa diminta lewat `userId` yang baru diketahui setelah daftar pesanan diterima, pesanan diambil lebih dulu baru pelanggan. Perlu diingat bahwa `Future.wait` ikut gagal bila salah satu request gagal, sehingga errornya harus ditangani.

## Soal 3 — Model dan `fromJson`

Field yang menghubungkan pengguna dan pengajuan pada `DataPengajuan` adalah `userId` (menuju data pengguna) dan `roomId` (menuju data ruang), di samping `id` dan `status`. Pada project Glazent.pro, padanannya adalah `DataPesanan` dengan `id`, `userId`, dan `layanan`.

`fromJson` menangani field yang tidak tersedia dengan membaca nilainya sebagai tipe nullable lalu memberi nilai default, misalnya `json['userId'] as int? ?? 0` dan `json['title'] as String? ?? 'Tanpa Nama Layanan'`. Dengan cara ini aplikasi tidak error ketika response tidak lengkap.

## Soal 4 — Service Layer

Service layer bertanggung jawab atas request HTTP, pemeriksaan status code, `timeout`, parsing JSON menjadi model, penggabungan data, dan aturan proses bisnis. Widget bertanggung jawab atas tampilan dan state halaman.

Penggabungan data sebaiknya tidak ditulis di dalam widget karena:
- method `build` dapat dipanggil berulang, sehingga logika jaringan bisa ikut berulang;
- logika bercampur dengan tampilan sehingga sulit dibaca, diuji, dan diubah;
- aturan seperti status pesanan tersebar di banyak widget, padahal seharusnya hanya berada pada satu tempat;
- halaman lain yang membutuhkan data yang sama harus menulis ulang logikanya.

## Soal 5 — Status Halaman

State yang perlu ditangani: loading (request berjalan), sukses (data tersedia), kosong (request berhasil tetapi tidak ada data), dan error (request gagal, dengan tombol coba lagi).

Kondisi kosong dibedakan dari error karena maknanya berbeda. Kosong berarti proses berhasil dan sistem bekerja normal, tetapi memang belum ada pesanan, sehingga pesan yang tepat adalah "Belum ada pesanan". Error berarti proses gagal, sehingga pengguna perlu tahu penyebabnya dan diberi tombol coba lagi. Bila kosong ditampilkan sebagai error, pengguna menyangka ada kerusakan padahal tidak. Bila error ditampilkan sebagai kosong, kegagalan nyata tersembunyi dan pengguna mengira tidak ada pesanan.
