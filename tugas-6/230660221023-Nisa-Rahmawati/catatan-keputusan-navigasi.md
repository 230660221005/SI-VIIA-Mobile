# Catatan Keputusan Navigasi

| Keputusan | Alasan | Penerapan |
|---|---|---|
| Menggunakan named routes | Nama rute memudahkan pengelolaan perpindahan halaman. | `/`, `/detail`, dan `/pinjam` didefinisikan dalam `MaterialApp`. |
| Menggunakan katalog sebagai halaman awal | Pengguna perlu memilih buku sebelum melihat detail. | `initialRoute` diatur ke `/`. |
| Mengirim data buku melalui arguments | Halaman detail membutuhkan informasi buku yang dipilih. | Objek buku dikirim menggunakan `Navigator.pushNamed`. |
| Memeriksa tipe data arguments | Menghindari penggunaan data yang tidak sesuai tipe yang diharapkan. | Halaman detail memeriksa tipe objek dan menyediakan penanganan jika data tidak tersedia. |
| Menggunakan tombol kembali dan `Navigator.pop` | Memudahkan pengguna kembali ke halaman sebelumnya. | Halaman detail dan formulir menyediakan navigasi kembali. |
| Menggunakan validasi formulir | Mencegah pengajuan dengan data kosong atau tidak sesuai. | `GlobalKey<FormState>` dan validator diterapkan pada setiap kolom. |
| Menampilkan SnackBar | Memberikan informasi hasil tindakan kepada pengguna. | Notifikasi ditampilkan setelah validasi atau pengajuan peminjaman. |
| Mengelola controller | Menghindari controller tetap aktif setelah widget tidak digunakan. | Setiap `TextEditingController` dibersihkan melalui `dispose()`. |