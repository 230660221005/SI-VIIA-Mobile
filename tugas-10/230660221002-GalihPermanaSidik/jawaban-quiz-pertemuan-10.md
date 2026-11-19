| | |
|:--|:--|
| **Nama** | Galih Permana Sidik |
| **NIM** | 230660221002 |
| **Kelas** | SI-VIIA |

## Soal 1. Integrasi Data

Integrasi data berarti menghubungkan beberapa sumber data agar aplikasi bisa menampilkan satu proses bisnis secara utuh. Satu endpoint jarang memuat semua yang dibutuhkan layar, sehingga aplikasi harus mengambil dari beberapa tempat lalu menyatukannya.

Contoh pada SiLapor Kampus: daftar laporan kerusakan memuat `userId`, tetapi nama pelapor ada di endpoint pengguna. Petugas perlu melihat "AC bocor, dilaporkan oleh Dina", bukan "dilaporkan oleh pengguna 3". Service mengambil `/posts` dan `/users`, lalu menyatukannya.

Identifier penghubungnya adalah `userId` pada data laporan, yang cocok dengan `id` pada data pengguna. Tanpa identifier yang konsisten di kedua sisi, data tidak bisa dipasangkan dengan andal.

## Soal 2. `Future.wait`

`Future.wait` dipakai ketika beberapa request tidak saling bergantung. Pada Tugas 10, `/users` dan `/posts` tidak butuh hasil satu sama lain, sehingga keduanya dijalankan bersamaan. Total waktu tunggu mengikuti request yang paling lambat, bukan jumlah keduanya. Konsekuensinya, bila salah satu `Future` gagal, `Future.wait` ikut gagal, jadi penanganan error harus dipasang.

Request harus berurutan bila request kedua membutuhkan hasil request pertama. Contohnya: laporan diambil dulu, lalu detail pelapor diambil lewat `/users/{id}` memakai `userId` dari laporan. Di sini `id` baru diketahui setelah request pertama selesai, jadi memakai `await` satu per satu.

## Soal 3. Model dan `fromJson`

Untuk menghubungkan pengguna dan pengajuan, `DataPengajuan` butuh minimal `id` (identitas pengajuan itu sendiri), `userId` (penghubung ke pengguna), `roomId` (penghubung ke ruang), dan `status`. Pada SiLapor, padanannya `id`, `userId`, judul, deskripsi, dan status laporan.

`fromJson` menangani field yang tidak ada dengan pola `json['key'] as Tipe? ?? nilaiDefault`. Cast ke tipe nullable tidak melempar error bila key hilang atau bernilai null, lalu operator `??` mengisi nilai pengganti, misalnya `0` untuk `id`, `'Tanpa judul'` untuk judul, dan `'menunggu'` untuk status. Dengan begitu response yang tidak lengkap tidak membuat aplikasi crash.

## Soal 4. Service Layer

Service layer bertanggung jawab atas alamat endpoint, request HTTP, pemeriksaan status code, `timeout` dan `try-catch`, parsing JSON ke model, dan penyusunan data yang dibutuhkan halaman. Widget bertanggung jawab atas tampilan dan state: memanggil service, lalu mengubah state sesuai hasilnya.

Penggabungan data sebaiknya tidak ditulis di widget karena tiga alasan. Pertama, `build` dipanggil berulang, jadi logika berat di dalamnya boros dan rawan terpanggil ulang tanpa sengaja. Kedua, bila API berubah (misalnya dari simulasi ke backend sungguhan), perubahannya cukup di satu service, bukan di setiap layar. Ketiga, logika yang terpisah dari widget lebih mudah dibaca, diuji, dan dipakai ulang di halaman lain.

## Soal 5. Status Halaman

Halaman integrasi data minimal menangani empat state: loading (indikator saat request berjalan), data berhasil dimuat (daftar tampil), data kosong, dan error (disertai tombol coba lagi).

Data kosong harus dibedakan dari error karena maknanya berbeda. Pada data kosong, request berhasil dan server memang tidak punya isi untuk ditampilkan. Menampilkan pesan gagal akan menyesatkan pengguna dan mendorong mereka mencoba ulang berkali-kali tanpa hasil. Pada error, ada sesuatu yang rusak (jaringan, server, atau format data), sehingga pengguna perlu penjelasan dan kesempatan mencoba lagi. Pesan dan tindakan yang tepat untuk keduanya tidak sama, jadi kondisinya harus dibedakan di kode.
