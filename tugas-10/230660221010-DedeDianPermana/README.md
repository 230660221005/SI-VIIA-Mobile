# TUGAS 10 - INTEGRASI DATA API
## SiRuang Kampus

**Nama:** Dede Dian Permana  
**NIM:** 230660221010  
**Kelas:** SI-VIIA  
**Mata Kuliah:** Pemrograman Aplikasi Bergerak

## 1. Deskripsi Aplikasi

SiRuang Kampus merupakan aplikasi sistem informasi peminjaman ruang kelas yang dikembangkan menggunakan Flutter. Pada tugas ini, aplikasi menerapkan integrasi data dari REST API untuk mengambil data pengguna dan data pengajuan.

Data dari kedua endpoint digabungkan sehingga setiap pengajuan dapat menampilkan nama pengguna yang sesuai berdasarkan identitas pengguna (`userId`).

## 2. Endpoint API

Aplikasi menggunakan layanan JSONPlaceholder sebagai API simulasi.

| Endpoint | Method | Fungsi |
|---|---|---|
| `https://jsonplaceholder.typicode.com/users` | GET | Mengambil data pengguna |
| `https://jsonplaceholder.typicode.com/posts` | GET | Mengambil data pengajuan |

## 3. Model Data

Aplikasi menggunakan dua model utama:

**a. DataUser**

Digunakan untuk menampung data pengguna dari API, meliputi:
- `id`
- `name`
- `username`
- `email`

**b. DataPengajuan**

Digunakan untuk menampung data pengajuan, meliputi:
- `id`
- `userId`
- `namaPengguna`
- `judul`
- `deskripsi`

Kedua model memiliki factory `fromJson()` untuk mengubah respons JSON menjadi objek Dart.

## 4. Pemetaan Field JSON

| Field API | Model Dart | Keterangan |
|---|---|---|
| `id` pada users | `DataUser.id` | ID pengguna |
| `name` | `DataUser.name` | Nama pengguna |
| `username` | `DataUser.username` | Nama akun |
| `email` | `DataUser.email` | Email pengguna |
| `id` pada posts | `DataPengajuan.id` | ID pengajuan |
| `userId` | `DataPengajuan.userId` | ID pemilik pengajuan |
| `title` | `DataPengajuan.judul` | Judul pengajuan |
| `body` | `DataPengajuan.deskripsi` | Deskripsi pengajuan |

## 5. Proses Integrasi Data

Integrasi dilakukan menggunakan `Future.wait()` untuk menjalankan dua permintaan API secara bersamaan.

Setelah data pengguna dan data pengajuan diterima, aplikasi membuat pemetaan ID pengguna dengan nama pengguna. Selanjutnya, data pengajuan dicocokkan menggunakan `userId` sehingga setiap pengajuan dapat menampilkan nama pemohonnya.

Pada tampilan aplikasi, beberapa nama, judul, dan deskripsi menggunakan data contoh berbahasa Indonesia yang dipetakan berdasarkan ID untuk menyesuaikan konteks SiRuang Kampus.

**Identitas penggabungan:** `DataUser.id` dengan `DataPengajuan.userId`.

## 6. Diagram Alur Request dan Response

```text
          Aplikasi Flutter
                 |
                 v
          IntegrasiService
                 |
          +------+------+
          |             |
          v             v
      GET /users     GET /posts
          |             |
          v             v
      DataUser      DataPengajuan
          |             |
          +------+------+
                 |
                 v
       Pencocokan userId
                 |
                 v
       Penggabungan Data
                 |
                 v
        Tampilan Flutter
```

## 7. Penanganan Kondisi Aplikasi

Aplikasi menyediakan beberapa kondisi tampilan:

1. **Loading:** Menampilkan indikator ketika data sedang diambil.
2. **Success:** Menampilkan daftar pengajuan setelah data berhasil diterima.
3. **Empty:** Menampilkan informasi ketika data tidak tersedia.
4. **Error:** Menampilkan pesan apabila terjadi kegagalan pengambilan data.
5. **Retry:** Menyediakan tombol untuk mencoba mengambil data kembali.

Service juga menerapkan pengecekan status HTTP, `try-catch`, dan timeout selama 15 detik.

## 8. Struktur Folder

```text
230660221010-DedeDianPermana/
├── lib/
│   ├── main.dart
│   ├── models/
│   │   ├── data_user.dart
│   │   └── data_pengajuan.dart
│   └── services/
│       └── integrasi_service.dart
├── pubspec.yaml
├── README.md
└── refleksi.md
```

## 9. Cara Menjalankan Aplikasi

1. Pastikan Flutter SDK sudah terpasang.
2. Pastikan dependensi `http` sudah tercantum pada `pubspec.yaml`.
3. Jalankan perintah `flutter pub get` pada lingkungan pengembangan.
4. Jalankan aplikasi menggunakan `flutter run`.
5. Pastikan perangkat terhubung dengan internet agar aplikasi dapat mengakses API.

## 10. Keterbatasan API Simulasi

JSONPlaceholder merupakan layanan API simulasi sehingga data yang diterima bukan data peminjaman ruang kampus yang sebenarnya.

Data pengguna dan pengajuan hanya digunakan untuk menguji proses pengambilan, pemetaan, dan penggabungan data. Oleh karena itu, aplikasi ini belum terhubung dengan database resmi SiRuang Kampus dan belum menyimpan pengajuan secara permanen.