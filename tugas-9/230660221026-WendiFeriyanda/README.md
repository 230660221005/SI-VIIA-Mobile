# Tugas 9 — Implementasi Konsumsi REST API SI RAKUS

## Identitas

- **Nama:** Wendi Feriyanda
- **NIM:** 230660221026
- **Program Studi:** Sistem Informasi
- **Kelas:** SI-VIIA
- **Mata Kuliah:** Pemrograman Aplikasi Bergerak


## 1. Deskripsi

Tugas ini mengimplementasikan konsumsi REST API pada aplikasi SI RAKUS (Sistem Rak Kampus). Aplikasi menggunakan Flutter dan Dart untuk mengambil data buku melalui HTTP `GET`, mengirim data buku contoh melalui HTTP `POST`, mengubah response JSON menjadi objek `DataBuku`, serta menampilkan kondisi loading, sukses, dan error.

API yang digunakan merupakan **API simulasi untuk praktikum**, bukan backend resmi perpustakaan dan bukan integrasi dengan Libsys. Form pengiriman buku hanya digunakan untuk menguji operasi `POST`; form tersebut bukan fitur pengelolaan koleksi bagi mahasiswa dan tidak mengubah katalog resmi perpustakaan.

## 2. Struktur Berkas

```text
tugas-9/
├── README.md
├── service-api.dart
├── halaman-api.dart
├── screenshot-loading.png
├── screenshot-sukses.png
├── screenshot-error.png
└── catatan-integrasi-api.md
```

## 3. Teknologi dan Dependency

- Flutter dan Dart
- Package `http` untuk mengirim HTTP request
- `dart:convert` untuk `jsonDecode` dan `jsonEncode`
- REST API simulasi: `https://api.restful-api.dev/objects`

Tambahkan package berikut pada bagian `dependencies` di `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  http: ^1.2.0
```

Kemudian jalankan:

```bash
flutter pub get
```

## 4. Cara Menjalankan

1. Letakkan `service-api.dart` dan `halaman-api.dart` di dalam folder `lib/` proyek Flutter.
2. Pastikan `main.dart` mengimpor `halaman-api.dart` dan menjadikan `HalamanApi` sebagai halaman utama.
3. Pastikan dependency `http` sudah terpasang dengan menjalankan `flutter pub get`.
4. Jalankan aplikasi pada Chrome:

```bash
flutter run -d chrome
```

## 5. Fitur yang Diimplementasikan

| Fitur | Implementasi |
|---|---|
| Model data | `DataBuku` dengan field `id`, `judul`, `penulis`, `penerbit`, `tahunTerbit`, `kategori`, `ringkasan`, dan `stok` |
| Parsing JSON | Factory constructor `DataBuku.fromJson()` |
| Serialisasi JSON | Method `DataBuku.toApiJson()` |
| GET | `BukuApiService.ambilKatalog()` mengambil daftar objek dari endpoint dan menyaring objek bertanda `jenisData: buku` |
| POST | `BukuApiService.kirimBuku()` mengirim data buku contoh dalam format JSON |
| Error handling | Pemeriksaan status code, `try-catch`, `FormatException`, dan timeout 10 detik |
| Loading | Indikator `CircularProgressIndicator` ketika katalog sedang dimuat |
| Sukses | Daftar katalog ditampilkan menggunakan `ListView.builder` |
| Error | Pesan kegagalan dan tombol **Coba Lagi** |
| Pengiriman data | Form buku simulasi dan indikator tombol ketika proses POST berlangsung |

## 6. Bukti Eksekusi

Simpan tangkapan layar hasil pengujian aktual dengan nama berikut:

| Berkas | Bukti yang perlu ditampilkan |
|---|---|
| `screenshot-loading.png` | Indikator loading ketika aplikasi sedang mengambil katalog |
| `screenshot-sukses.png` | Daftar data buku simulasi yang berhasil ditampilkan |
| `screenshot-error.png` | Pesan error pada aplikasi dan tombol **Coba Lagi** ketika request gagal |

Screenshot harus diambil dari aplikasi yang benar-benar dijalankan. Jangan menggunakan ilustrasi atau tampilan contoh sebagai bukti eksekusi.

## 7. Batasan Implementasi

1. Aplikasi menggunakan endpoint simulasi publik, bukan endpoint milik perpustakaan kampus.
2. Data yang diambil melalui `GET` disaring berdasarkan atribut `data.jenisData` bernilai `buku`.
3. Data yang dikirim melalui `POST` merupakan data latihan. ID dibuat oleh server simulasi dan tidak dikirim dari form.
4. Data pada API simulasi tidak boleh dianggap sebagai data katalog resmi, data stok aktual, atau data transaksi peminjaman perpustakaan.
5. Integrasi dengan Libsys, autentikasi pengguna, dan pengelolaan katalog resmi tidak termasuk implementasi tugas ini.

## 8. Refleksi

Bagian yang paling menantang bagi saya adalah memahami proses asynchronous menggunakan `Future`, `async`, dan `await`, karena request HTTP membutuhkan waktu dan antarmuka harus tetap responsif. Saya juga perlu memahami parsing JSON karena struktur response API simulasi menggunakan key `id`, `name`, dan `data`, sehingga pemetaannya berbeda dari nama field pada model `DataBuku`. Penanganan error melalui `try-catch`, pemeriksaan status code, dan timeout membantu aplikasi memberikan informasi ketika request gagal.

> Refleksi di atas merupakan contoh berdasarkan struktur implementasi. Sesuaikan dengan bagian yang benar-benar paling sulit kamu pahami selama mengerjakan dan menguji aplikasi.

## 9. Deklarasi Penggunaan AI

ChatGPT digunakan sebagai coding assistant untuk membantu menjelaskan konsep REST API, pemisahan service layer, pemetaan JSON ke model `DataBuku`, serta penyusunan dokumentasi. Kode dan hasil pengujian tetap perlu diperiksa dan diverifikasi oleh penulis sebelum dikumpulkan.
