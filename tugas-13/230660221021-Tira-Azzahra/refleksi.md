    # Refleksi Pengerjaan — Tugas 13

1. Melalui penyusunan 8 test case dan pengujian otomatis pada aplikasi SI Perpustakaan Kampus, saya menemukan bahwa alur penyimpanan yang tampak berjalan normal tetap berisiko menghasilkan duplikasi data apabila tombol kirim ditekan dua kali saat jeda proses asinkron.
2. Perbaikan dilakukan dengan menambahkan state guard `_sedangMengirim` dan menonaktifkan tombol kirim selama pemrosesan berlangsung, yang kemudian diverifikasi melalui widget test regresi pada `pengajuan_perpustakaan_test.dart`.
3. Kedepannya, cakupan pengujian masih perlu diperluas dengan menambahkan integration test yang terhubung langsung ke REST API backend dan pengujian fitur kamera pada perangkat fisik Android/iOS.

## Deklarasi Penggunaan AI
Deklarasi penggunaan AI: Gemini — membantu menyusun kerangka widget test `flutter_test` untuk simulasi double-tap dan merapikan format tabel `test-case.md`; pelaksanaan pengujian, analisis bug, dan verifikasi kode pada project dilakukan oleh penulis.