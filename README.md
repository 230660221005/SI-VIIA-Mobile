# 📱 Tugas 3 — Halaman Aplikasi Sederhana

> **Pendidikan Aplikasi Bergerak (PAB)**  
> Implementasi Struktur Aplikasi Flutter, Layout, dan Widget Tree pada Sistem Informasi Perpustakaan Kampus.

---

## 👤 Identitas Mahasiswa

| Informasi | Detail |
|---|---|
| **Nama** | Tira Azzahra |
| **NIM** | 230660221021 |
| **Kelas** | SI-VIIA |
| **Domain SI** | Perpustakaan Kampus |
| **File Utama** | `halaman_aplikasi.dart` |

---

## 📚 1. Deskripsi Halaman

Halaman utama aplikasi perpustakaan kampus ini dirancang untuk menampilkan daftar katalog buku yang tersedia beserta informasi detail seperti judul, penulis, kategori, dan status ketersediaan secara langsung. Aplikasi ini dibangun menggunakan struktur widget dasar Flutter dengan kombinasi layout yang responsif dan rapi agar memudahkan mahasiswa dalam mengecek ketersediaan buku secara visual dan intuitif melalui smartphone.

---

## 🏗️ 2. Widget Tree

![Widget Tree](./widget-tree.png)

File sumber: `widget-tree.mmd` (Mermaid).

---

## 🖼️ 3. Tangkapan Layar Aplikasi

![Screenshot Halaman](./screenshot-halaman.png)

---

## 💭 4. Refleksi

Widget layout yang paling sulit saya rangkai adalah kombinasi antara `Column` dan `ListView.builder` karena sempat menyebabkan error `RenderFlex overflow` saat pertama kali dijalankan. Hal tersebut terjadi karena `ListView` mencoba mengambil tinggi tanpa batas di dalam `Column` yang juga memiliki orientasi vertikal. Masalah ini berhasil diselesaikan setelah membungkus `ListView.builder` dengan widget `Expanded` sehingga daftar buku dapat menyesuaikan sisa ruang layar secara dinamis.