# Tugas 5 — Prototype UI/UX SiAngkut

**Nama:** Clara Desmiati  
**NIM:** 230660221005
**Mata Kuliah:** Pemrograman Aplikasi Bergerak

## Deskripsi Singkat

Tugas ini menerjemahkan kebutuhan dari Tugas 4 menjadi rancangan Information Architecture, wireframe low-fidelity dua layar, catatan keputusan UI/UX, serta implementasi satu halaman utama Flutter untuk aplikasi SiAngkut. Halaman utama menampilkan iuran bulanan, jadwal pengangkutan, status jadwal, dan tombol aksi utama untuk melaporkan pengangkutan yang belum terlaksana. Form laporan pada wireframe merupakan layar pendukung yang direncanakan, sementara navigasi belum diimplementasikan karena berada di luar cakupan Tugas 5.

## Cara Menjalankan Halaman Flutter

1. Salin `halaman-utama.dart` ke folder proyek Flutter yang memiliki `pubspec.yaml` (misalnya folder proyek SiAngkut dari Tugas 3).
2. Buka terminal di folder proyek Flutter tersebut.
3. Jalankan `flutter run -d chrome -t halaman-utama.dart`.
4. Setelah halaman berhasil tampil, ambil screenshot seluruh halaman dari Chrome dan simpan/ganti file bernama `screenshot-halaman.png` di folder pengumpulan ini. File screenshot yang dikumpulkan harus berasal dari aplikasi yang benar-benar dijalankan, bukan gambar wireframe atau preview.
5. Untuk menguji keadaan kosong, ubah daftar `jadwal` pada `halaman-utama.dart` menjadi `static const List<Map<String, String>> jadwal = [];`, jalankan kembali, lalu pastikan ikon dan pesan keadaan kosong terlihat. Kembalikan data contoh sebelum mengambil screenshot utama.

**Catatan data:** Nama wilayah, label jadwal, dan status di dalam kode merupakan data contoh prototipe. Cocokkan dengan informasi layanan yang sudah diverifikasi sebelum pengumpulan.

## Refleksi

Bagian yang paling sulit dipertahankan konsistensinya adalah hubungan antara ID kebutuhan di Tugas 4, anotasi wireframe, dan komponen yang muncul di halaman utama. Saya perlu memastikan F-01 sampai F-03 benar-benar tercermin pada informasi iuran, daftar jadwal, dan status yang ditampilkan. Form laporan F-04 tetap digambarkan pada wireframe sebagai layar pendukung, tetapi belum dibuat navigasinya agar sesuai batas materi Tugas 5.

## Deklarasi Penggunaan AI

Deklarasi penggunaan AI: ChatGPT — membantu menyusun struktur awal Information Architecture, wireframe, kode prototipe Flutter, dan catatan keputusan UI/UX; hasilnya ditinjau dan perlu dirumuskan ulang oleh penulis sesuai konteks layanan yang sebenarnya.
