# Quiz Pertemuan 11 — Fitur Perangkat

## Soal 1 — Pemilihan Fitur

Fitur perangkat dipilih dengan melihat tujuan pengguna dan langkah proses bisnis yang ingin dipercepat. Pada MoneyTrack, fitur foto bukti transaksi dipilih karena mahasiswa sering membutuhkan bukti saat mencatat pengeluaran; output foto dapat disimpan bersama catatan transaksi untuk verifikasi. Galeri dipakai ketika foto sudah ada, sedangkan kamera dipakai ketika mahasiswa baru selesai melakukan transaksi.

## Soal 2 — Permission

Permission diperlukan karena kamera dan media pribadi adalah sumber daya perangkat yang dapat mengandung data sensitif. Aplikasi harus menangani tiga keadaan: ketika permission diberikan aplikasi melanjutkan fitur, ketika permission ditolak aplikasi menampilkan alasan dan tindakan untuk mengaktifkan izin atau mencoba fitur lain, dan ketika fitur tidak tersedia aplikasi menampilkan pesan bahwa perangkat atau browser tidak mendukungnya. Permission bukan alasan untuk membuat aplikasi berhenti, sehingga state error perlu dipisahkan dari state normal.

## Soal 3 — Pembatalan Pemilihan

Nilai XFile? yang bernilai null berarti pengguna menutup file chooser atau membatalkan pemilihan tanpa memilih gambar. Kondisi ini bukan error dan tidak boleh menampilkan pesan kegagalan. Aplikasi mempertahankan preview atau data sebelumnya, mengubah state menjadi cancelled, dan memberi pesan ringan bahwa pemilihan dibatalkan.

## Soal 4 — Service Layer

Service layer bertanggung jawab memanggil ImagePicker, meneruskan sumber kamera atau galeri, membaca hasil XFile, dan mengubah PlatformException menjadi exception aplikasi yang memiliki informasi permission. Widget hanya mengubah state dan menampilkan hasil, loading, pembatalan, atau error. Package dan pengelolaan permission tidak ditulis langsung di widget agar method build tetap hanya membangun tampilan, service dapat diuji terpisah, dan perubahan package tidak menyebar ke seluruh UI.

## Soal 5 — State Fitur Perangkat

State minimal terdiri dari idle, loading, success, cancelled, permissionDenied, dan error. Pada success aplikasi menyimpan XFile dan bytes lalu menampilkan preview; pada cancelled aplikasi mempertahankan data sebelumnya dan menampilkan pesan bahwa aksi dibatalkan; pada permissionDenied aplikasi menampilkan instruksi izin serta tombol coba lagi; pada error aplikasi menampilkan pesan exception yang informatif. Loading menonaktifkan tombol agar pengguna tidak memulai beberapa proses pemilihan secara bersamaan.
