# Skenario Pengujian: Lampiran Foto

**Galih Permana Sidik | 230660221002 | SI-VIIA**

**Target pengujian:** Chrome (web) dengan `flutter run -d chrome`. Skenario 3 dan 4 diuji lewat simulasi `FotoService.simulasi`, bukan pada perangkat Android atau iOS.

| No | Skenario | Cara memicu | Expected result | Actual result |
|:--:|:---------|:------------|:----------------|:--------------|
| 1 | Fitur berhasil digunakan | Tekan **Galeri**, pilih berkas JPG atau PNG di bawah 5 MB | Indikator "Memproses foto..." muncul sebentar, lalu kartu preview menampilkan gambar, nama berkas, dan ukuran. Tombol hapus tersedia | Sesuai. Setelah berkas dipilih, indikator "Memproses foto..." tampil sebentar, lalu kartu preview muncul dengan gambar, nama berkas, ukuran, dan tombol hapus |
| 2 | Pengguna membatalkan aksi | Tekan **Galeri**, lalu tutup dialog pilih berkas tanpa memilih. Ulangi saat sudah ada foto terpilih | Muncul SnackBar "Pemilihan foto dibatalkan." Tidak ada pesan error. Pada ulangan kedua, foto sebelumnya tetap tampil | Sesuai. SnackBar "Pemilihan foto dibatalkan." muncul tanpa kartu error. Pada ulangan kedua, foto yang sudah terpilih tetap tampil |
| 3 | Permission ditolak | `FotoService.simulasi` diubah menjadi `SimulasiFoto.izinDitolak`, aplikasi dijalankan ulang, lalu tekan Kamera atau Galeri | Kartu merah "Izin ditolak" dengan instruksi membuka Pengaturan dan tombol **Coba Lagi**. Form lain tetap dapat dipakai | Sesuai. Kartu merah "Izin ditolak" tampil dengan instruksi membuka Pengaturan dan tombol Coba Lagi, sedangkan kolom form lainnya tetap dapat diisi |
| 4 | Package atau perangkat menghasilkan error | `FotoService.simulasi` diubah menjadi `SimulasiFoto.error`, aplikasi dijalankan ulang, lalu tekan Kamera atau Galeri | Kartu merah "Foto gagal diambil" dengan tombol **Coba Lagi**. Tidak ada stack trace di layar | Sesuai. Kartu merah "Foto gagal diambil" tampil dengan tombol Coba Lagi dan tidak ada stack trace di layar |
| 5 | Format tidak didukung | Pilih berkas selain JPG atau PNG | Kartu "Foto tidak dapat dipakai" dengan pesan "Format foto tidak didukung. Gunakan JPG atau PNG." | Sesuai. Kartu "Foto tidak dapat dipakai" tampil dengan pesan format tidak didukung |
| 6 | Ukuran terlalu besar | Pilih foto lebih dari 5 MB | Kartu "Foto tidak dapat dipakai" dengan pesan ukuran melebihi 5 MB. Foto sebelumnya (bila ada) tetap tampil | Sesuai. Kartu "Foto tidak dapat dipakai" tampil dengan pesan ukuran melebihi 5 MB |
| 7 | Kirim laporan dengan dan tanpa foto | Isi form lengkap, tekan **Kirim laporan** dengan satu foto terpilih, lalu ulangi tanpa foto | Dialog ringkasan menampilkan foto pada kasus pertama dan "Tanpa foto lampiran." pada kasus kedua | Sesuai. Dialog ringkasan menampilkan foto pada kasus pertama dan teks "Tanpa foto lampiran." pada kasus kedua |

`FotoService.simulasi` sudah dikembalikan ke `SimulasiFoto.tidakAda` setelah skenario 3 dan 4.

## Keterbatasan Pengujian

- Skenario 3 dan 4 pada web memakai simulasi, karena browser tidak memunculkan penolakan izin dengan cara yang sama seperti Android atau iOS. Perilaku izin pada perangkat nyata hanya terbukti bila diuji pada perangkat itu.
- Kamera langsung tidak dapat dibuktikan pada web desktop. Tombol Kamera pada web umumnya membuka pemilih berkas.
- Seluruh hasil di atas berasal dari satu kali pengujian pada Chrome dan belum diulang pada browser atau perangkat lain.
