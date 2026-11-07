# Validasi Input — Tugas 12

| Input | Aturan client | Pemeriksaan server | Pesan error |
|:------|:--------------|:-------------------|:------------|
| Nama transaksi | Wajib, trim whitespace, maksimal 60 karakter | Wajib, panjang maksimal 60 karakter, sanitasi teks | Nama transaksi wajib diisi atau terlalu panjang. |
| Email pemilik | Wajib, pola email sederhana, maksimal 120 karakter | Validasi format email dan normalisasi huruf | Format email belum benar. |
| Jumlah transaksi | Wajib, angka positif, maksimal Rp100.000.000 | Validasi tipe numerik, batas nominal, otorisasi pengguna | Jumlah harus angka positif dan tidak melebihi batas transaksi. |
| Tanggal transaksi | Wajib, tidak boleh melebihi tanggal hari ini | Validasi timezone dan rentang tanggal proses bisnis | Tanggal transaksi tidak boleh di masa depan. |
| Bukti transaksi | Wajib, ekstensi JPG/JPEG/PNG/WEBP, maksimal 5 MB | Periksa MIME sebenarnya, ukuran, antivirus, dan penyimpanan aman | Format bukti tidak didukung atau ukurannya terlalu besar. |

## Lokasi validator

Semua aturan client berada di lib/services/validation_service.dart. Form pada lib/main.dart memakai validator untuk nama, email, dan jumlah, lalu memanggil validasi tanggal dan file sebelum menyatakan data siap diproses.

## Cara menguji

- Biarkan nama kosong untuk melihat validasi field wajib.
- Masukkan email tanpa tanda at atau domain untuk melihat validasi format.
- Masukkan jumlah nol, teks, atau nominal di atas batas untuk melihat validasi nominal.
- Pilih tanggal setelah hari ini dengan memodifikasi test atau date picker pada target yang mendukungnya.
- Batalkan pemilihan file, pilih ekstensi yang tidak didukung, atau gunakan file lebih dari 5 MB untuk menguji state file.
