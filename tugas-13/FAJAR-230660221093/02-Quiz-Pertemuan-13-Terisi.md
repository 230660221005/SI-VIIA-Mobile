# Quiz Pertemuan 13 — Testing, Debugging, dan Perbaikan

**Mata Kuliah:** Pemrograman Aplikasi Bergerak  
**Pertemuan:** 13 | **CPMK:** CPMK-4

## Petunjuk

- Waktu: 20 menit.
- Jawab seluruh 6 soal.
- Sertakan expected result dan alasan teknis jika diminta.

---

## Soal 1 — Test Case

**Pertanyaan:** Sebutkan komponen utama test case dan jelaskan perbedaan expected result dengan actual result.

**Jawaban:**

Komponen utama sebuah *test case* meliputi:

1. **Test case ID:** kode unik untuk mengidentifikasi kasus pengujian.
2. **Judul atau tujuan:** fungsi atau kondisi yang akan diuji.
3. **Precondition:** kondisi awal yang harus terpenuhi sebelum pengujian.
4. **Test data:** data masukan yang digunakan.
5. **Test steps:** urutan langkah untuk menjalankan pengujian.
6. **Expected result:** hasil yang seharusnya terjadi berdasarkan kebutuhan atau spesifikasi.
7. **Actual result:** hasil yang benar-benar terjadi ketika pengujian dijalankan.
8. **Status:** hasil evaluasi, misalnya *Pass* jika hasil aktual sesuai dengan hasil yang diharapkan atau *Fail* jika tidak sesuai.

**Perbedaan:** *Expected result* adalah hasil yang telah ditentukan sebelum pengujian berdasarkan spesifikasi. Sementara itu, *actual result* adalah hasil nyata yang diperoleh setelah aplikasi atau fungsi dijalankan. Keduanya dibandingkan untuk mengetahui apakah fitur bekerja dengan benar.

**Contoh:** Pada pengujian tombol simpan, expected result-nya adalah satu data tersimpan. Jika setelah tombol ditekan ternyata dua data tersimpan, actual result tidak sesuai dengan expected result dan test dinyatakan gagal.

## Soal 2 — Jenis Testing

**Pertanyaan:** Jelaskan perbedaan static analysis, unit test, widget test, integration test, dan manual functional test.

**Jawaban:**

1. **Static analysis** adalah pemeriksaan kode tanpa menjalankan aplikasi. Pemeriksaan ini membantu menemukan masalah seperti kesalahan tipe, penggunaan variabel yang tidak tepat, atau pola kode yang berpotensi menimbulkan bug.
2. **Unit test** menguji bagian kode terkecil, seperti fungsi atau metode, secara terpisah. Tujuannya memastikan logika pada bagian tersebut menghasilkan keluaran yang benar untuk masukan tertentu.
3. **Widget test** menguji satu widget atau kumpulan widget Flutter. Pengujian dapat memeriksa tampilan, keberadaan elemen, serta respons widget terhadap interaksi seperti ketukan.
4. **Integration test** menguji kerja sama beberapa bagian aplikasi sebagai satu alur, misalnya interaksi antara antarmuka, proses bisnis, dan penyimpanan data.
5. **Manual functional test** adalah pengujian fungsi aplikasi secara langsung oleh manusia dengan mengikuti langkah-langkah tertentu. Penguji memeriksa apakah perilaku aplikasi sesuai dengan kebutuhan.

**Intinya:** static analysis memeriksa kode tanpa menjalankannya; unit test menguji logika kecil; widget test menguji antarmuka Flutter; integration test menguji hubungan antarbagian; sedangkan manual functional test memeriksa fungsi aplikasi melalui penggunaan langsung.

## Soal 3 — Widget Test

**Pertanyaan:** Jelaskan fungsi `pumpWidget`, `find`, `tap`, `pump`, dan `expect` dalam widget test Flutter.

**Jawaban:**

1. **`pumpWidget(widget)`** memasang dan membangun widget yang akan diuji ke dalam lingkungan pengujian.
2. **`find`** digunakan untuk mencari elemen atau widget tertentu, misalnya berdasarkan teks, tipe widget, atau key.
3. **`tap(finder)`** mensimulasikan tindakan mengetuk widget yang ditemukan oleh `finder`.
4. **`pump()`** memicu satu siklus pembaruan frame sehingga perubahan UI atau hasil interaksi dapat diproses. Jika perlu menunggu animasi atau proses yang berlangsung beberapa frame, dapat digunakan `pumpAndSettle()`.
5. **`expect(actual, matcher)`** membandingkan nilai atau kondisi aktual dengan kondisi yang diharapkan. Jika tidak cocok, pengujian dinyatakan gagal.

**Contoh alur:** `pumpWidget` menampilkan halaman, `find` mencari tombol Simpan, `tap` menekan tombol, `pump` memproses pembaruan tampilan, lalu `expect` memeriksa apakah pesan berhasil muncul.

## Soal 4 — Debugging

**Pertanyaan:** Sebuah tombol simpan menghasilkan dua data ketika ditekan dua kali. Tuliskan langkah debugging berbasis bukti untuk menemukan penyebab masalah tersebut.

**Jawaban:**

Langkah debugging yang dapat dilakukan:

