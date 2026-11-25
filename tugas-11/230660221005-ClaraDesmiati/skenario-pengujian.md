# Skenario Pengujian Fitur Perangkat – SIAngkut

## 1. Identitas Pengujian

- **Nama Aplikasi:** SIAngkut
- **Fitur yang Diuji:** Pemilihan foto dari galeri
- **Package:** `image_picker`
- **Halaman:** Buat Laporan Pengangkutan
- **Penguji:** Clara Desmiati

## 2. Tujuan Pengujian

Pengujian dilakukan untuk memastikan fitur pemilihan foto dari galeri dapat berjalan sesuai kebutuhan aplikasi SIAngkut. Pengujian juga bertujuan memastikan aplikasi mampu menangani pembatalan, penolakan izin, dan kesalahan ketika proses pemilihan foto berlangsung.

## 3. Skenario Pengujian

| No. | Skenario | Langkah Pengujian | Hasil yang Diharapkan | Hasil Aktual |
|---|---|---|---|---|
| 1 | Berhasil memilih foto | Membuka form laporan, menekan tombol Pilih Foto dari Galeri, kemudian memilih gambar | Foto berhasil dipilih, pratinjau muncul, dan nama file ditampilkan | Belum diuji langsung |
| 2 | Pengguna membatalkan | Membuka pemilih foto kemudian menekan tombol batal | Aplikasi tidak mengalami crash, foto sebelumnya tetap dipertahankan jika tersedia | Belum diuji langsung |
| 3 | Permission ditolak | Menguji akses galeri pada perangkat native dan menolak izin jika permintaan izin muncul | Aplikasi memberikan informasi bahwa akses foto ditolak | Belum diuji pada perangkat native |
| 4 | Kesalahan plugin atau perangkat | Menguji kondisi ketika plugin mengalami kegagalan atau perangkat tidak dapat mengakses fitur | Aplikasi menampilkan pesan kesalahan dan tidak mengalami crash | Belum diuji langsung |

## 4. Pengujian Pemeriksaan Kode

Pemeriksaan kode dilakukan menggunakan perintah:

```bash
flutter analyze
```

Hasil pemeriksaan:

```text
No issues found!
```

Hasil tersebut menunjukkan bahwa tidak ditemukan masalah pada kode yang diperiksa oleh Flutter Analyzer. Namun, pemeriksaan ini tidak membuktikan bahwa seluruh skenario fitur perangkat sudah berhasil dijalankan.

## 5. Evaluasi Hasil Pengujian

Berdasarkan pemeriksaan kode, implementasi telah lolos pemeriksaan Flutter Analyzer. Sementara itu, pengujian fungsional perlu dilakukan untuk memastikan setiap kondisi berjalan sesuai hasil yang diharapkan.

Pengujian melalui Chrome dapat digunakan untuk memeriksa pemilihan file melalui browser. Pengujian permission native perlu dilakukan pada perangkat Android atau iOS yang sesuai.

## 6. Kesimpulan

Pengujian fitur perangkat SIAngkut dirancang menggunakan empat skenario, yaitu pemilihan foto berhasil, pembatalan pemilihan, penolakan permission, dan kesalahan plugin atau perangkat.

Setiap hasil aktual dicatat berdasarkan pengujian yang benar-benar dilakukan. Dengan demikian, hasil pengujian dapat digunakan untuk mengetahui kondisi fitur dan bagian yang masih perlu diperbaiki.