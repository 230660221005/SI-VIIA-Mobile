| | |
|:--|:--|
| **Nama** | Galih Permana Sidik |
| **NIM** | 230660221002 |
| **Kelas** | SI-VIIA |

## Soal 1. Pemilihan Fitur

Fitur dipilih dari proses bisnisnya, bukan dari ketersediaan package. Urutannya: tentukan siapa yang memakai (aktor), masalah apa yang diselesaikan, data apa yang dihasilkan, permission apa yang dibutuhkan, dan apakah fitur itu bisa diuji pada target yang tersedia. Bila salah satu tidak jelas, fitur belum layak ditambahkan.

Contoh pada SiLapor Kampus: kamera dan galeri untuk lampiran foto kerusakan. Pelapor ingin petugas memahami tingkat kerusakan, sedangkan teks "AC bocor" kurang jelas. Data keluarannya satu foto. Lokasi saya tolak karena pelapor sudah mengetik gedung dan ruang, dan GPS di dalam gedung tidak akurat. Notification saya tunda karena butuh backend yang mengirim event status.

## Soal 2. Permission

Kamera dan galeri berisi data pribadi pengguna, sehingga sistem operasi mewajibkan izin eksplisit supaya aplikasi tidak mengakses sembarangan. Izin yang diminta juga memberi pengguna kendali.

Aplikasi perlu menangani: izin belum diminta (minta dengan alasan yang jelas), izin diberikan (lanjutkan), izin ditolak (jelaskan dampaknya dan arahkan ke Pengaturan, jangan memaksa), dan fitur tidak tersedia pada perangkat atau platform (misalnya kamera langsung pada web desktop), sehingga aplikasi menampilkan pesan dan jalur alternatif. Pada SiLapor, foto opsional sehingga penolakan izin tidak menghalangi pelaporan.

## Soal 3. Pembatalan Pemilihan

`XFile?` bernilai `null` berarti pengguna membatalkan, yaitu menutup kamera atau pemilih gambar tanpa memilih. Itu keputusan pengguna yang sah, bukan kegagalan sistem.

Aplikasi harus membiarkan state sebelumnya apa adanya. Bila foto sudah terpilih sebelumnya, foto itu tetap tampil. Tidak ada pesan error, paling banyak pemberitahuan singkat. Menampilkan error pada pembatalan akan membuat pengguna merasa melakukan kesalahan padahal tidak.

## Soal 4. Service Layer

Service layer bertanggung jawab memanggil package perangkat, menangani permission dan pengecualian, memvalidasi hasil (format, ukuran), dan mengembalikan hasil yang sudah jelas maknanya: data, `null` untuk batal, atau exception bermakna untuk kegagalan. Service tidak menampilkan widget.

Package dan permission sebaiknya tidak di widget karena tiga alasan. Widget menjadi sulit dibaca karena bercampur dengan detail platform. Mengganti package (misalnya `image_picker` ke yang lain) berarti mengubah banyak layar, padahal dengan service cukup satu berkas. Logika yang terpisah juga lebih mudah diuji tanpa membuka tampilan. Pada tugas saya, hanya `foto_service.dart` yang mengimpor `image_picker`.

## Soal 5. State Fitur Perangkat

State minimal: loading (fitur sedang diproses), berhasil (hasil tersedia), dibatalkan, permission ditolak, dan error. Satu keadaan awal "belum ada hasil" juga perlu.

Perlakuannya berbeda. Berhasil: tampilkan hasil, misalnya preview foto. Dibatalkan: pertahankan state sebelumnya tanpa pesan error karena itu pilihan pengguna. Permission ditolak: tampilkan alasan mengapa izin dibutuhkan dan langkah membukanya di Pengaturan, karena percobaan ulang tanpa mengubah izin akan gagal lagi. Error perangkat atau package: tampilkan pesan umum dan tombol coba lagi. Menyamakan ketiganya akan membuat pengguna salah memahami apa yang terjadi dan apa yang harus dilakukan.
