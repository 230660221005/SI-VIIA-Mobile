# Catatan Keputusan Navigasi — SiAngkut

**Nama:** Clara Desmiati  
**NIM:** 230660221005
**Mata Kuliah:** Pemrograman Aplikasi Bergerak

## 1. Keputusan Navigasi

| Keputusan | Pilihan | Alasan |
|---|---|---|
| Nama route | `/`, `/detail-jadwal`, dan `/form-laporan` | Nama route dibuat jelas agar sesuai dengan halaman utama, detail jadwal, dan form laporan pada navigation flow. |
| Data antarlayar | Objek `JadwalPengangkutan` dikirim melalui `arguments` | Data hari, wilayah, status, dan keterangan dapat ditampilkan pada halaman detail tanpa harus dipilih ulang. |
| Initial route | `/` — Halaman Utama | Halaman utama menjadi titik awal agar pengguna dapat melihat jadwal dan memilih layanan yang diperlukan. |
| Pemeriksaan arguments | Menggunakan operator `is` dan pemeriksaan `null` | Pemeriksaan mencegah aplikasi langsung menggunakan data yang tidak tersedia atau bertipe tidak sesuai. |

## 2. Keputusan Form dan Validasi

| Field | Aturan Validator | Alasan |
|---|---|---|
| Nama Pelapor | Tidak boleh kosong atau hanya berisi spasi | Nama diperlukan untuk mengetahui siapa yang menyampaikan laporan. |
| Alamat | Tidak boleh kosong atau hanya berisi spasi | Alamat membantu mengidentifikasi lokasi layanan yang dilaporkan. |
| Keterangan Laporan | Tidak boleh kosong atau hanya berisi spasi | Keterangan diperlukan untuk menjelaskan masalah pengangkutan sampah. |

Semua field menggunakan `TextFormField` dan validator. Form menggunakan `GlobalKey<FormState>` untuk memeriksa seluruh input sebelum laporan diproses.

## 3. Keputusan Feedback Interaksi

| Aksi | Feedback | Alasan |
|---|---|---|
| Pengguna mengirim form yang belum lengkap | Pesan validasi muncul pada field terkait | Pengguna mengetahui bagian yang harus diperbaiki. |
| Pengguna mengirim form yang valid | `SnackBar` menampilkan konfirmasi simulasi | Pengguna mengetahui bahwa aksi pengiriman berhasil dijalankan. |
| Pengguna membuka detail jadwal tanpa data | Pesan bahwa data jadwal tidak tersedia | Aplikasi memberikan informasi yang jelas jika arguments tidak tersedia. |
| Pengguna menekan tombol kembali | Aplikasi kembali ke halaman sebelumnya melalui `Navigator.pop` | Pengguna dapat kembali tanpa harus memulai alur dari awal. |

## 4. Batas Implementasi

Pengiriman laporan pada Tugas 6 masih berupa simulasi. Data laporan belum disimpan secara permanen karena pengelolaan data lokal menjadi materi Pertemuan 7.

Nama route pada dokumen ini harus sama persis dengan nama route pada `MaterialApp`, pemanggilan `Navigator.pushNamed`, dan diagram `navigation-flow.md`.