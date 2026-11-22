# Catatan Integrasi API — Tugas 9 SI RAKUS

## 1. Gambaran Integrasi

Tugas 9 menghubungkan aplikasi Flutter SI RAKUS dengan REST API simulasi. Lapisan service ditempatkan pada `service-api.dart`, sedangkan pengelolaan tampilan dan interaksi pengguna berada pada `halaman-api.dart`.

**Catatan ruang lingkup:** endpoint yang digunakan adalah API simulasi publik untuk praktikum. Integrasi ini bukan koneksi ke Libsys atau database resmi perpustakaan. Operasi POST hanya mengirim data buku contoh untuk membuktikan proses pengiriman data melalui REST API.

## 2. Endpoint yang Digunakan

Base URL:

```text
https://api.restful-api.dev/objects
```

| Operasi | Metode HTTP | URL Endpoint | Payload Request |
|---|---|---|---|
| Mengambil daftar objek | GET | `https://api.restful-api.dev/objects` | Tidak ada body request |
| Mengirim objek buku contoh | POST | `https://api.restful-api.dev/objects` | JSON dengan key `name` dan `data` |

### 2.1 GET — Mengambil Daftar Buku

Method yang digunakan:

```dart
Future<List<DataBuku>> ambilKatalog() async
```

Alur proses:

1. Service mengirim request `http.get()` ke base URL.
2. Request diberi batas waktu 10 detik menggunakan `timeout()`.
3. Service memeriksa apakah status HTTP bernilai `200`.
4. Response body diubah dari JSON menjadi objek Dart menggunakan `jsonDecode()`.
5. Service memeriksa bahwa response berbentuk daftar (`List`).
6. Setiap item diperiksa dan hanya objek dengan `data.jenisData == 'buku'` yang dipetakan ke `DataBuku`.
7. Hasil dikembalikan sebagai `List<DataBuku>` untuk ditampilkan oleh halaman.

GET mengembalikan daftar objek pada layanan simulasi. Oleh karena itu, service melakukan penyaringan berdasarkan penanda `jenisData` agar hanya objek latihan buku SI RAKUS yang ditampilkan.

### 2.2 POST — Mengirim Data Buku Contoh

Method yang digunakan:

```dart
Future<DataBuku> kirimBuku(DataBuku buku) async
```

Header request:

```http
Content-Type: application/json; charset=UTF-8
```

Contoh payload yang dibentuk oleh `toApiJson()`:

```json
{
  "name": "Dasar-Dasar Pemrograman",
  "data": {
    "jenisData": "buku",
    "penulis": "Andi Pratama",
    "penerbit": "Pustaka Kampus",
    "tahunTerbit": 2023,
    "kategori": "Informatika",
    "ringkasan": "Pengenalan algoritma dan pemrograman.",
    "stok": 3
  }
}
```

Alur proses:

1. Pengguna mengisi form simulasi kirim data buku.
2. Form melakukan validasi sederhana, termasuk memastikan tahun dan stok berupa bilangan yang sesuai.
3. Halaman membentuk objek `DataBuku` dan meneruskannya ke service.
4. Service mengubah objek menjadi JSON menggunakan `jsonEncode(buku.toApiJson())`.
5. Service mengirim request `http.post()` dengan header `Content-Type: application/json; charset=UTF-8`.
6. Service menerima status HTTP `200` atau `201` sebagai response sukses sesuai pemeriksaan pada kode.
7. Response JSON dipetakan menjadi `DataBuku`. ID yang dikembalikan server digunakan pada objek hasil POST.

ID tidak dimasukkan ke payload POST karena ID objek baru dibuat oleh layanan simulasi.

## 3. Struktur Model Data

Model `DataBuku` mempertahankan field yang digunakan pada Tugas 7. Pemetaan key response API disesuaikan dengan struktur `id`, `name`, dan `data` dari endpoint simulasi.

| Field Model | Tipe Dart | Key/Path JSON | Sumber Nilai |
|---|---|---|---|
| `id` | `String` | `id` | Dibuat oleh server; dikonversi ke String |
| `judul` | `String` | `name` | Payload/response API |
| `penulis` | `String` | `data.penulis` | Payload/response API |
| `penerbit` | `String` | `data.penerbit` | Payload/response API |
| `tahunTerbit` | `int` | `data.tahunTerbit` | Payload/response API |
| `kategori` | `String` | `data.kategori` | Payload/response API |
| `ringkasan` | `String` | `data.ringkasan` | Payload/response API |
| `stok` | `int` | `data.stok` | Payload/response API |
| `status` | `String` (getter) | Tidak disimpan di JSON | Dihitung dari `stok`: lebih dari 0 = `Tersedia`, selain itu = `Stok habis` |

### 3.1 Contoh Bentuk Response JSON

Response item dari layanan simulasi diharapkan memiliki bentuk berikut:

