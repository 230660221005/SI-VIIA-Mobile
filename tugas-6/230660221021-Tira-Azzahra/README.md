# Tugas 6 — Navigasi dan Interaksi
Nama: Tira Azzahra  
NIM: 230660221021  
Kelas: SI-VIIA

## Deskripsi Singkat
Prototype Flutter Web sederhana untuk domain Perpustakaan Kampus dengan 3 route bernama: katalog (`/`), detail buku (`/detail`), dan form peminjaman (`/form`). Aplikasi menerapkan pengiriman data dengan arguments, validasi form, serta feedback `SnackBar`.

## Cara Menjalankan
- DartPad: https://dartpad.dev/?template=app lalu tempel isi `form-interaksi.dart`, klik Run.
- Target web lokal: taruh kode ke `lib/main.dart`, lalu jalankan `flutter run -d chrome`.

## Refleksi (3 kalimat)
Bagian tersulit adalah menjaga konsistensi nama route antara diagram Mermaid, tabel route, dan pemanggilan `pushNamed` karena typo kecil langsung membuat route tidak ditemukan. Saya juga perlu teliti memastikan data `arguments` dicek tipenya (`is Buku`) agar halaman detail tidak error saat data null. Validasi form harus ditulis per field dan urutan aksi “validasi → feedback → pop” perlu dijaga agar interaksi terasa jelas.

## Deklarasi penggunaan AI
(Tulis jujur. Contoh)
Deklarasi penggunaan AI: ChatGPT — membantu merapikan struktur route bernama, contoh pola pembacaan arguments yang aman, dan contoh validator; isi akhir disesuaikan kembali oleh penulis.