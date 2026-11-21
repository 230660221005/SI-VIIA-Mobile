| | |
|:--|:--|
| **Nama** | Galih Permana Sidik |
| **NIM** | 230660221002 |
| **Kelas** | SI-VIIA |

## Soal 1. Test Case

Komponen utama test case: ID, skenario, kondisi awal, langkah, input (bila ada), expected result, actual result, dan status. Tiap komponen membuat test dapat diulang oleh orang lain dengan hasil yang sama.

Expected result adalah hasil yang seharusnya terjadi menurut kebutuhan, ditulis sebelum pengujian. Actual result adalah hasil yang benar-benar terjadi saat skenario dijalankan. Bila keduanya sama, test lulus. Bila berbeda, ada bug atau ada kesalahan pada expected result, dan keduanya perlu ditelusuri. Expected harus ditulis dulu agar tidak disesuaikan dengan apa yang kebetulan keluar.

Contoh pada SiLapor: input email `dina@kampus..id`, expected "Format email tidak valid.", actual dialog ringkasan tampil, sehingga statusnya gagal dan menjadi BUG-01.

## Soal 2. Jenis Testing

- **Static analysis** (`flutter analyze`): memeriksa sintaks, tipe, dan lint tanpa menjalankan aplikasi.
- **Unit test**: menguji satu fungsi atau class secara terisolasi, misalnya `ValidatorLaporan.email`.
- **Widget test**: menguji widget dan interaksinya di lingkungan uji tanpa perangkat, misalnya mengetik pada form lalu memeriksa pesan error.
- **Integration test**: menguji alur aplikasi utuh pada target nyata, misalnya form dibuka, diisi, dikirim, dan daftar diperbarui.
- **Manual functional test**: pengguna atau penguji menjalankan skenario sendiri, cocok untuk hal bergantung perangkat seperti penolakan izin kamera.

Urutan yang disarankan: mulai dari yang murah dan cepat (static, unit, widget), lalu manual untuk yang tidak bisa diotomatisasi.

## Soal 3. Widget Test

- `pumpWidget`: memasang widget ke lingkungan uji dan membangunnya pertama kali.
- `find`: mencari widget berdasarkan teks, key, atau tipe, misalnya `find.text('Kirim laporan')`.
- `tap`: mensimulasikan sentuhan pada widget yang ditemukan.
- `pump`: membangun ulang widget setelah ada perubahan state. `pumpAndSettle` menunggu hingga animasi dan proses selesai.
- `expect`: membandingkan hasil aktual dengan expected, misalnya `expect(find.text('Lokasi wajib diisi.'), findsOneWidget)`.

Tanpa `pump` setelah `tap`, tampilan belum diperbarui sehingga `expect` memeriksa keadaan lama.

## Soal 4. Debugging (tombol simpan menghasilkan dua data)

Langkah berbasis bukti:

1. **Reproduksi:** tekan tombol dua kali cepat dan pastikan dua data muncul. Catat input dan actual result.
2. **Kumpulkan bukti:** baca log atau tambahkan pencetakan sementara pada `_simpan` untuk menghitung berapa kali method terpanggil dan pada detik berapa.
3. **Telusuri state:** periksa apakah ada flag seperti `_sedangMenyimpan` dan apakah tombol dinonaktifkan selama proses.
4. **Hipotesis:** tombol tetap aktif selama proses berjalan, sehingga tap kedua memulai penyimpanan kedua sebelum yang pertama selesai.
5. **Perbaiki satu penyebab:** nonaktifkan tombol dengan `onPressed: _sedangMenyimpan ? null : _simpan`, dan set flag sebelum `await`.
6. **Uji ulang:** jalankan skenario yang sama, lalu test di sekitarnya.

Satu perubahan kecil sekali jalan memudahkan melihat apakah hipotesis benar.

## Soal 5. Regresi

Regresi adalah kerusakan pada fitur yang sebelumnya benar akibat perubahan kode lain. Test yang sudah lulus perlu dijalankan ulang setelah perbaikan karena perbaikan di satu tempat dapat merusak tempat lain yang bergantung padanya.

Contoh pada form pengajuan: untuk memperbaiki email dengan titik beruntun, regex validator diperketat. Bila terlalu ketat, email valid seperti `dina.p+lapor@mail.kampus.ac.id` ikut ditolak, dan pengguna sah tidak bisa mengirim. Test "email valid tetap diterima" yang sudah ada menangkap kerusakan itu segera. Contoh lain: menonaktifkan tombol kirim saat proses berjalan dapat membuat tombol tidak aktif kembali setelah request gagal, sehingga tes "gagal lalu coba lagi" perlu dijalankan.

## Soal 6. Integritas Testing

Test adalah alat pengukur. Mengubah expected result atau menghapus assertion agar lulus sama dengan mengubah timbangan agar menunjukkan angka yang diinginkan: hasilnya hijau, tetapi bug-nya tetap ada. Test yang lulus tidak lagi memberi informasi, sehingga rasa aman yang dihasilkan palsu dan bug baru ditemukan oleh pengguna.

Yang benar: bila test gagal, tentukan apakah penyebabnya di kode atau di test. Bila kode salah, perbaiki kodenya. Bila expected result memang salah karena kebutuhan berubah, ubah dengan alasan yang dicatat dan disetujui, bukan sekadar agar lulus. Assertion hanya dihapus bila memang tidak lagi relevan, bukan karena gagal.
