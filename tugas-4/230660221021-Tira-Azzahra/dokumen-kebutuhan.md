# Tugas 4 — Dokumen Kebutuhan dan User Flow
**Nama:** Tira Azzahra  
**NIM:** 230660221021  
**Domain:** Sistem Informasi Perpustakaan Kampus  
**Target demo:** Flutter Web (Chrome)

---

## 1. Deskripsi Aplikasi

Aplikasi yang dirancang adalah **aplikasi Perpustakaan Kampus berbasis Flutter** yang membantu mahasiswa mengakses layanan perpustakaan dengan lebih cepat tanpa harus datang langsung hanya untuk mengecek ketersediaan buku. Masalah yang sering terjadi adalah mahasiswa kesulitan mengetahui **stok buku**, lupa **tenggat pengembalian**, dan pencarian buku kurang praktis ketika waktu terbatas. Pada proyek praktikum ini, aplikasi **didemo-kan menggunakan target Web (Chrome)** agar dapat diverifikasi tanpa Android Studio, namun rancangan antarmuka tetap mempertimbangkan pola penggunaan mobile (layar kecil dan sesi singkat) melalui tampilan yang responsif.

---

## 2. User Persona

### Persona 1 — Rani — Mahasiswa (Peminjam Buku)

| Komponen | Isi |
|:--|:--|
| Nama dan peran | Rani — mahasiswa yang meminjam buku untuk tugas kuliah |
| Tujuan | Menemukan buku yang dibutuhkan, mengetahui ketersediaan/stok, dan mengajukan peminjaman/reservasi dengan cepat |
| Kendala | Waktu luang singkat; sering mengecek di sela kuliah; koneksi kampus kadang tidak stabil |
| Perangkat dan konteks | Umumnya ponsel; pada praktikum aplikasi ditampilkan melalui **Chrome (web)** dengan ukuran tampilan menyerupai layar mobile |
| Frekuensi penggunaan | 1–3 kali per minggu saat masa tugas/UTS/UAS |

### Persona 2 — Budi — Petugas Perpustakaan (Operator)

| Komponen | Isi |
|:--|:--|
| Nama dan peran | Budi — petugas yang memproses permintaan peminjaman dan memperbarui stok buku |
| Tujuan | Memproses permintaan peminjaman lebih cepat dan memastikan data buku/stok akurat |
| Kendala | Permintaan dapat menumpuk pada jam tertentu; perlu tampilan ringkas untuk memproses cepat |
| Perangkat dan konteks | Laptop/PC di meja layanan (akses melalui web/Chrome) |
| Frekuensi penggunaan | Setiap hari kerja |

---

## 3. Kebutuhan Fungsional

> Pola: **[aktor] dapat [aksi] [objek] [kondisi/hasil]** (1 kebutuhan = 1 fungsi)

| ID | Rumusan Kebutuhan | Terkait Persona |
|:--|:--|:--|
| F-01 | Mahasiswa dapat melihat daftar katalog buku beserta status ketersediaan (tersedia/habis) sehingga dapat menentukan buku yang bisa dipinjam. | Persona 1 |
| F-02 | Mahasiswa dapat mencari buku berdasarkan judul atau penulis sehingga pencarian buku lebih cepat. | Persona 1 |
| F-03 | Mahasiswa dapat melihat detail buku (judul, penulis, kategori, lokasi rak, dan stok) sehingga memahami informasi sebelum meminjam. | Persona 1 |
| F-04 | Mahasiswa dapat mengajukan peminjaman atau reservasi buku dari halaman detail dan sistem mencatat permintaan dengan status (mis. *menunggu*). | Persona 1 |
| F-05 | Mahasiswa dapat melihat daftar peminjaman aktif dan riwayat peminjaman beserta tenggat pengembalian sehingga dapat memantau kewajiban pengembalian. | Persona 1 |
| F-06 | Mahasiswa dapat menerima pengingat tenggat pengembalian sebelum jatuh tempo sehingga mengurangi risiko keterlambatan. | Persona 1 |
| F-07 | Petugas dapat memperbarui stok buku (mis. bertambah/berkurang) sehingga status ketersediaan pada katalog tetap akurat. | Persona 2 |

---

## 4. Kebutuhan Nonfungsional (terukur)

| ID | Kategori | Rumusan | Kriteria Terukur |
|:--|:--|:--|:--|
| NF-01 | Kegunaan (Usability) | Alur utama untuk menemukan buku dan mengajukan peminjaman/reservasi harus singkat. | Dari halaman katalog hingga permintaan tercatat maksimal **6 langkah** (tidak termasuk login). |
| NF-02 | Kinerja (Performance) | Halaman katalog harus responsif saat data cukup banyak. | Daftar katalog (≤ 50 item) tampil maksimal **3 detik** pada jaringan kampus; membuka detail buku maksimal **1 detik** setelah item dipilih. |
| NF-03 | Kompatibilitas | Aplikasi dapat diverifikasi pada lingkungan praktikum tanpa emulator. | Aplikasi dapat dijalankan pada **Chrome (Flutter Web)**; tampilan tetap terbaca pada lebar layar minimal **360px**. |

---

## 5. Prioritas Fitur (MoSCoW)

> Semua kebutuhan fungsional wajib berprioritas. **Must have maksimal 5.**

| Prioritas | ID Kebutuhan | Alasan (rujuk persona/tujuan) |
|:--|:--|:--|
| Must have | F-01, F-02, F-03, F-04, F-05 | Ini inti kebutuhan mahasiswa: menemukan buku, cek stok/detail, mengajukan pinjam/reservasi, dan memantau tenggat. Tanpa ini aplikasi tidak menyelesaikan masalah utama perpustakaan. |
| Should have | F-06 | Pengingat membantu mencegah keterlambatan, tetapi alur peminjaman masih dapat berjalan tanpa notifikasi. |
| Could have | F-07 | Fitur petugas menambah kualitas data stok, tetapi dapat dibuat versi sederhana terlebih dahulu agar fokus MVP mahasiswa selesai. |
| Won’t have (saat ini) | (Contoh) pembayaran denda online | Memerlukan integrasi pembayaran dan kebijakan kampus; terlalu kompleks untuk target semester ini sehingga ditunda. |

---

## 6. User Flow (alur utama pengguna utama)

**Nama alur:** Mengajukan peminjaman/reservasi buku  
**Aktor:** Persona 1 (Mahasiswa)  
**Tujuan:** Permintaan peminjaman/reservasi tercatat dan muncul pada daftar peminjaman/riwayat.

```mermaid
flowchart TD
    S(["Mulai: mahasiswa membuka aplikasi"]) --> A["Halaman Katalog (daftar buku)"]
    A --> B["Cari buku (opsional)"]
    B --> C["Pilih salah satu buku"]
    C --> D["Halaman Detail Buku"]
    D --> E{"Stok tersedia?"}
    E -- "Tidak" --> F["Tampilkan status 'Habis' + kembali ke katalog"]
    F --> A
    E -- "Ya" --> G["Klik tombol Pinjam/Reservasi"]
    G --> H["Form konfirmasi (mis. identitas + catatan)"]
    H --> I{"Data form valid?"}
    I -- "Tidak" --> J["Tampilkan pesan error + kembali ke form"]
    J --> H
    I -- "Ya" --> K["Kirim permintaan peminjaman/reservasi"]
    K --> L["Halaman konfirmasi + status permintaan"]
    L --> T(["Tujuan tercapai: permintaan tercatat"])