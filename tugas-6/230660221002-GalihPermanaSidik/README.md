# Tugas 6: Navigation Flow dan Interaksi

**Nama:** Galih Permana Sidik | **NIM:** 230660221002 | **Kelas:** SI-VIIA
**Domain:** SiLapor Kampus (pelaporan kerusakan fasilitas kampus)

## Deskripsi Singkat

Tugas ini menghubungkan tiga layar dari IA Tugas 5 menjadi satu alur yang bisa dijalankan: daftar laporan (`/`), form laporan (`/form`), dan detail laporan (`/detail`). Data laporan dikirim dari daftar ke detail lewat arguments, form memvalidasi setiap field sebelum dikirim, dan `SnackBar` mengonfirmasi laporan yang terkirim. Kode hanya memakai API bawaan Flutter dan bisa dijalankan di DartPad atau `flutter run -d chrome`.

## Refleksi

Bagian yang paling sulit dijaga konsistensinya adalah nama route, karena ia muncul di tiga tempat sekaligus: diagram, peta `routes`, dan setiap pemanggilan `pushNamed`, dan satu huruf yang berbeda sudah cukup membuat layar error. Saya mengatasinya dengan menyimpan nama route sebagai konstanta di kelas `Rute` lalu mencocokkannya dengan diagram setelah kode selesai. Catatan keputusan juga mudah melenceng dari kode, misalnya aturan minimal 10 karakter pada deskripsi yang baru muncul saat saya menulis validator, sehingga catatan harus diperbarui belakangan.

## Deklarasi Penggunaan AI

Saya menggunakan Claude sebagai alat bantu untuk memahami konsep navigasi Flutter, khususnya perbedaan route bernama dan navigasi langsung, pola pengiriman dan pembacaan arguments antarlayar, serta penanganan error navigasi. AI juga digunakan untuk meninjau konsistensi nama route dengan diagram navigasi, memberikan saran perbaikan pesan validator pada form, dan mengevaluasi feedback setelah laporan dikirim.
