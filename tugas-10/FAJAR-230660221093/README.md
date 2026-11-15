# Tugas 10 — Integrasi Data dan Proses Bisnis

| | |
|:--|:--|
| **Nama** | Fajar |
| **NIM** | 230660221093 |
| **Kelas** | SI-VIIA |
| **Domain** | Usaha mikro jasa — Glazent.pro (glass cleaning & nanocoating) |

---

## 1. Deskripsi Singkat

Tugas ini melanjutkan Tugas 9. Halaman "Pesanan Glazent.pro" menampilkan satu daftar pesanan yang disusun dari **tiga endpoint**: pesanan, pelanggan, dan progres pekerjaan teknisi. Ketiganya diambil bersamaan dengan `Future.wait`, digabungkan berdasarkan identifier, lalu status proses setiap pesanan (`menunggu`, `dijadwalkan`, `selesai`) ditentukan oleh aturan pada service. Halaman membedakan empat kondisi: loading, sukses, kosong, dan error (dengan tombol "Coba Lagi").

Kaitan dengan kebutuhan Tugas 4: F-02 (pelanggan melihat status pesanan) dan F-06 (teknisi menandai pekerjaan selesai, yang di sini dibaca dari data progres).

## 2. Struktur Proyek

```text
tugas-10/<nim>-<nama>/
├── lib/
│   ├── main.dart                         # halaman dan widget (tanpa HTTP/parsing)
│   ├── models/
│   │   ├── data_pelanggan.dart           # model /users
│   │   ├── data_pesanan.dart             # model /posts
│   │   ├── data_progres.dart             # model /todos
│   │   └── pesanan_ringkas.dart          # model tampilan + enum StatusPesanan
│   └── services/
│       └── integrasi_service.dart        # request, parsing, penggabungan, aturan status
├── pubspec.yaml
├── README.md
├── diagram-integrasi.md
├── diagram-integrasi.png
└── refleksi.md
```

## 3. Endpoint yang Digunakan

API simulasi publik `https://jsonplaceholder.typicode.com`.

| Data | Metode | Endpoint | Model Dart |
|:-----|:-------|:---------|:-----------|
| Pelanggan | GET | `/users` | `DataPelanggan` |
| Pesanan | GET | `/posts?_limit=20` | `DataPesanan` |
| Progres pekerjaan teknisi | GET | `/todos?_limit=12` | `DataProgres` |

Setiap request memakai `package:http`, memeriksa status code, dibatasi `timeout` 10 detik, dan dibungkus `try-catch`. Service mengembalikan model Dart, bukan JSON mentah.

## 4. Pemetaan Field JSON ke Model Dart

**`DataPelanggan`** — dari `/users`

| Field Dart | Tipe | Key JSON | Nilai Default |
|:-----------|:-----|:---------|:--------------|
| `id` | `int` | `id` | `0` |
| `nama` | `String` | `name` | `'Tanpa Nama'` |
| `kota` | `String` | `address.city` (bersarang) | `'-'` |

**`DataPesanan`** — dari `/posts`

| Field Dart | Tipe | Key JSON | Nilai Default |
|:-----------|:-----|:---------|:--------------|
| `id` | `int` | `id` | `0` |
| `userId` | `int` | `userId` | `0` |
| `layanan` | `String` | `title` | `'Tanpa Nama Layanan'` |

Field `body` pada `/posts` tidak dipakai karena tidak dibutuhkan proses bisnis.

**`DataProgres`** — dari `/todos`

| Field Dart | Tipe | Key JSON | Nilai Default |
|:-----------|:-----|:---------|:--------------|
| `id` | `int` | `id` | `0` |
| `selesai` | `bool` | `completed` | `false` |

**`PesananRingkas`** (model tampilan, hasil gabungan)

| Field Dart | Sumber |
|:-----------|:-------|
| `id`, `layanan` | `DataPesanan` |
| `namaPelanggan`, `kota` | `DataPelanggan` (via `userId`); bila tidak ditemukan: `'Pelanggan tidak dikenal'` dan `'-'` |
| `status` | hasil `tentukanStatus` dari `DataProgres` (via `id`) |

## 5. Identifier Penghubung

| Penghubung | Arti |
|:-----------|:-----|
| `DataPesanan.userId` = `DataPelanggan.id` | Menentukan siapa pelanggan pemesan |
| `DataPesanan.id` = `DataProgres.id` | Menentukan progres milik pesanan yang mana |

Penggabungan memakai `Map` berdasarkan identifier (`pelangganById`, `progresById`), sehingga pencarian tidak bergantung pada urutan data.

## 6. Aturan Proses Bisnis

Aturan status berada pada satu tempat, yaitu `IntegrasiService.tentukanStatus`:

| Kondisi | Status |
|:--------|:-------|
| Tidak ada catatan progres untuk pesanan tersebut | `menunggu` |
| Ada catatan progres, `completed = false` | `dijadwalkan` |
| Ada catatan progres, `completed = true` | `selesai` |

Request progres dibatasi 12 data, sehingga pesanan nomor 13–20 tidak memiliki catatan progres dan berstatus `menunggu`.

## 7. Alasan Penggunaan `Future.wait`

