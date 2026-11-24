# Quiz Pertemuan 12 — Validasi dan Keamanan Praktis

## Soal 1 — Validasi Client dan Server

Validasi client dilakukan di perangkat sebelum data dikirim, sehingga pengguna mendapat feedback cepat dan form tidak mengirim input yang jelas salah. Validasi server tetap wajib karena client dapat dimodifikasi, dilewati, atau dipanggil oleh aplikasi lain. Aturan bisnis seperti batas nominal transaksi dan hak pengguna harus diperiksa ulang di server agar tidak bergantung pada kode Flutter.

## Soal 2 — HTTPS dan Token

Token yang dikirim melalui HTTP dapat disadap atau diubah oleh pihak di jaringan karena data tidak dilindungi enkripsi transport. Perbaikannya adalah memakai HTTPS dengan sertifikat yang valid, menolak endpoint HTTP, mengirim token melalui header Authorization, dan menerapkan masa berlaku token yang terbatas. Source code dan log juga tidak boleh memuat nilai token sebenarnya.

## Soal 3 — Secure Storage

Token sebaiknya disimpan menggunakan penyimpanan aman platform karena source code dapat dibaca dari repository atau hasil build, sedangkan log dapat terkirim ke sistem monitoring dan terlihat oleh pihak yang tidak berhak. Secure storage memakai mekanisme perlindungan platform untuk membatasi akses token. Saat logout, aplikasi harus menghapus access token dan refresh token dari secure storage, menghapus state sesi di memori, dan mengarahkan pengguna ke halaman login.

## Soal 4 — Permission

Meminta kamera saat aplikasi pertama kali dibuka melanggar prinsip least privilege karena pengguna belum sedang melakukan tindakan yang memerlukan kamera. Alur yang lebih tepat adalah meminta permission ketika pengguna menekan tombol Ambil Foto pada form bukti transaksi, menjelaskan alasan penggunaan sebelum dialog permission jika diperlukan, lalu menangani izin diberikan, ditolak, atau tidak tersedia. Dengan alur ini, permission berkaitan langsung dengan tujuan pengguna dan penolakan tidak menghalangi fitur lain.

## Soal 5 — Security Checklist

1. **Input wajib divalidasi.** Buktinya adalah validator nama pada lib/main.dart dan validation_service.dart.
2. **Format dan ukuran file diperiksa.** Buktinya adalah pemeriksaan ekstensi dan batas 5 MB pada InputValidators.image.
3. **Data sensitif memakai HTTPS.** Buktinya adalah dokumentasi README yang menetapkan endpoint produksi wajib HTTPS.
4. **Token tidak ditulis atau dicetak.** Buktinya adalah pemeriksaan source code dan tidak adanya konstanta token atau print credential.
5. **Permission sesuai fitur.** Buktinya adalah ImagePicker baru dipanggil ketika tombol Pilih Bukti Transaksi ditekan.
