# Tugas 5 — Prototype UI/UX Perpustakaan Kampus

## Identitas

| Informasi | Detail |
|:--|:--|
| Nama | Tira Azzahra |
| NIM | 230660221021 |
| Kelas | SI-VIIA |
| Mata Kuliah | Pemrograman Aplikasi Bergerak |
| Pertemuan | 5 — UI/UX Mobile |
| Domain | Sistem Informasi Perpustakaan Kampus |
| Target Demo | Flutter Web / Chrome |

---

## Deskripsi Singkat

Tugas ini berisi prototype UI/UX untuk aplikasi **Perpustakaan Kampus**. Prototype dirancang untuk membantu mahasiswa mencari buku, melihat status ketersediaan, dan memulai proses peminjaman atau reservasi buku. Implementasi dilakukan menggunakan Flutter dengan target demo Web/Chrome sehingga tidak memerlukan Android Studio atau emulator.

---

## Tujuan Prototype

Prototype ini dibuat untuk menerjemahkan hasil analisis kebutuhan dari Tugas 4 ke dalam rancangan antarmuka yang lebih konkret. Fokus utama rancangan adalah layar **Katalog Buku** sebagai halaman utama aplikasi. Layar ini dipilih karena kebutuhan awal mahasiswa adalah melihat daftar buku, mencari buku, dan mengetahui status stok sebelum melakukan peminjaman.

---

## Kebutuhan yang Dipenuhi

| ID | Kebutuhan | Implementasi pada Prototype |
|:--|:--|:--|
| F-01 | Mahasiswa dapat melihat katalog buku beserta status ketersediaan | Ditampilkan melalui daftar buku menggunakan `ListView.builder`, `Card`, dan `ListTile` |
| F-02 | Mahasiswa dapat mencari buku berdasarkan judul atau penulis | Disediakan area pencarian berupa `TextField` |
| F-03 | Mahasiswa dapat melihat detail buku | Digambarkan pada wireframe layar kedua: Detail Buku |
| F-04 | Mahasiswa dapat mengajukan peminjaman/reservasi | Ditampilkan melalui tombol aksi utama `FloatingActionButton.extended` dan tombol pada wireframe detail |
| F-05 | Mahasiswa dapat melihat peminjaman aktif dan riwayat | Dicantumkan pada information architecture sebagai layar pendukung |
| F-06 | Mahasiswa dapat menerima pengingat tenggat pengembalian | Dicantumkan pada information architecture sebagai fitur pendukung |

---

## Struktur Berkas

| Berkas | Keterangan |
|:--|:--|
| `information-architecture.md` | Berisi daftar layar, diagram information architecture, dan alasan pemilihan layar utama |
| `wireframe.png` | Wireframe low fidelity berisi minimal dua layar: Katalog Buku dan Detail Buku |
| `halaman-utama.dart` | Implementasi layar utama Flutter menggunakan tema, daftar buku, status stok, aksi utama, dan empty state |
| `screenshot-halaman.png` | Bukti tampilan UI Flutter yang sudah dijalankan melalui Chrome/DartPad |
| `catatan-keputusan-ui.md` | Catatan keputusan UI/UX berisi alasan pemilihan warna, komponen, status, dan hierarki visual |
| `README.md` | Dokumentasi tugas, deskripsi prototype, refleksi, dan deklarasi penggunaan AI |

---

## Information Architecture

Prototype ini menggunakan layar utama **Katalog Buku**. Dari layar tersebut, pengguna dapat diarahkan secara konsep ke beberapa layar pendukung seperti Detail Buku, Form Pinjam/Reservasi, Riwayat Peminjaman, dan Pengaturan Pengingat.

Diagram dan penjelasan lengkap tersedia pada file:

```text
information-architecture.md

<!-- Updated for PR submission -->