```json
{
  "id": "id-dari-server",
  "name": "Dasar-Dasar Pemrograman",
  "data": {
    "jenisData": "buku",
    "penulis": "Andi Pratama",
    "penerbit": "Pustaka Kampus",
    "tahunTerbit": 2023,
    "kategori": "Informatika",
    "ringkasan": "Pengenalan algoritma dan pemrograman.",
    "stok": 3
  }
}
```

`fromJson()` membaca `id` dan `name` dari tingkat teratas, lalu membaca atribut buku dari objek `data`. Nilai yang tidak tersedia diberi nilai bawaan agar proses pemetaan tidak langsung gagal karena nilai null. Struktur JSON aktual tetap perlu diperiksa melalui response saat aplikasi diuji.

## 4. Pemisahan Tanggung Jawab

| Berkas/Kelas | Tanggung Jawab |
|---|---|
| `DataBuku` | Menyimpan atribut buku serta menyediakan `fromJson()` dan `toApiJson()` |
| `BukuApiService` | Mengirim GET dan POST, memeriksa status response, parsing JSON, serta menangani kegagalan komunikasi |
| `HalamanApi` | Mengelola state loading, data, error, retry, refresh, dan proses pengiriman form |
| `FormBukuApiDialog` | Mengumpulkan dan memvalidasi input buku contoh sebelum dikirim |

Pemisahan ini membuat widget antarmuka tidak menulis request HTTP secara langsung di dalam method `build()`.

## 5. Penanganan Error

Penanganan error diterapkan di dalam method GET dan POST pada class `BukuApiService`.

| Kondisi | Penanganan pada kode |
|---|---|
| HTTP GET sukses | Status harus `200`; response kemudian diparsing |
| HTTP POST sukses | Status harus `200` atau `201`; response kemudian diparsing |
| Status HTTP selain yang diharapkan | Service melempar `Exception` berisi kode status |
| Waktu request melewati 10 detik | `TimeoutException` ditangani dan diubah menjadi pesan yang dapat dibaca pengguna |
| Bentuk JSON tidak sesuai | `FormatException` ditangani dengan pesan format response tidak valid |
| Kesalahan lain saat request | Ditangkap oleh `catch` umum dan diteruskan sebagai pesan kegagalan |

Pada sisi antarmuka:

- **Loading:** `_sedangMemuat` bernilai `true`, kemudian halaman menampilkan `CircularProgressIndicator`.
- **Sukses:** daftar `DataBuku` ditampilkan menggunakan `ListView.builder`.
- **Error:** `_pesanError` berisi informasi kegagalan dan halaman menampilkan tombol **Coba Lagi** yang memanggil `_muatKatalog()`.
- **POST sedang berlangsung:** `_sedangMengirim` digunakan untuk menonaktifkan tombol kirim utama dan menampilkan indikator proses.

## 6. Catatan Pengujian

Lakukan pengujian aktual pada Flutter Web dengan perintah:

```bash
flutter pub get
flutter run -d chrome
```

| Skenario | Langkah Pengujian | Bukti |
|---|---|---|
| Loading | Buka aplikasi dan tangkap layar ketika request GET sedang berlangsung | `screenshot-loading.png` |
| Sukses | Tunggu sampai GET selesai dan daftar buku simulasi muncul; bila daftar kosong, kirim satu data buku melalui form POST lalu muat ulang katalog | `screenshot-sukses.png` |
| Error | Untuk pengujian sementara, ubah URL menjadi endpoint yang tidak valid, jalankan ulang, dan tangkap pesan error beserta tombol Coba Lagi | `screenshot-error.png` |
| POST | Isi form buku contoh dan tekan tombol kirim; periksa pesan sukses dan ID yang dikembalikan server | Dapat ditambahkan sebagai bukti pendukung |

Setelah pengujian error, kembalikan URL ke endpoint yang benar sebelum menyimpan kode final:

```dart
static final Uri _url = Uri.parse(
  'https://api.restful-api.dev/objects',
);
```

Screenshot hanya boleh dinyatakan tersedia setelah benar-benar diambil dari aplikasi yang dijalankan.

## 7. Batasan dan Catatan Integrasi

1. API yang digunakan adalah endpoint simulasi publik untuk latihan REST API.
2. Implementasi ini belum terhubung ke Libsys atau database perpustakaan kampus.
3. Data yang dikirim melalui POST adalah data contoh, bukan perubahan katalog resmi.
4. Tidak ada autentikasi atau otorisasi petugas/mahasiswa pada latihan ini.
5. Data dari GET disaring menggunakan `data.jenisData == 'buku'`; objek lain dari layanan simulasi tidak ditampilkan.
6. Keberhasilan request ke layanan simulasi tidak membuktikan bahwa integrasi dengan sistem perpustakaan telah tersedia.