1. **Reproduksi masalah:** jalankan aplikasi dengan kondisi dan data yang sama, lalu tekan tombol Simpan dua kali. Catat apakah dua data benar-benar tersimpan.
2. **Periksa hasil penyimpanan:** cek database, log, atau respons API untuk memastikan apakah terjadi dua permintaan atau dua operasi insert.
3. **Tambahkan logging:** catat waktu tombol ditekan, jumlah pemanggilan fungsi simpan, ID data, dan respons dari proses penyimpanan.
4. **Telusuri alur kode:** periksa callback tombol, fungsi penyimpanan, pemanggilan API, serta kemungkinan listener atau handler terdaftar lebih dari satu kali.
5. **Periksa proses asynchronous:** pastikan pengguna tidak dapat memulai proses simpan baru ketika proses sebelumnya masih berjalan. Periksa juga apakah retry atau pemanggilan ulang menyebabkan operasi yang sama dikirim dua kali.
6. **Buat hipotesis dan uji satu per satu:** misalnya, tombol belum dinonaktifkan selama proses berlangsung atau fungsi simpan dipanggil dari dua handler. Ubah satu bagian, kemudian ulangi skenario dan bandingkan log.
7. **Terapkan perbaikan dan verifikasi:** cegah pemanggilan ganda, misalnya dengan status `isSaving` yang mengunci tombol selama penyimpanan. Jika sesuai dengan desain sistem, gunakan mekanisme idempotensi di sisi server agar permintaan berulang tidak membuat data duplikat.

**Expected result:** satu tindakan penyimpanan menghasilkan tepat satu data.  
**Bukti yang diperiksa:** log pemanggilan fungsi, jumlah request, respons API, dan isi database. Bukti tersebut membantu menentukan lokasi duplikasi, bukan sekadar menebak penyebabnya.

## Soal 5 — Regresi

**Pertanyaan:** Mengapa test yang sudah lulus perlu dijalankan kembali setelah bug diperbaiki? Jelaskan dengan contoh perubahan pada form pengajuan.

**Jawaban:**

Test yang sebelumnya lulus perlu dijalankan kembali karena perubahan untuk memperbaiki satu bug dapat memengaruhi bagian lain yang sebelumnya bekerja dengan benar. Pengujian ulang ini disebut **regression testing**. Tujuannya memastikan perbaikan tidak menimbulkan bug baru dan fungsi lama tetap berjalan sesuai kebutuhan.

**Contoh:** Pada form pengajuan, sebelumnya pengguna dapat mengisi nama, tanggal, dan alasan pengajuan lalu menekan tombol Kirim. Ditemukan bug bahwa tombol Kirim dapat ditekan berulang kali sehingga data terkirim lebih dari sekali. Pengembang memperbaikinya dengan menonaktifkan tombol selama proses pengiriman.

Setelah perbaikan, pengujian perlu mencakup:
- Form dengan seluruh data valid dapat dikirim dan menghasilkan satu pengajuan.
- Tombol tidak dapat memicu pengiriman kedua ketika proses pertama masih berlangsung.
- Validasi tetap menampilkan pesan ketika nama atau alasan wajib masih kosong.
- Format tanggal yang valid tetap diterima dan format yang tidak valid ditolak.
- Status tombol kembali aktif jika pengiriman gagal, sehingga pengguna dapat mencoba lagi.
- Data yang sudah dikirim tetap tampil atau tersimpan dengan benar.

**Expected result:** bug pengiriman ganda tidak muncul lagi dan fungsi lain pada form pengajuan tetap bekerja seperti sebelum perbaikan.

## Soal 6 — Integritas Testing

**Pertanyaan:** Mengapa menghapus assertion atau mengubah expected result agar test lulus merupakan praktik yang salah?

**Jawaban:**

Menghapus assertion atau mengubah expected result hanya agar test lulus merupakan praktik yang salah karena tindakan tersebut menyembunyikan masalah, bukan memperbaikinya. Assertion berfungsi memeriksa apakah perilaku aktual sesuai dengan kebutuhan. Jika assertion dihapus, test mungkin tetap berjalan tetapi tidak lagi memeriksa hal penting. Jika expected result diubah tanpa dasar spesifikasi, test dapat menyatakan perilaku yang salah sebagai perilaku yang benar.

Dampaknya antara lain:

1. **Bug tidak terdeteksi:** kesalahan pada aplikasi dapat lolos dari pengujian.
2. **Kualitas test menurun:** test tidak lagi memberikan jaminan bahwa fitur bekerja sesuai kebutuhan.
3. **Hasil pengujian menyesatkan:** status *Pass* tidak mencerminkan kualitas aplikasi yang sebenarnya.
4. **Regresi lebih sulit ditemukan:** perubahan berikutnya dapat merusak fungsi tanpa diketahui karena pemeriksaan sudah dilemahkan.

Jika test gagal, langkah yang benar adalah memeriksa apakah implementasi memiliki bug atau apakah spesifikasi/test case memang keliru. Expected result hanya boleh diubah jika ada perubahan kebutuhan atau spesifikasi yang sah, dan perubahan tersebut harus memiliki alasan serta dokumentasi.

**Kesimpulan:** tujuan testing adalah memperoleh bukti bahwa aplikasi memenuhi kebutuhan, bukan sekadar membuat seluruh test berstatus lulus.
