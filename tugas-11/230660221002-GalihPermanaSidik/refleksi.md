# Refleksi Tugas 11
| | |
|:--|:--|
| **Nama** | Galih Permana Sidik |
| **NIM** | 230660221002 |
| **Kelas** | SI-VIIA |

## Alasan teknis memilih fitur

Saya memilih kamera dan galeri karena itulah satu-satunya fitur perangkat yang menjawab masalah nyata pada SiLapor: laporan teks seperti "AC bocor" tidak memberi tahu petugas seberapa parah kerusakannya. Lokasi tidak saya pilih sebab pelapor sudah menulis gedung dan ruang, dan koordinat GPS di dalam gedung kurang akurat. Notification baru berguna bila ada backend yang mengirim kabar perubahan status, dan itu belum ada. Foto saya buat opsional, sehingga penolakan izin tidak menghalangi seseorang melapor.

## Kesulitan konfigurasi

Kesulitan terbesar bukan menulis `pickImage`, melainkan memastikan hasilnya dibedakan dengan benar. `null` berarti pengguna membatalkan, jadi tidak boleh tampil sebagai error, sedangkan izin ditolak dan kegagalan perangkat harus dibedakan dari pembatalan. Saya menyelesaikannya dengan kontrak sederhana pada service: `null` untuk batal, `FotoException` untuk sisanya. Kendala lain adalah pengujian. Penolakan izin dan kamera langsung tidak dapat dibuktikan di Chrome, sehingga dua skenario itu saya uji lewat simulasi dan saya catat sebagai keterbatasan, bukan saya anggap terbukti.

## Deklarasi Penggunaan AI

Claude dipakai untuk membantu menyusun kontrak `FotoService` yang membedakan pembatalan dari kegagalan, memetakan kode `PlatformException` ke jenis kesalahan, dan pola state pada bagian foto, serta menulis draf dokumen fitur dan skenario pengujian. Pemilihan fitur dan alasannya, aturan validasi 5 MB, serta pengisian hasil aktual pengujian saya lakukan dan periksa sendiri.
