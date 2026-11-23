# Jawaban Quiz Pertemuan 13 — Testing, Debugging, dan Perbaikan

- **Nama:** Tira Azzahra
- **NIM:** 230660221021
- **Kelas:** SI-VIIA
- **Domain Project:** SI Perpustakaan Kampus (Pengajuan Peminjaman Buku)

## Soal 1 — Test Case
Komponen utama sebuah *test case* meliputi: **ID Test**, **Skenario**, **Kondisi Awal (Precondition)**, **Langkah Pengujian (Steps)**, **Input**, **Expected Result**, **Actual Result**, dan **Status (Lulus/Gagal)**. Perbedaannya: **Expected result** adalah perilaku sistem yang seharusnya terjadi berdasarkan spesifikasi kebutuhan dan ditulis *sebelum* pengujian dijalankan, sedangkan **Actual result** adalah perilaku nyata yang diamati di layar *setelah* skenario pengujian benar-benar dieksekusi.

## Soal 2 — Jenis Testing
- **Static analysis (`flutter analyze`):** Pemeriksaan kode tanpa menjalankan aplikasi untuk mendeteksi kesalahan sintaks, tipe data, variabel tidak terpakai, atau pelanggaran aturan lint.
- **Unit test:** Pengujian fungsi atau kelas logika yang terisolasi dari antarmuka pengguna (contoh: menguji fungsi `PengajuanValidator.validasiNim()`).
- **Widget test:** Pengujian komponen UI Flutter dan interaksi pengguna (tap, input teks) dalam lingkungan simulasi cepat tanpa perangkat fisik.
- **Integration test:** Pengujian alur kerja aplikasi secara menyeluruh dari ujung ke ujung pada emulator atau perangkat nyata.
- **Manual functional test:** Pengujian langsung oleh penguji pada aplikasi yang berjalan (misalnya di Chrome atau Android) untuk memeriksa skenario interaksi dan fitur perangkat seperti penolakan izin kamera.

## Soal 3 — Widget Test
- **`pumpWidget()`:** Merender dan memasang widget yang akan diuji ke dalam lingkungan pengujian `WidgetTester`.
- **`find`:** Mencari dan menargetkan widget tertentu di dalam pohon widget berdasarkan teks (`find.text`), kunci (`find.byKey`), tipe, atau ikon.
- **`tap()`:** Mensimulasikan ketukan jari/klik pengguna pada widget yang ditemukan.
- **`pump()`:** Memicu pembangunan ulang (*rebuild*) frame UI setelah terjadi perubahan state atau interaksi asinkron.
- **`expect()`:** Membandingkan kondisi aktual widget atau state di layar dengan *expected result* yang ditentukan.

## Soal 4 — Debugging
Langkah debugging berbasis bukti untuk masalah tombol simpan menghasilkan dua data saat ditekan dua kali:
1. **Reproduksi bug:** Ulangi skenario menekan tombol kirim dua kali secara cepat pada form yang valid dan catat hasil aktualnya (terbentuk 2 entri identik).
2. **Telusuri method & state terkait:** Periksa handler `onPressed` pada tombol dan method penyimpanan asinkron (`_submitForm()`).
3. **Susun hipotesis penyebab:** Selama jeda request asinkron berlangsung, tombol tetap dalam keadaan aktif (`enabled`) dan tidak ada variabel penanda proses sedang berjalan sehingga event tap kedua ikut dieksekusi.
4. **Perbaiki satu penyebab:** Tambahkan state `_sedangMengirim`, pasang guard `if (_sedangMengirim) return;`, dan atur `onPressed: _sedangMengirim ? null : _submitForm`.
5. **Uji ulang & regresi:** Jalankan kembali skenario double-tap melalui widget test dan manual test untuk memastikan hanya 1 item tersimpan.

## Soal 5 — Regresi
Test yang sebelumnya sudah lulus wajib dijalankan kembali setelah bug diperbaiki untuk memastikan perubahan kode pada perbaikan tersebut tidak menimbulkan efek samping atau merusak fitur lain yang sebelumnya sudah berjalan normal (*regression*). Contohnya pada form pengajuan buku: setelah menonaktifkan tombol kirim saat `_sedangMengirim == true` untuk memperbaiki bug duplikasi data, kita harus menjalankan kembali test input kosong (`TC-02`) dan test error sesi 401 (`TC-06`) untuk memastikan tombol tetap kembali aktif saat validasi gagal atau terjadi error.

## Soal 6 — Integritas Testing
Menghapus `expect()` (*assertion*) atau mengubah *expected result* agar sesuai dengan perilaku sistem yang salah adalah praktik yang keliru karena menghilangkan fungsi pengujian sebagai alat pendeteksi cacat (*quality gate*). Akibatnya, bug yang sebenarnya berbahaya akan lolos ke pengguna akhir sementara laporan pengujian memberikan rasa aman yang palsu.