# Tugas 12 — Validasi dan Keamanan Praktis

## Identitas

- **Nama:** Elangga Yudistira
- **NIM:** 230660221109
- **Kelas:** SI-VIIA
- **Aplikasi:** MoneyTrack Mahasiswa

## Dependency dan cara menjalankan

Dependency utama pada pubspec.yaml adalah image_picker. Jalankan proyek dengan perintah berikut:

    cd C:\Users\ELANG\SI-VIIA-Mobile\tugas_12_web
    flutter pub get
    flutter run -d chrome

Target verifikasi adalah Chrome untuk menguji form, file chooser, pembatalan, dan validator. Android atau iOS perlu dipakai untuk memverifikasi permission kamera dan konfigurasi Info.plist atau Android permission secara penuh.

## Perubahan project

Form Validasi Transaksi memiliki validator untuk nama wajib dan panjang teks, email, nominal, tanggal, serta file bukti. File bukti dipilih melalui image_picker, dibatasi pada ekstensi JPG, JPEG, PNG, dan WEBP, lalu dibatasi maksimal 5 MB. Pesan error dibuat umum agar tidak membocorkan path internal, data pengguna, token, atau password.

Tidak ada token autentikasi pada MVP ini. Integrasi backend produksi harus memakai HTTPS, validasi server, secure storage untuk token, penghapusan token ketika logout, dan rotasi token ketika terjadi kompromi.

## Target permission

Permission kamera atau galeri diminta ketika pengguna menekan tombol Pilih Bukti Transaksi. Pembatalan file chooser tidak dianggap error. Permission ditolak ditampilkan sebagai pesan yang dapat dicoba kembali. Pada iOS, aplikasi produksi perlu menambahkan NSPhotoLibraryUsageDescription dan NSCameraUsageDescription pada Info.plist. Pada Android, permission kamera perlu tersedia ketika sumber kamera digunakan.

## Struktur kode

- lib/main.dart berisi halaman form dan state validasi.
- lib/services/validation_service.dart berisi aturan validasi yang dapat diuji terpisah.
- security-checklist.md berisi sepuluh pemeriksaan keamanan.
- validasi-input.md memetakan aturan client dan pemeriksaan server.
- refleksi.md menjelaskan risiko, mitigasi, dan pekerjaan lanjutan.

## Batasan keamanan

Validasi client hanya meningkatkan pengalaman pengguna. Server harus mengulang seluruh validasi dan memeriksa otorisasi. Preview file masih berada di memori dan belum diunggah ke backend. Package dependency perlu diperbarui melalui pubspec.lock dan ditinjau sebelum rilis.

## Deklarasi penggunaan AI

Deklarasi penggunaan AI: ChatGPT — membantu menyusun validator input, service pemilihan bukti, security checklist, jawaban quiz, dan dokumentasi; kode, pengujian, dan pemahaman akhir diperiksa serta diverifikasi oleh penulis.
