# Laporan Bug dan Perbaikan Regresi — SI Perpustakaan Kampus

- **Nama:** Tira Azzahra
- **NIM:** 230660221021
- **Kelas:** SI-VIIA

| Bagian | Isi |
|:-------|:----|
| **ID bug** | **BUG-01** |
| **Skenario reproduksi** | 1. Buka halaman **Pengajuan Peminjaman Buku** dan aktifkan sesi.<br>2. Isi seluruh kolom form (Nama, NIM, Email, Judul Buku, Durasi) dengan data valid.<br>3. Tekan tombol **Kirim Pengajuan** dua kali secara cepat dalam waktu kurang dari 400 ms sebelum proses simpan selesai. |
| **Expected result** | Aplikasi hanya memproses satu kali pengiriman dan menambahkan tepat **1 item** pengajuan ke dalam daftar riwayat. |
| **Actual result** | Sebelum perbaikan, tombol **Kirim Pengajuan** tetap aktif selama jeda pemrosesan asinkron (`400 ms`), sehingga ketukan kedua ikut memicu `kirimPengajuanAman()` dan menghasilkan **2 item pengajuan ganda** pada daftar. |
| **Dugaan penyebab** | Tidak adanya pengecekan *guard* state `_sedangMengirim` di awal method `_submitForm()` serta properti `onPressed` pada `FilledButton.icon` yang tidak di-set ke `null` saat proses penyimpanan sedang berlangsung. |
| **Perbaikan** | 1. Menambahkan pengecekan `if (_sedangMengirim) return;` di baris pertama `_submitForm()` pada `lib/main.dart`.<br>2. Mengubah properti tombol kirim menjadi `onPressed: _sedangMengirim ? null : _submitForm` dan label menjadi `'Menyimpan...'` selama proses berjalan. |
| **Test regresi** | Menjalankan widget test otomatis **TC-01 & TC-04** pada `test/pengajuan_perpustakaan_test.dart` (`flutter test`) serta pengujian manual di Chrome. Hasil menunjukkan tombol langsung nonaktif saat diklik pertama kali dan `Daftar Pengajuan (1)` hanya menyimpan 1 entri. |