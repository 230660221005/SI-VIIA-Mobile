# Jawaban Quiz Pertemuan 12 — Validasi dan Keamanan Praktis

- **Nama:** Tira Azzahra
- **NIM:** 230660221021
- **Kelas:** SI-VIIA
- **Domain Project:** SI Perpustakaan Kampus (Pengajuan Peminjaman Buku)

## Soal 1 — Validasi Client dan Server
Validasi client dijalankan di aplikasi Flutter untuk memberikan umpan balik instan kepada pengguna dan mencegah pengiriman request yang jelas salah (seperti NIM kosong atau durasi pinjam di luar 1–14 hari). Sementara itu, validasi server adalah pemeriksaan otoritatif di backend sebelum data disimpan ke database. Validasi form Flutter tidak cukup melindungi aturan bisnis karena aplikasi client berjalan di perangkat pengguna yang dapat dimodifikasi, direkayasa balik, atau dilewati dengan mengirim request langsung ke API menggunakan alat seperti Postman atau cURL.

## Soal 2 — HTTPS dan Token
Mengirimkan token melalui protokol `http://` (tanpa enkripsi TLS) membuat seluruh header dan isi request dikirim dalam bentuk teks biasa (*plaintext*). Risikonya adalah serangan *Man-in-the-Middle (MitM)* di mana pihak ketiga pada jaringan Wi-Fi publik dapat menyadap lalu lintas jaringan, mencuri token sesi mahasiswa, dan membajak akun peminjaman buku. Perbaikannya adalah mewajibkan penggunaan `https://` dengan sertifikat TLS yang valid, menolak URL `http://` pada service layer, serta tidak pernah menaruh token di parameter URL (query string).

## Soal 3 — Secure Storage
Token autentikasi tidak boleh ditulis di dalam source code karena siapa pun yang melihat repositori GitHub atau membongkar paket aplikasi dapat menyalahgunakannya, dan tidak boleh dicetak di log karena log perangkat dapat dibaca oleh proses debugging atau layanan crash reporting pihak ketiga. Token harus disimpan di penyimpanan terenkripsi bawaan sistem operasi (seperti Keystore pada Android dan Keychain pada iOS melalui `flutter_secure_storage`). Saat pengguna melakukan **logout**, aplikasi wajib memanggil method penghapusan token (`delete`) dari storage serta membersihkan state sesi di memori agar token lama tidak dapat dipakai kembali.

## Soal 4 — Permission
Meminta permission kamera saat aplikasi pertama kali dibuka melanggar prinsip **least privilege** dan menurunkan kepercayaan pengguna karena pengguna belum melihat konteks fitur yang membutuhkan kamera, sehingga cenderung menolaknya secara permanen. Alur yang lebih tepat adalah meminta izin secara *just-in-time* (kontekstual): jelaskan terlebih dahulu manfaatnya pada kartu lampiran foto kondisi buku, lalu panggil permission kamera hanya ketika pengguna menekan tombol **Ambil Kamera**, serta sediakan penanganan informatif jika izin ditolak.

## Soal 5 — Security Checklist
1. **Validasi input wajib dan format dasar pada client** — *Bukti:* File `lib/validators/pengajuan_validator.dart` dan hasil pengujian input invalid pada form Flutter.
2. **Penggunaan protokol HTTPS untuk seluruh komunikasi API** — *Bukti:* Pengecekan skema `https` pada `KeamananPerpustakaanService.isEndpointAman()`.
3. **Tidak ada token atau kredensial hardcoded di source code** — *Bukti:* Hasil inspeksi berkas kode di direktori `lib/` sebelum commit ke GitHub.
4. **Penghapusan token saat pengguna logout** — *Bukti:* Implementasi method `logout()` pada `KeamananPerpustakaanService` dan uji tombol **Logout** pada UI.
5. **Penerapan prinsip least privilege pada permission perangkat** — *Bukti:* Konfigurasi `pubspec.yaml` dan dokumentasi permission pada `README.md` yang hanya memakai izin sesuai kebutuhan fitur.