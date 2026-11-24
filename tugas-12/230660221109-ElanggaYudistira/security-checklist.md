# Security Checklist — Tugas 12

| No. | Risiko atau pemeriksaan | Status | Bukti |
|:---:|:------------------------|:------:|:------|
| 1 | Input wajib divalidasi | Selesai | lib/services/validation_service.dart dan validator Form di lib/main.dart |
| 2 | Format input diperiksa | Selesai | Validator email, nominal, tanggal, ekstensi file, dan ukuran file |
| 3 | HTTPS digunakan untuk data sensitif | Sebagian | README menjelaskan target API produksi wajib HTTPS; MVP ini belum mengirim data ke backend |
| 4 | Token tidak ditulis pada source code | Selesai | Pemeriksaan source code tidak menemukan token atau password |
| 5 | Token tidak dicetak pada log | Selesai | Tidak ada print atau log yang mencetak kredensial |
| 6 | Token dihapus saat logout | Sebagian | MVP belum memiliki autentikasi, sehingga tidak menyimpan token; logout backend perlu menghapus secure storage pada tahap berikutnya |
| 7 | Permission sesuai fitur | Selesai | ImagePicker dipanggil ketika pengguna menekan Pilih Bukti Transaksi |
| 8 | Permission ditolak ditangani | Selesai | Error pemilihan file ditampilkan sebagai pesan permission atau fitur tidak tersedia |
| 9 | Pesan error tidak membocorkan data | Selesai | UI menampilkan pesan umum dan tidak menampilkan path internal atau isi credential |
| 10 | Dependency dan batasan didokumentasikan | Selesai | README mencantumkan image_picker, target, konfigurasi, dan batasan pengujian |

## Pemeriksaan tambahan

- Tidak ada token, password, API key, atau data pribadi pada source code.
- File dibatasi ke JPG, JPEG, PNG, dan WEBP.
- Ukuran bukti dibatasi maksimal 5 MB.
- Validasi server tetap diperlukan sebelum transaksi disimpan permanen.
