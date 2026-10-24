# Tugas 6 — Navigation Flow dan Interaksi

**Nama:** Ade Yusup Maulana  
**NIM:** 230660221009  
**Program Studi:** Sistem Informasi  
**Mata Kuliah:** Pemrograman Aplikasi Bergerak (PAB)

## Judul Aplikasi

**PAB - Penjualan Warung**

## Deskripsi

Tugas ini merupakan implementasi navigation flow dan interaksi pada aplikasi penjualan warung menggunakan Flutter. Aplikasi memiliki halaman daftar produk, detail produk, dan form transaksi dengan named route, arguments, validasi form, serta SnackBar sebagai feedback kepada pengguna.

## Route yang Digunakan

| Route | Halaman | Fungsi |
|---|---|---|
| `/` | Daftar Produk | Menampilkan daftar produk warung |
| `/detail` | Detail Produk | Menampilkan informasi produk yang dipilih |
| `/transaksi` | Halaman Transaksi | Mengisi data pembeli dan jumlah transaksi |

## Alur Aplikasi

Daftar Produk → Detail Produk → Halaman Transaksi → SnackBar → Daftar Produk

Data produk dikirim menggunakan arguments dari halaman daftar ke halaman detail dan diteruskan ke halaman transaksi.

## Validasi Form

Form transaksi memiliki dua input:

1. Nama Pembeli — wajib diisi.
2. Jumlah — wajib diisi dan harus berupa angka lebih dari 0.

Jika data belum sesuai, aplikasi menampilkan pesan validasi pada masing-masing input.

## Feedback

Setelah data transaksi valid dan disimpan, aplikasi menampilkan SnackBar dengan pesan:

**“Transaksi berhasil disimpan”**

Setelah itu pengguna kembali ke halaman Daftar Produk.

## File Tugas

- `navigation-flow.md` — dokumentasi alur navigasi.
- `form-interaksi.dart` — implementasi Flutter.
- `screenshot-alur.png` — screenshot halaman Detail Produk.
- `screenshot-feedback.png` — screenshot SnackBar setelah transaksi berhasil.
- `catatan-keputusan-navigasi.md` — catatan keputusan navigasi, data, validasi, dan feedback.

## Pengujian

Pengujian dilakukan dengan tiga skenario:

1. Memilih produk dari Daftar Produk dan membuka Detail Produk.
2. Mengirim form kosong untuk memastikan validasi berjalan.
3. Mengisi data yang valid untuk memastikan SnackBar muncul dan aplikasi kembali ke Daftar Produk.

## Deklarasi Penggunaan AI

ChatGPT digunakan sebagai bantuan dalam memahami konsep navigasi Flutter, validasi form, penyusunan struktur dokumentasi, dan pengecekan implementasi. Hasil akhir disesuaikan dan digunakan oleh penulis untuk menyelesaikan tugas.

## Refleksi

Pada tugas ini saya memahami cara menggunakan named route untuk mengatur perpindahan antarhalaman pada aplikasi Flutter. Saya juga belajar mengirim data antarhalaman menggunakan arguments serta membuat validasi pada form. Selain itu, saya memahami penggunaan SnackBar sebagai feedback setelah pengguna melakukan suatu tindakan.