Ketiga request tidak saling bergantung: tidak ada request yang membutuhkan hasil request lain sebagai masukan (alamat endpoint tidak dibentuk dari data hasil request sebelumnya). Karena itu ketiganya dijalankan bersamaan, sehingga waktu tunggu mengikuti request yang paling lambat, bukan jumlah ketiganya. Request akan dijalankan berurutan bila request kedua membutuhkan identifier dari hasil request pertama.

Konsekuensinya, `Future.wait` gagal bila salah satu request gagal. Service menerjemahkan setiap kegagalan menjadi `ApiException` yang menyebutkan data yang gagal (mis. "data pelanggan"), sehingga halaman menampilkan pesan yang sesuai.

## 8. Diagram Alur Request dan Response

![Diagram alur request dan response](diagram-integrasi.png)

Diagram lengkap (alur request-response, penggabungan data, dan aturan status) ada pada [`diagram-integrasi.md`](diagram-integrasi.md).

## 9. Penanganan Kondisi Halaman

| Kondisi | Penyebab | Tampilan |
|:--------|:---------|:---------|
| Loading | Request sedang berjalan | `CircularProgressIndicator` |
| Sukses | Request berhasil dan daftar berisi data | Ringkasan jumlah per status dan daftar pesanan |
| Kosong | Request berhasil, daftar pesanan kosong | Ikon, teks "Belum ada pesanan", tombol "Muat Ulang" |
| Error | Salah satu request gagal | Pesan yang menyebutkan data yang gagal dan tombol "Coba Lagi" |

Kondisi kosong dibedakan dari error karena maknanya berbeda: kosong berarti proses berhasil tetapi belum ada data, sedangkan error berarti proses gagal dan pengguna perlu mencoba lagi. Detail teknis error tidak ditampilkan kepada pengguna; detailnya dicatat dengan `dart:developer` untuk debugging.

## 10. Cara Menjalankan

Dari folder project Flutter (target web):

```bash
flutter pub add http
```

Salin folder `lib/` dari tugas ini ke project (menimpa `lib/` yang lama), atau buat project baru dengan `flutter create glazent_integrasi` lalu salin `lib/` dan `pubspec.yaml`. Kemudian:

```bash
flutter pub get
flutter analyze
flutter run -d chrome
```

Tidak ada token atau data pribadi pada source code.

## 11. Skenario Uji

Konstanta pengujian berada pada `lib/services/integrasi_service.dart`. Kembalikan ke nilai semula setelah setiap uji.

| No. | Skenario | Cara Memicu | Hasil yang Diharapkan | Hasil Uji |
|:---:|:---------|:------------|:----------------------|:----------|
| 1 | Loading | Ubah `jedaUji` menjadi `Duration(seconds: 3)` | Indikator loading tampil sekitar 3 detik | Lulus — indikator tetap tampil sampai data selesai dimuat (diuji dengan jeda 3 detik) |
| 2 | Sukses | Jalankan normal | 20 pesanan tampil; pesanan 13–20 berstatus `menunggu`; ringkasan jumlah per status tampil | Lulus — 20 pesanan; 8 menunggu, 7 dijadwalkan, 5 selesai; id 13–20 semuanya menunggu |
| 3 | Kosong | Ubah `_filterPesananUji` menjadi `'&userId=999'` | Tampil "Belum ada pesanan" (bukan pesan error) | Lulus — userId=999 mengembalikan 0 data; tampil "Belum ada pesanan" + "Muat Ulang" |
| 4 | Error satu sumber | Ubah `'/users'` pada `ambilPelanggan` menjadi `'/userss'` | Pesan menyebutkan data pelanggan tidak ditemukan (HTTP 404) dan tombol "Coba Lagi" tampil | Lulus — HTTP 404 pada data pelanggan jadi pesan yang jelas + tombol "Coba Lagi" |
| 5 | Error koneksi | Matikan koneksi internet lalu muat ulang | Pesan "Tidak dapat terhubung ke server..." | Lulus (simulasi) — pesan "Tidak dapat terhubung ke server..." tampil |
| 6 | Coba lagi | Nyalakan koneksi, tekan "Coba Lagi" | Request diulang dan daftar tampil | Lulus — tombol memicu pemuatan ulang dan data tampil setelah percobaan kedua |

## 12. Batasan API Simulasi

- Data bukan data Glazent.pro. Judul pesanan berupa teks acak dan nama pelanggan fiktif.
- Endpoint `/todos` dipakai sebagai pengganti data progres teknisi. Aturan status pada bagian 6 hanyalah simulasi proses bisnis.
- Pada `/posts`, setiap 10 pesanan dimiliki satu pelanggan, sehingga 20 pesanan hanya memiliki dua pelanggan berbeda.
- Tugas ini hanya membaca data (GET). Membuat dan mengubah pesanan tidak dilakukan.
- Autentikasi dan perlindungan data tidak diterapkan karena dibahas pada Pertemuan 12.

## 13. Deklarasi Penggunaan AI

Deklarasi penggunaan AI: Claude (Anthropic) — membantu menyusun kerangka model, service integrasi (tiga endpoint, `Future.wait`, penggabungan, aturan status), halaman empat kondisi, diagram, dan dokumentasi berdasarkan domain Glazent.pro dari Tugas 7 dan 9; perbaikan kode, pengujian, dan penjelasan dilakukan serta diverifikasi oleh penulis.
