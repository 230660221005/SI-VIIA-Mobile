# Refleksi Pengerjaan — Tugas 11

1. **Alasan teknis pemilihan fitur perangkat:**
   Saya memilih fitur kamera dan galeri menggunakan package `image_picker` pada aplikasi SI Perpustakaan Kampus karena mahasiswa membutuhkan cara cepat untuk melampirkan foto kondisi fisik buku atau kartu tanda mahasiswa sebagai bukti validasi sebelum pengajuan peminjaman diproses. Penggunaan `readAsBytes()` juga dipilih agar gambar dapat ditampilkan dengan `Image.memory` secara konsisten baik di Flutter Web maupun perangkat mobile.

2. **Kesulitan konfigurasi dan penanganan lifecycle yang ditemui:**
   Tantangan utama adalah membedakan nilai kembalian `null` saat pengguna menekan tombol batal dengan `PlatformException` ketika izin kamera ditolak oleh browser, serta memastikan pembatalan tidak menghapus foto lampiran yang sebelumnya sudah dipilih pengguna. Hal ini diatasi dengan memisahkan pengecekan `fileTerpilih == null` di `LampiranFotoService` sebelum memperbarui state UI.

## Deklarasi Penggunaan AI
Deklarasi penggunaan AI: Gemini — digunakan untuk membantu merancang pemisahan `LampiranFotoService` dan penanganan `PlatformException` pada `image_picker`; konfigurasi kode, skenario pengujian pada Chrome, dan verifikasi alur dilakukan oleh penulis.