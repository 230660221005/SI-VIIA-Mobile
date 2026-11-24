# Test Case Tugas 13

| ID | Skenario | Kondisi awal | Langkah | Expected result | Actual result | Status |
|:---|:---------|:-------------|:--------|:----------------|:--------------|:------:|
| TC-01 | Form valid | Aplikasi terbuka, semua input tersedia | Isi nama, email, jumlah, tanggal, dan bukti valid, lalu tekan Validasi Transaksi | Pesan validasi berhasil tampil | Pesan validasi berhasil tampil pada alur manual | Lulus |
| TC-02 | Nama kosong | Form kosong | Tekan Validasi Transaksi | Validator nama menampilkan pesan wajib diisi | Pesan wajib diisi tampil | Lulus |
| TC-03 | Email salah | Field lain boleh kosong | Masukkan email tanpa domain | Validator email menampilkan pesan format salah | Pesan format email tampil | Lulus |
| TC-04 | Jumlah nol atau teks | Form terbuka | Masukkan 0 atau abc pada jumlah | Input ditolak dan pesan nominal tampil | Pesan jumlah tidak valid tampil | Lulus |
| TC-05 | Tanggal masa depan | Form terbuka | Pilih tanggal setelah hari ini | Tanggal ditolak karena transaksi tidak boleh masa depan | Validator tanggal menolak tanggal masa depan | Lulus |
| TC-06 | File ekstensi salah | File chooser tersedia | Pilih file selain JPG, JPEG, PNG, atau WEBP | File ditolak dan pesan format tampil | Validator file menolak ekstensi yang tidak diizinkan | Lulus |
| TC-07 | File terlalu besar | File gambar tersedia | Pilih file lebih dari 5 MB | File ditolak dan pesan ukuran tampil | Validator file menolak ukuran di atas 5 MB | Lulus |
| TC-08 | Pengguna membatalkan file chooser | File chooser terbuka | Tekan Cancel tanpa memilih file | State sebelumnya dipertahankan dan tidak dianggap error | Aksi dibatalkan tanpa menghapus bukti sebelumnya | Lulus |
| TC-09 | Bug form invalid | Form wajib belum lengkap | Tekan Validasi Transaksi | Pesan ringkas Periksa kembali input yang ditandai tampil | Regression test InputValidators.summary lulus | Lulus |
| TC-10 | Analisis kode | Source Tugas 13 tersedia | Jalankan flutter analyze | Tidak ada error analyzer | Analyzer selesai tanpa error, hanya info style | Lulus |
