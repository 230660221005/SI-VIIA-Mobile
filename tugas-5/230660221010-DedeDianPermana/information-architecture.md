\# Information Architecture — SiRuang Kampus



\## 1. Identitas



| Keterangan | Isi |

|---|---|

| Nama | Dede Dian Permana |

| NIM | 230660221010 |

| Kelas | SI-VIIA |

| Nama aplikasi | SiRuang Kampus |

| Domain | Sistem Informasi Peminjaman Ruang Kelas |



\## 2. Inventaris Layar



| No. | Nama Layar | ID Kebutuhan | Fungsi |

|---:|---|---|---|

| 1 | Halaman Daftar Ruangan | F-01 | Menampilkan daftar ruangan, kategori, dan status ketersediaan ruangan. |

| 2 | Halaman Detail dan Jadwal Ruangan | F-02 | Menampilkan jadwal penggunaan ruangan berdasarkan tanggal yang dipilih. |

| 3 | Halaman Formulir Peminjaman | F-03 | Menyediakan formulir untuk mengisi ruangan, tanggal, waktu, dan tujuan peminjaman. |

| 4 | Halaman Status Peminjaman | F-04 | Menampilkan status permohonan, yaitu menunggu, disetujui, atau ditolak. |

| 5 | Halaman Daftar Permohonan Petugas | F-05 | Menampilkan daftar permohonan peminjaman yang masuk untuk diperiksa petugas. |

| 6 | Halaman Pemeriksaan Permohonan | F-06 | Membantu petugas memeriksa benturan jadwal peminjaman. |

| 7 | Halaman Detail Permohonan Petugas | F-07, F-08 | Menampilkan detail permohonan dan menyediakan tindakan persetujuan atau penolakan beserta alasannya. |



\## 3. Diagram Information Architecture



```mermaid

flowchart TD

&#x20;   A\["Halaman Daftar Ruangan<br/>F-01"]



&#x20;   A --> B\["Halaman Detail dan Jadwal Ruangan<br/>F-02"]

&#x20;   A --> C\["Halaman Formulir Peminjaman<br/>F-03"]

&#x20;   A --> D\["Halaman Status Peminjaman<br/>F-04"]



&#x20;   A --> E\["Halaman Daftar Permohonan Petugas<br/>F-05"]

&#x20;   E --> F\["Halaman Pemeriksaan Permohonan<br/>F-06"]

&#x20;   E --> G\["Halaman Detail Permohonan Petugas<br/>F-07, F-08"]

```



\## 4. Alasan Pemilihan Layar Utama



Halaman Daftar Ruangan dipilih sebagai layar utama karena memenuhi kebutuhan F-01 yang berprioritas Must have. Layar ini membantu mahasiswa mengetahui daftar ruangan, kategori, dan status ketersediaannya sehingga menjadi titik awal untuk proses peminjaman ruang kelas.



\## 5. Catatan Rancangan



Nama layar dan ID kebutuhan disesuaikan dengan tabel Pemetaan Kebutuhan ke Antarmuka pada dokumen Tugas 4. Diagram ini menggambarkan pengelompokan informasi dan layar yang direncanakan, bukan implementasi navigasi aplikasi. Implementasi navigasi belum dilakukan karena berada di luar cakupan tugas ini.



