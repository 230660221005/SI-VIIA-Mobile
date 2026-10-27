# Catatan Keputusan UI/UX — SI-FASKAM

| Keputusan | Pilihan | Alasan |
|---|---|---|
| Warna benih | Biru (`Colors.blue`) | Menghasilkan skema warna yang konsisten dan membantu membedakan elemen utama antarmuka. |
| Bentuk status | Teks status dengan warna yang berasal dari `ColorScheme` | Membantu mahasiswa membedakan laporan yang menunggu, diproses, dan selesai. Status tetap ditulis sebagai teks agar tidak bergantung pada warna saja. |
| Posisi aksi utama | Tombol “Buat Pengaduan” di bagian bawah layar | Membuat tindakan utama mudah ditemukan ketika mahasiswa ingin mengirim laporan baru. |
| Hierarki teks | Kategori menggunakan teks tebal, deskripsi sebagai teks pendukung, dan status diberi penekanan | Memudahkan mahasiswa memindai laporan dan mengenali informasi yang penting. |
| Keadaan kosong | Ikon kotak masuk dan pesan “Belum ada pengaduan” | Memberi umpan balik yang jelas saat mahasiswa belum memiliki laporan. |
| Konsistensi komponen | Menggunakan `Card`, `ListTile`, dan komponen Material 3 | Menjaga tampilan daftar tetap konsisten dan mudah dibaca. |