# Skenario Pengujian Fitur Perangkat — Tugas 11

- **Target Pengujian:** Flutter Web (`chrome`)
- **Package:** `image_picker: ^1.1.2`

| Skenario | Langkah Uji | Expected Result | Actual Result |
|:---|:---|:---|:---|
| **Fitur berhasil digunakan** | Klik tombol **Pilih Galeri**, pilih file gambar `.jpg`/`.png` berukuran di bawah 5 MB. | Indikator loading muncul sesaat, lalu preview gambar, nama file, dan ukuran KB tampil pada kartu lampiran; tombol **Kirim Pengajuan Peminjaman** dapat memproses data. | **Berhasil** — Preview foto tampil dengan benar beserta nama file dan ukuran dalam KB, serta dialog konfirmasi pengajuan berhasil muncul. |
| **Pengguna membatalkan aksi** | Setelah memilih satu foto, klik **Pilih Galeri** lagi lalu tekan tombol **Cancel** pada dialog pemilihan file. | Aplikasi tidak menampilkan layar error; foto lampiran sebelumnya tetap tampil dan muncul keterangan bahwa pemilihan dibatalkan. | **Berhasil** — Foto sebelumnya tetap dipertahankan di layar dan muncul teks informasi pembatalan berwarna kuning kecokelatan. |
| **Permission ditolak** | Blokir izin kamera pada pengaturan situs Google Chrome (`Site settings > Camera > Block`), lalu klik **Ambil Kamera**. | `PlatformException` ditangkap oleh `LampiranFotoService`; UI menampilkan kotak peringatan *Akses Izin Ditolak*, instruksi pengaturan izin, dan tombol **Coba Lagi**. | **Berhasil** — Pesan informatif *Akses Izin Ditolak* beserta tombol **Coba Lagi** tampil tanpa aplikasi mengalami *crash*. |
| **Package atau perangkat menghasilkan error** | Pilih file gambar berukuran lebih dari 5 MB atau simulasikan pengecualian pada service. | Service melempar `LampiranFotoException`; halaman menampilkan pesan kegagalan yang jelas serta tombol **Coba Lagi**. | **Berhasil** — Pesan batas ukuran / error perangkat tampil rapi dan tombol **Coba Lagi** berfungsi mengulang proses pemilihan. |