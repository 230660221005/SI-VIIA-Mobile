# Jawaban Quiz Pertemuan 11 — Fitur Perangkat Sesuai Kebutuhan

- **Nama:** Tira Azzahra
- **NIM:** 230660221021
- **Kelas:** SI-VIIA
- **Domain Project:** SI Perpustakaan Kampus (Pengajuan Peminjaman Buku)

## Soal 1 — Pemilihan Fitur
Fitur perangkat dipilih berdasarkan kebutuhan nyata aktor dalam alur proses bisnis dan kejelasan data keluarannya, bukan sekadar sebagai pelengkap tampilan. Pada **SI Perpustakaan Kampus**, fitur yang dipilih adalah **Kamera dan Galeri (`image_picker`)** untuk melampirkan foto kondisi fisik buku (atau kartu mahasiswa) saat mengajukan peminjaman. Alasan teknis pemilihannya adalah untuk menghasilkan bukti visual (`XFile` / `Uint8List`) guna memvalidasi kondisi buku sebelum dipinjam agar tidak terjadi perselisihan kerusakan saat pengembalian.

## Soal 2 — Permission
Fitur perangkat memerlukan permission karena mengakses perangkat keras atau data pribadi pengguna (seperti kamera dan penyimpanan media) yang dilindungi oleh sistem operasi demi privasi dan keamanan. Tiga kondisi utama yang wajib ditangani aplikasi adalah:
1. **Diminta (Requesting):** Menampilkan status loading dan menunggu respons izin dari pengguna.
2. **Ditolak (Denied):** Menangkap `PlatformException`, tidak memaksa *crash*, serta menampilkan pesan alasan mengapa fitur membutuhkan izin disertai panduan mengaktifkannya di pengaturan perangkat/browser.
3. **Tidak Tersedia (Unavailable):** Menangani kondisi ketika perangkat tidak memiliki perangkat keras terkait (misalnya desktop tanpa webcam) dengan pesan error informatif dan opsi alternatif.

## Soal 3 — Pembatalan Pemilihan
Nilai `XFile?` yang bernilai `null` pada `image_picker` menandakan bahwa **pengguna secara sadar membatalkan proses** (menekan tombol *Cancel* atau menutup kamera/galeri tanpa memilih file), sehingga kondisi tersebut **bukan merupakan error sistem**. Aplikasi harus meresponsnya dengan menghentikan indikator loading, **mempertahankan state/preview foto sebelumnya** jika sudah ada, serta cukup menampilkan notifikasi ringan bahwa pemilihan dibatalkan tanpa memunculkan layar error.

## Soal 4 — Service Layer
Service layer (`LampiranFotoService`) bertanggung jawab membungkus pemanggilan package `image_picker`, membaca `bytes` gambar, memvalidasi ukuran file, serta menerjemahkan `PlatformException` menjadi pesan domain yang terstruktur. Pemanggilan package dan pengelolaan permission tidak boleh ditulis langsung di dalam widget agar kode UI tetap bersih, mudah diuji secara terpisah (*unit test*), dan mencegah logika akses perangkat keras bercampur dengan siklus *rebuild* tampilan.

## Soal 5 — State Fitur Perangkat
State minimal yang harus ditangani halaman fitur perangkat meliputi: **idle (belum ada lampiran)**, **loading (sedang memproses perangkat)**, **berhasil**, **dibatalkan**, dan **permission ditolak / error**. Perbedaannya terletak pada respons UI:
- **Berhasil:** Menyimpan `HasilLampiranFoto` ke state dan merender preview gambar (`Image.memory`) beserta metadata file.
- **Dibatalkan:** Tidak menimpa state lampiran yang sudah ada sebelumnya dan tidak memunculkan kotak error.
- **Permission ditolak:** Menampilkan peringatan khusus akses izin dengan penjelasan cara membuka izin serta tombol **Coba Lagi** untuk memicu permintaan ulang.