# Test Case — Tugas 13

| ID | Skenario | Kondisi awal | Langkah | Expected result | Actual result | Status |
|:---|:---------|:-------------|:--------|:----------------|:--------------|:------:|
| TC-01 | Nama pemohon valid | Form validasi terbuka, field kosong | Isi nama "Rani Kusuma", panggil validator | Validator mengembalikan `null` | `null` | Lulus |
| TC-02 | Nama pemohon kosong | Form validasi terbuka | Biarkan nama kosong/berisi spasi, panggil validator | Pesan "Nama pemohon wajib diisi." | "Nama pemohon wajib diisi." | Lulus |
| TC-03 | Email format salah | Form validasi terbuka | Isi email `nama@`, panggil validator | Pesan "Format email tidak valid. Contoh: nama@domain.com" | "Format email tidak valid. Contoh: nama@domain.com" | Lulus |
| TC-04 | Email valid | Form validasi terbuka | Isi email `rani@glazent.pro`, panggil validator | Validator mengembalikan `null` | `null` | Lulus |
| TC-05 | Tanggal sebelum hari ini ditolak | Hari acuan 2026-11-16 | Isi tanggal `2026-11-15`, panggil validator | Pesan "Tanggal layanan tidak boleh sebelum hari ini." | "Tanggal layanan tidak boleh sebelum hari ini." | Lulus |
| TC-06 | Form kosong menampilkan validasi | `HalamanValidasiPesanan` ditampilkan | Tekan tombol "Kirim Pengajuan" tanpa mengisi field | Pesan wajib isi untuk nama, email, tanggal, dan catatan tampil | Pesan validasi tampil pada field wajib | Lulus |
| TC-07 | Integrasi sukses menampilkan daftar | Sumber data tiruan mengembalikan 20 pesanan | Render `HalamanDaftarPesanan` dengan data tiruan, tunggu selesai | Ringkasan 20 data dan 20 kartu pesanan tampil | 20 data dan 20 kartu tampil | Lulus (regresi) |
| TC-08 | Integrasi error lalu coba lagi | Panggilan pertama gagal 404, kedua sukses kosong | Render halaman, tekan "Coba Lagi", selesaikan future | Loading tampil lalu keadaan kosong tampil; pemanggilan data terjadi 2 kali | Loading lalu "Belum ada pesanan"; 2 panggilan | Lulus (regresi) |
