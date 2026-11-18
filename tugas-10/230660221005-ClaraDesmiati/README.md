# Tugas 10 — Integrasi Data dan Proses Bisnis

**Nama:** Clara Desmiati  
**NIM:** 230660221005  
**Kelas:** SI-VIIA  
**Mata Kuliah:** Pemrograman Aplikasi Bergerak  
**Nama Aplikasi:** SIAngkut

## 1. Deskripsi Singkat

Tugas ini mengembangkan aplikasi SIAngkut dengan mengintegrasikan data pengguna dan data pengajuan dari API simulasi JSONPlaceholder. Data diambil dari dua endpoint, kemudian digabungkan berdasarkan identifier `userId`.

Aplikasi menampilkan daftar laporan yang berisi judul, nama pelapor, deskripsi, dan status pengajuan. Halaman juga menyediakan kondisi loading, sukses, kosong, dan error dengan tombol coba lagi.

## 2. Struktur Proyek

```text
230660221005-ClaraDesmiati/
├── lib/
│   ├── main.dart
│   ├── models/
│   │   ├── data_pengguna.dart
│   │   └── data_pengajuan.dart
│   └── services/
│       └── integrasi_service.dart
├── pubspec.yaml
├── README.md
├── diagram-integrasi.md
├── jawaban-quiz-pertemuan-10.md
└── refleksi.md
```

## 3. Endpoint yang Digunakan

API simulasi: https://jsonplaceholder.typicode.com

| Data | Metode | Endpoint | Kegunaan |
|---|---|---|---|
| Pengguna | GET | `/users` | Mengambil data pengguna |
| Pengajuan | GET | `/posts?_limit=10` | Mengambil data pengajuan |
| Pengajuan baru | POST | `/posts` | Simulasi pengiriman pengajuan |

Seluruh request menggunakan package `http`, timeout 15 detik, pemeriksaan status HTTP, dan try-catch.

## 4. Pemetaan JSON ke Model Dart

### DataPengguna

| Field Dart | Key JSON | Nilai Default |
|---|---|---|
| id | id | 0 |
| nama | name | Tanpa Nama |

### DataPengajuan

| Field Dart | Key JSON | Nilai Default |
|---|---|---|
| id | id | 0 |
| userId | userId | 0 |
| judul | title | Tanpa Judul |
| deskripsi | body | Tidak ada deskripsi |
| status | - | Menunggu |

Status merupakan nilai simulasi lokal karena endpoint `/posts` tidak menyediakan field status.

## 5. Identifier Penghubung

Penggabungan menggunakan `DataPengajuan.userId` dan `DataPengguna.id`.

Identifier tersebut digunakan untuk menemukan nama pengguna yang sesuai dengan setiap pengajuan. Data yang sudah digabungkan dikembalikan dalam bentuk model `DataPengajuanGabungan`.

## 6. Proses Integrasi

Dua request GET tidak saling bergantung sehingga dijalankan menggunakan `Future.wait`. Setelah kedua respons berhasil diterima, JSON diubah menjadi model Dart. Selanjutnya, data pengajuan dicocokkan dengan data pengguna berdasarkan `userId`.

Metode POST digunakan untuk simulasi pengiriman pengajuan baru. Respons server diperiksa dan diubah kembali menjadi model `DataPengajuan`.

## 7. Penanganan Kondisi Halaman

| Kondisi | Penanganan |
|---|---|
| Loading | Menampilkan indikator proses |
| Sukses | Menampilkan daftar laporan |
| Kosong | Menampilkan informasi belum ada laporan |
| Error | Menampilkan pesan gagal dan tombol Coba Lagi |

Kondisi kosong berbeda dengan error. Kosong berarti request berhasil tetapi tidak menghasilkan data, sedangkan error berarti proses pengambilan data gagal.

## 8. Diagram Integrasi

Diagram alur integrasi terdapat pada file `diagram-integrasi.md`.

## 9. Cara Menjalankan

1. Pastikan Flutter sudah terpasang.
2. Buka terminal pada folder project.
3. Jalankan `flutter pub get`.
4. Jalankan `flutter run -d chrome` pada project yang memiliki konfigurasi platform Web.

## 10. Skenario Pengujian

| No. | Pengujian | Hasil yang Diharapkan |
|---|---|---|
| 1 | Membuka halaman integrasi | Indikator loading tampil |
| 2 | API berhasil merespons | Data pengguna dan pengajuan tampil |
| 3 | Data kosong | Pesan belum ada data tampil |
| 4 | Request gagal | Pesan error dan tombol Coba Lagi tampil |
| 5 | Menekan Coba Lagi | Request dijalankan kembali |
| 6 | Mengirim POST | Server simulasi mengembalikan respons 201 |

## 11. Batasan API

JSONPlaceholder merupakan API simulasi. Data pengguna dan judul pengajuan merupakan data contoh, bukan data asli warga Tanggulun atau Desa Cimalaka. Metode POST hanya memberikan respons simulasi dan tidak menyimpan data secara permanen. Status Menunggu juga ditentukan secara lokal.

## 12. Deklarasi Penggunaan AI

ChatGPT (OpenAI) digunakan untuk membantu memahami dan memperbaiki kode integrasi, menyusun dokumentasi, serta menjelaskan proses penggabungan data. Pemeriksaan dan pengujian aplikasi dilakukan oleh penulis.
