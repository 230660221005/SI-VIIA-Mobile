# Catatan Keputusan UI/UX
## Aplikasi Mobile Pengelolaan Penjualan Warung

### 1. Pemilihan Warna Utama

Warna utama aplikasi menggunakan teal melalui `ColorScheme.fromSeed(seedColor: Colors.teal)` dengan `useMaterial3: true`. Warna ini diterapkan secara konsisten melalui tema Material 3 agar tampilan antarmuka terlihat seragam. Penggunaan warna dari tema juga memudahkan penyesuaian warna komponen tanpa menetapkan warna secara terpisah pada setiap bagian.

**Dasar keputusan:** Prinsip konsistensi dan kebutuhan pengguna untuk memperoleh informasi stok dengan cepat.

### 2. Penyajian Status Stok

Status stok dibedakan menjadi Tersedia, Stok Menipis, dan Habis. Status ditampilkan menggunakan label berwarna agar pengguna dapat mengenali kondisi barang dengan cepat. Pada prototipe ini, stok 0 dikategorikan Habis, stok 1–3 dikategorikan Stok Menipis, dan stok lebih dari 3 dikategorikan Tersedia.

Batas stok menipis sebanyak 3 unit merupakan asumsi prototipe dan perlu disesuaikan dengan kebijakan stok minimum warung sebenarnya. Informasi status juga ditampilkan dalam bentuk teks, bukan hanya warna, sehingga maknanya tetap dapat dipahami oleh pengguna.

**Dasar keputusan:** Kebutuhan F-03 untuk melihat stok terkini dan peringatan stok minimum, serta persona Ibu Sri yang perlu mengetahui barang yang hampir habis.

### 3. Penempatan Tombol Aksi Utama

Tombol “Tambah Transaksi” ditempatkan sebagai `FloatingActionButton.extended` agar mudah ditemukan ketika pemilik warung ingin memulai pencatatan penjualan. Tombol menggunakan ikon dan teks untuk memperjelas fungsinya.

Pada prototipe saat ini, tombol memberikan umpan balik berupa pesan bahwa halaman transaksi belum dihubungkan. Fungsinya masih berupa demonstrasi antarmuka dan belum menyimpan transaksi sungguhan.

**Dasar keputusan:** Kebutuhan F-02 untuk mencatat transaksi penjualan dan kebutuhan nonfungsional NF-01 agar pencatatan transaksi dapat dilakukan melalui alur yang ringkas.

### 4. Hierarki Informasi dan Keterbacaan

Nama barang ditampilkan dengan huruf tebal, sedangkan kategori, harga, dan jumlah stok diletakkan pada bagian informasi pendukung. Susunan ini membantu pengguna menemukan nama barang terlebih dahulu, kemudian membaca informasi stok dan harga.

Setiap barang ditempatkan dalam komponen `Card` dengan `ListTile` agar daftar mudah dipindai. Jarak antarelemen dan ukuran teks juga dipertimbangkan agar informasi tetap terbaca pada layar ponsel.

**Dasar keputusan:** Prinsip hierarki visual, keterbacaan, dan konteks penggunaan aplikasi oleh pemilik warung ketika melayani pelanggan.

### 5. Penanganan Kondisi Kosong

Jika daftar barang tidak memiliki data, aplikasi menampilkan ikon, teks “Belum ada data barang”, dan penjelasan bahwa barang yang ditambahkan akan tampil di sana. Kondisi ini dirancang agar pengguna memperoleh informasi yang jelas ketika belum ada data yang dapat ditampilkan.

**Dasar keputusan:** Prinsip umpan balik sistem dan kebutuhan agar pengguna memahami kondisi aplikasi, bukan mengira halaman gagal dimuat.

### 6. Penyesuaian Lebar Konten

Konten dashboard dibatasi dengan lebar maksimal 500 piksel menggunakan `ConstrainedBox`. Pengaturan ini membuat daftar barang tidak terlalu melebar ketika aplikasi dijalankan di browser komputer, sementara pada layar yang lebih kecil konten tetap dapat mengikuti lebar layar.

**Dasar keputusan:** Prinsip desain responsif dan keterbacaan pada perangkat dengan ukuran layar berbeda.

### 7. Batasan Prototipe

Data barang masih berupa data contoh yang ditulis langsung dalam kode. Prototipe belum menggunakan basis data, belum memperbarui stok secara otomatis, dan belum menyimpan transaksi penjualan. Tombol transaksi hanya memberikan umpan balik sementara. Batasan ini perlu diperhatikan agar tampilan prototipe tidak dianggap sebagai aplikasi penjualan yang sudah berfungsi penuh.