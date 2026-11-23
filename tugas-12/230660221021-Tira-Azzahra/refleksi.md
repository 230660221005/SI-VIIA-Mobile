# Refleksi Pengerjaan — Tugas 12

1. Risiko keamanan paling penting pada project SI Perpustakaan Kampus adalah pengiriman data transaksi peminjaman buku yang tidak tervalidasi maupun penyadapan token sesi pengguna apabila komunikasi tidak terenkripsi.
2. Mitigasi yang dipilih adalah menerapkan enam fungsi validator terpusat pada `PengajuanValidator`, mewajibkan protokol `https://` pada service layer, serta mengelola siklus hidup token sesi secara terisolasi agar selalu dihapus saat pengguna logout.
3. Hal yang masih perlu diperbaiki adalah mengintegrasikan `flutter_secure_storage` untuk penyimpanan token terenkripsi pada perangkat Android/iOS nyata serta menghubungkan validasi client dengan pemeriksaan otoritatif pada backend API produksi.

## Deklarasi Penggunaan AI
Deklarasi penggunaan AI: Gemini — membantu merancang struktur `PengajuanValidator`, abstraksi `TokenStorage`, dan matriks pemeriksaan pada `security-checklist.md`; seluruh aturan validasi domain perpustakaan, pengujian pada Chrome, dan verifikasi keamanan dilakukan oleh penulis.