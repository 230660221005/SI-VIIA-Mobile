# Catatan Keputusan Navigasi – PAB Penjualan Warung

| Route | Data yang Dibawa | Validasi | Feedback | Alasan |
|---|---|---|---|---|
| `/` | Tidak ada | Tidak ada | Menampilkan daftar produk | Dijadikan halaman awal karena pengguna perlu melihat produk terlebih dahulu. |
| `/detail` | Data `Produk` dari halaman daftar | Data dicek dengan `args is Produk` | Menampilkan detail produk | Data produk dikirim agar halaman detail menampilkan informasi sesuai produk yang dipilih. |
| `/transaksi` | Data `Produk` dari halaman detail | Nama pembeli wajib diisi dan jumlah harus lebih dari 0 | SnackBar “Transaksi berhasil disimpan” | Form digunakan untuk memasukkan data transaksi sebelum disimpan. |

## Keputusan Navigasi

Navigasi menggunakan named route agar perpindahan antarhalaman lebih terstruktur dan mudah dipahami.

Data produk dikirim dari halaman daftar ke halaman detail menggunakan arguments. Data yang sama kemudian diteruskan ke halaman transaksi agar produk yang dipilih tetap ditampilkan.

Pada form transaksi digunakan validasi untuk memastikan nama pembeli tidak kosong dan jumlah transaksi berupa angka lebih dari 0. Setelah data valid, aplikasi menampilkan SnackBar sebagai informasi bahwa transaksi berhasil disimpan dan kemudian kembali ke halaman daftar produk.

## Alur Kembali

- Detail Produk → kembali ke Daftar Produk.
- Halaman Transaksi → setelah transaksi berhasil, kembali ke Daftar Produk.
- Tombol Back tetap dapat digunakan untuk kembali ke halaman sebelumnya.