# CATATAN INTEGRASI REST API SIAngkut

## 1. Deskripsi Integrasi API

Pada aplikasi SIAngkut, REST API digunakan untuk mengambil dan mengirim data laporan menggunakan metode HTTP GET dan POST.

API yang digunakan adalah JSONPlaceholder sebagai layanan simulasi untuk pengujian integrasi API pada aplikasi Flutter.

## 2. Endpoint API

| Fitur | URL | HTTP Method |
|---|---|---|
| Mengambil data laporan | https://jsonplaceholder.typicode.com/posts?_limit=10 | GET |
| Mengirim laporan | https://jsonplaceholder.typicode.com/posts | POST |

### Request POST

Data yang dikirim menggunakan format JSON:

```json
{
  "title": "Sampah Belum Diangkut",
  "body": "Sampah di wilayah Tanggulun belum diangkut sesuai jadwal.",
  "userId": 1
}
```

### Response POST

Jika berhasil, API memberikan status HTTP 201 Created beserta data respons yang mencakup ID, userId, title, dan body.

## 3. Struktur Model Data

Aplikasi menggunakan class `LaporanApi` untuk menampung data dari API.

Model memiliki empat atribut:

- `id`: Nomor identitas data laporan.
- `userId`: Identitas pengguna.
- `title`: Judul laporan.
- `body`: Isi atau keterangan laporan.

Method `fromJson()` digunakan untuk mengubah data JSON menjadi objek Dart agar dapat ditampilkan pada halaman aplikasi.

## 4. Service API

Class `ServiceApi` digunakan untuk memisahkan proses komunikasi dengan REST API dari tampilan aplikasi.

Terdapat dua method utama:

- `getLaporan()`: Mengambil maksimal 10 data menggunakan metode GET.
- `kirimLaporan()`: Mengirim data laporan menggunakan metode POST.

Komunikasi API menggunakan package `http`.

## 5. Penanganan Kondisi Aplikasi

Aplikasi memiliki tiga kondisi utama saat mengambil data:

1. **Loading:** Menampilkan indikator loading dan tulisan sedang mengambil data.
2. **Success:** Menampilkan daftar data yang berhasil diterima dari API.
3. **Error:** Menampilkan pesan kesalahan dan tombol Coba Lagi apabila pengambilan data gagal.

Selain itu, aplikasi menggunakan try-catch untuk menangani kesalahan, pemeriksaan status HTTP untuk mengetahui keberhasilan permintaan, serta timeout selama 15 detik agar permintaan tidak menunggu terlalu lama.

## 6. Hasil Pengujian

Berdasarkan pengujian yang dilakukan:

- GET berhasil mengambil dan menampilkan 10 data dari JSONPlaceholder.
- POST berhasil mengirim laporan dan menerima respons berhasil dari API.
- Loading berhasil ditampilkan ketika proses pengambilan data berlangsung.
- Error berhasil ditampilkan ketika URL API dibuat salah.
- Tombol Coba Lagi tersedia untuk mengulangi proses pengambilan data.

## 7. Catatan

JSONPlaceholder merupakan API simulasi. Data yang dikirim menggunakan POST hanya menghasilkan respons simulasi dan tidak disimpan secara permanen di server.

Dengan integrasi ini, aplikasi SIAngkut telah menerapkan dasar komunikasi REST API menggunakan Flutter.