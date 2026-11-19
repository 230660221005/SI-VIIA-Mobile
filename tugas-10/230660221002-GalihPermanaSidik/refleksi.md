# Refleksi Tugas 10

**Galih Permana Sidik | 230660221002 | SI-VIIA**

## Bagian integrasi data yang paling sulit

Yang paling menyita pikiran bukan menulis dua request, melainkan memutuskan apa yang terjadi bila hanya satu yang berhasil. Laporan tanpa nama pelapor tetap terbaca, tetapi petugas tidak tahu siapa yang harus dihubungi, jadi saya memilih seluruh pemuatan dianggap gagal bila salah satu endpoint gagal. Pencocokan `userId` dengan `id` pengguna juga butuh perhatian: laporan yang pelapornya tidak ditemukan harus tetap tampil dengan nama pengganti, bukan menghilang diam-diam.

## Menangani response kosong dan error

Daftar kosong dan request gagal adalah dua kejadian berbeda, jadi halaman memisahkannya. Pada daftar kosong, request berhasil dan server memang tidak punya laporan, sehingga yang tampil adalah "Belum ada laporan" tanpa nada kegagalan. Pada error, semua jenis kegagalan (timeout, koneksi putus, status 404 atau 5xx, JSON rusak) diubah di service menjadi satu `ApiException` dengan pesan yang jelas dan tombol Coba Lagi, sehingga halaman tidak perlu mengenali jenis errornya.

## Alasan memisahkan service dan widget

Alamat endpoint, parsing JSON, penggabungan data, dan aturan status berubah dengan alasan yang berbeda dari tampilan. Bila semuanya ada di `build`, mengganti API simulasi dengan backend SiLapor berarti membongkar kode layar. Dengan service terpisah, perubahan itu hanya menyentuh satu berkas, dan halaman cukup menerima daftar `LaporanRingkas` yang sudah jadi.

## Deklarasi Penggunaan AI

Claude dipakai untuk membantu menyusun kerangka `Future.wait` beserta cara memisahkan hasilnya menjadi dua daftar bertipe, helper `_jalankan` untuk menyeragamkan error, dan pola empat kondisi pada halaman. Claude juga membantu menulis draf tabel pemetaan field dan diagram alur. Pilihan endpoint, identifier penghubung `userId`, aturan status simulasi, serta keputusan bahwa kegagalan satu request menggagalkan seluruh pemuatan saya periksa dan putuskan sendiri, dan seluruh hasilnya saya baca ulang serta cocokkan dengan kebutuhan project.
