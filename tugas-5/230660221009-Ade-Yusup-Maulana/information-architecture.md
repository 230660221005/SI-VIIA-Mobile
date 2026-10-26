\# Information Architecture — PAB Penjualan Warung



\## 1. Inventaris Layar



Information Architecture disusun berdasarkan tabel pemetaan kebutuhan pada Tugas 4.



| No. | Nama Layar | Kebutuhan yang Dipenuhi | Prioritas |

|---|---|---|---|

| 1 | Halaman Daftar Produk | F-01 Melihat daftar produk, harga, dan ketersediaan; F-02 Memilih produk untuk transaksi | Must Have |

| 2 | Halaman Transaksi | F-03 Menentukan jumlah produk; F-04 Menyimpan transaksi penjualan | Must Have |

| 3 | Halaman Riwayat Transaksi | F-05 Melihat riwayat transaksi | Should Have |

| 4 | Halaman Ringkasan Penjualan | F-06 Melihat ringkasan total penjualan | Could Have |



\## 2. Layar Utama



Layar utama yang dipilih adalah \*\*Halaman Daftar Produk\*\* karena halaman ini memenuhi kebutuhan F-01 dan F-02 yang termasuk kategori Must Have. Halaman ini menjadi titik awal penjaga/kasir untuk melihat produk yang tersedia dan memilih produk sebelum melakukan transaksi penjualan.



\## 3. Diagram Information Architecture



```mermaid

flowchart TD

&#x20;   A\["Halaman Daftar Produk<br>F-01, F-02<br>Layar Utama"]



&#x20;   A --> B\["Halaman Transaksi<br>F-03, F-04"]

&#x20;   A --> C\["Halaman Riwayat Transaksi<br>F-05"]

&#x20;   A --> D\["Halaman Ringkasan Penjualan<br>F-06"]

```



\## 4. Penjelasan Struktur



\*\*Halaman Daftar Produk\*\* ditempatkan sebagai layar utama karena merupakan titik awal proses penjualan. Dari halaman tersebut, pengguna nantinya dapat menuju Halaman Transaksi untuk melanjutkan proses penjualan, sedangkan Halaman Riwayat Transaksi dan Halaman Ringkasan Penjualan digunakan untuk membantu pemilik warung melihat informasi transaksi dan penjualan.

