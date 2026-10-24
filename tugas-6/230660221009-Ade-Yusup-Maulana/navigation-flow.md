\# Navigation Flow – PAB Penjualan Warung



\## 1. Daftar Route



| Route | Halaman | Fungsi |

|---|---|---|

| `/` | Daftar Produk | Menampilkan daftar produk warung dan memilih produk |

| `/transaksi` | Halaman Transaksi | Mengisi data transaksi penjualan |

| `/detail` | Detail Produk | Menampilkan detail produk yang dipilih |



Route `/` digunakan sebagai `initialRoute` karena halaman pertama yang dibutuhkan pengguna adalah daftar produk.



\## 2. Navigation Flow



```mermaid

flowchart TD

&#x20;   A\[Daftar Produk] -->|Pilih Produk| B\[Detail Produk]

&#x20;   B -->|Kembali| A

&#x20;   B -->|Buat Transaksi| C\[Halaman Transaksi]

&#x20;   C -->|Data valid| D\[SnackBar]

&#x20;   D -->|Selesai| A

&#x20;   C -->|Kembali| B

```



\## 3. Penjelasan Alur



\### Daftar Produk → Detail Produk

Pengguna melihat daftar produk yang tersedia di warung. Ketika salah satu produk dipilih, aplikasi membuka halaman detail dan mengirimkan data produk sebagai arguments.



\### Detail Produk → Daftar Produk

Pengguna dapat menekan tombol kembali untuk kembali ke halaman daftar produk.



\### Detail Produk → Halaman Transaksi

Pengguna dapat memilih tombol untuk membuat transaksi dari produk yang sedang dilihat. Data produk diteruskan ke halaman transaksi.



\### Halaman Transaksi → SnackBar → Daftar Produk

Pengguna mengisi data transaksi. Jika data sudah valid, aplikasi menampilkan SnackBar sebagai feedback bahwa transaksi berhasil disimpan, kemudian pengguna kembali ke halaman daftar produk.



\### Form Tidak Valid

Jika data pada form belum lengkap atau tidak sesuai, validator akan menampilkan pesan pada field yang bermasalah. Pengguna harus memperbaiki data sebelum transaksi dapat diproses.



\## 4. Data yang Dikirim



Data produk yang dikirim melalui arguments terdiri dari:



\- Nama produk

\- Harga produk

\- Status ketersediaan



Arguments digunakan pada perpindahan menuju halaman Detail Produk dan Halaman Transaksi agar halaman tujuan dapat menampilkan produk yang dipilih.



\## 5. Alasan Menggunakan Named Route



Named route digunakan agar perpindahan antarhalaman memiliki nama route yang jelas dan mudah dikelola. Selain itu, penggunaan `initialRoute`, `Navigator.pushNamed`, dan `Navigator.pop` sesuai dengan konsep navigasi yang digunakan pada aplikasi Flutter.



\## 6. Skenario Pengujian



1\. Pengguna membuka aplikasi dan melihat daftar produk.

2\. Pengguna memilih salah satu produk dan melihat detailnya.

3\. Pengguna kembali ke daftar produk.

4\. Pengguna membuka halaman transaksi.

5\. Jika form kosong, validator menampilkan pesan kesalahan.

6\. Jika form diisi dengan benar, aplikasi menampilkan SnackBar.

7\. Setelah transaksi selesai, pengguna kembali ke halaman daftar produk.

