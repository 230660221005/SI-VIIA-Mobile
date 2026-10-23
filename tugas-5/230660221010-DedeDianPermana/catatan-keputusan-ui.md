\# Catatan Keputusan UI — SiRuang Kampus



\## 1. Identitas



| Keterangan | Isi |

|---|---|

| Nama | Dede Dian Permana |

| NIM | 230660221010 |

| Kelas | SI-VIIA |

| Nama Aplikasi | SiRuang Kampus |



\## 2. Keputusan Desain Antarmuka



| No. | Aspek UI | Keputusan Desain | Alasan |

|---|---|---|---|

| 1 | Warna utama | Menggunakan warna biru sebagai `seedColor` pada `ColorScheme.fromSeed`. | Warna biru memberikan kesan profesional dan sesuai untuk aplikasi layanan kampus. Penggunaan tema juga menjaga konsistensi warna antarelemen. |

| 2 | Tampilan status | Status ruangan menggunakan label Tersedia dan Dipakai dengan warna yang dibedakan berdasarkan kondisi ruangan. | Mahasiswa dapat mengenali ketersediaan ruangan dengan cepat. Keputusan ini mendukung kebutuhan F-01. |

| 3 | Posisi aksi utama | Tombol Ajukan Peminjaman ditempatkan pada bagian bawah kanan layar menggunakan `FloatingActionButton.extended`. | Tombol mudah ditemukan setelah pengguna melihat daftar ruangan. Aksi ini mendukung kebutuhan F-03. |

| 4 | Hierarki teks | Judul Daftar Ruangan menggunakan ukuran teks lebih besar dan tebal daripada keterangan kategori dan status. | Hierarki teks membantu pengguna memahami informasi utama terlebih dahulu dan membaca rincian ruangan dengan lebih mudah. |

| 5 | Keadaan kosong | Menampilkan ikon, judul, dan keterangan ketika daftar ruangan kosong. | Pengguna tetap mendapatkan informasi ketika belum ada data ruangan. Tampilan ini membuat keadaan kosong lebih jelas daripada layar kosong tanpa keterangan. |



\## 3. Konsistensi Rancangan



Rancangan antarmuka dibuat dengan mengacu pada information architecture dan wireframe yang telah disusun. Nama layar utama tetap menggunakan Halaman Daftar Ruangan sesuai pemetaan kebutuhan F-01 pada Tugas 4. Implementasi Flutter menggunakan tema Material 3 agar warna dan tampilan komponen tetap konsisten.



\## 4. Catatan Implementasi



Halaman utama menggunakan `Scaffold`, `AppBar`, `ListView.builder`, `Card`, dan `ListTile` untuk menyusun daftar ruangan. Status ruangan dibedakan menggunakan kondisi ternary, sedangkan warna status mengambil nilai dari `ColorScheme`. Tombol Ajukan Peminjaman saat ini menampilkan pesan informasi dan belum menjalankan proses navigasi atau penyimpanan permohonan.

