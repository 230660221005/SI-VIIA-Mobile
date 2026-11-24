# Quiz Pertemuan 13 — Testing, Debugging, dan Perbaikan

## Soal 1 — Test Case

Komponen utama test case adalah ID, skenario, kondisi awal, langkah pengujian, expected result, actual result, dan status. Expected result adalah perilaku yang seharusnya terjadi berdasarkan requirement, sedangkan actual result adalah perilaku yang benar-benar diamati saat test dijalankan. Perbedaan keduanya menjadi bukti bahwa fitur lulus atau memiliki bug.

## Soal 2 — Jenis Testing

Static analysis memeriksa source code tanpa menjalankan aplikasi, misalnya error tipe, import, dan lint. Unit test menguji fungsi atau class kecil seperti validator nominal secara terisolasi. Widget test membangun widget dan menguji interaksi seperti tap serta perubahan tampilan. Integration test menguji alur aplikasi yang lebih panjang pada target nyata atau emulator. Manual functional test dilakukan dengan menjalankan aplikasi dan mengikuti skenario pengguna, misalnya memilih bukti transaksi lalu membatalkan file chooser.

## Soal 3 — Widget Test

pumpWidget memasang widget root ke test environment dan memulai frame. find mencari widget atau teks berdasarkan finder. tap mensimulasikan sentuhan pada widget yang ditemukan. pump memproses satu frame atau perubahan asynchronous setelah interaksi, sedangkan pumpAndSettle menunggu frame dan animasi selesai. expect membandingkan hasil aktual dengan kondisi yang diharapkan agar test dapat menyatakan pass atau fail.

## Soal 4 — Debugging

Langkah pertama adalah membuat reproduksi dengan menekan tombol Simpan dua kali dan mencatat kondisi input serta jumlah data sebelum dan sesudah. Berikutnya tambahkan breakpoint atau log terkontrol pada handler tombol dan service untuk mengetahui apakah handler dipanggil dua kali atau satu request menghasilkan dua penyimpanan. Periksa apakah tombol tetap aktif selama Future berlangsung, apakah listener terpasang lebih dari sekali, dan apakah retry membuat request duplikat. Setelah penyebab ditemukan, gunakan flag loading atau disable button selama request, lalu tambahkan test yang menekan aksi dua kali dan memastikan hanya satu data tercipta.

## Soal 5 — Regresi

Test yang sudah lulus perlu dijalankan kembali setelah bug diperbaiki karena perubahan pada handler atau validator dapat memengaruhi fitur yang sebelumnya benar. Contohnya, ketika form pengajuan diubah agar tombol Submit nonaktif saat loading, test validasi, pembatalan, dan pesan sukses tetap perlu dijalankan untuk memastikan state baru tidak menghilangkan alur lama. Pengujian ulang memberi bukti bahwa perbaikan tidak menimbulkan regresi.

## Soal 6 — Integritas Testing

Menghapus assertion atau mengubah expected result agar test lulus menghilangkan pemeriksaan terhadap requirement dan membuat hasil test menyesatkan. Test harus diubah hanya ketika requirement memang berubah dan perubahan itu didokumentasikan. Jika perilaku aplikasi salah, source code yang diperbaiki atau bug report yang diperbarui harus menjadi bagian dari solusi, bukan assertion yang dibuat lebih longgar.
