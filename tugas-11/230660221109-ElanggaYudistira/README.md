# Tugas 11 — Integrasi Fitur Perangkat

## Identitas

- **Nama:** Elangga Yudistira
- **NIM:** 230660221109
- **Kelas:** SI-VIIA
- **Aplikasi:** MoneyTrack Mahasiswa

## Analisis kebutuhan fitur

Fitur yang dipilih adalah pemilihan foto bukti transaksi melalui galeri atau kamera. Aktornya adalah mahasiswa pengguna MoneyTrack, dan tujuan bisnisnya adalah melampirkan bukti ketika mencatat pengeluaran atau pemasukan agar riwayat transaksi lebih mudah diverifikasi.

Data keluaran fitur adalah objek XFile yang berisi nama file, path atau referensi platform, dan bytes yang dapat dibaca untuk preview. Service mengembalikan XFile?; nilai null berarti pengguna membatalkan pemilihan. Permission yang relevan adalah akses kamera dan akses foto atau media pada perangkat mobile. Target verifikasi utama adalah Chrome melalui Flutter Web dan Android apabila perangkat tersedia. Pada web, browser menampilkan file chooser dan permission kamera dikelola browser; pada Android atau iOS, aplikasi mengikuti permission platform.

## Dependency dan konfigurasi

Dependency yang digunakan pada pubspec.yaml adalah image_picker. Tidak ada token atau data pribadi pada source code.

Pada Android, image_picker menangani alur pemilihan media melalui plugin; permission kamera perlu diizinkan jika sumber Camera digunakan. Pada iOS, konfigurasi produksi perlu menyediakan NSPhotoLibraryUsageDescription dan NSCameraUsageDescription di Info.plist. Pada web, aplikasi menggunakan file chooser browser sehingga tidak memerlukan perubahan manifest mobile.

## Service layer

BuktiTransaksiService memisahkan ImagePicker dari widget. Method pilihBukti bersifat asynchronous, mengembalikan XFile? ketika berhasil atau dibatalkan, dan mengubah PlatformException menjadi FiturPerangkatException dengan penanda permissionDenied. Service tidak membuat atau menampilkan widget.

## Cara menjalankan

Dari proyek runnable:

    cd C:\Users\ELANG\SI-VIIA-Mobile\tugas_11_web
    flutter pub get
    flutter run -d chrome

Klik Pilih dari Galeri, pilih gambar, lalu aplikasi menampilkan preview. Tutup file chooser atau tekan Cancel untuk menguji pembatalan. Tombol Ambil Foto dengan Kamera dapat diuji pada browser atau perangkat yang menyediakan kamera.

## Skenario pengujian

| Skenario | Expected result | Actual result |
|:---------|:----------------|:--------------|
| Fitur berhasil digunakan | XFile diterima, bytes dibaca, dan preview bukti tampil | Berhasil: state success menampilkan gambar dan nama file. |
| Pengguna membatalkan aksi | Service mengembalikan null dan state sebelumnya tidak dihapus | Berhasil: state cancelled menampilkan pesan, preview lama tetap dipertahankan. |
| Permission ditolak | PlatformException dipetakan menjadi pesan permission dan tombol coba lagi tetap tersedia | Ditangani: state permissionDenied menampilkan instruksi mengaktifkan izin. |
| Package atau perangkat menghasilkan error | Error tidak membuat aplikasi berhenti dan pengguna mendapat pesan informatif | Ditangani: state error menampilkan pesan exception dan tindakan pemilihan dapat dicoba lagi. |

## Batasan pengujian

Chrome dapat menguji file chooser dan pembatalan dengan mudah, tetapi permission kamera serta perilaku background mobile perlu diverifikasi lagi pada Android atau iOS. Preview memakai bytes di memori dan belum mengunggah file ke backend; upload bukti dapat ditambahkan pada milestone REST API berikutnya.

## Deklarasi penggunaan AI

Deklarasi penggunaan AI: ChatGPT — membantu memilih fitur perangkat, menyusun service ImagePicker, state permission dan pembatalan, jawaban quiz, serta dokumentasi; kode, pengujian, dan pemahaman akhir diperiksa serta diverifikasi oleh penulis.
