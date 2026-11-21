# Refleksi Tugas 13

| | |
|:--|:--|
| **Nama** | Galih Permana Sidik |
| **NIM** | 230660221002 |
| **Kelas** | SI-VIIA |

Bagian yang paling mengejutkan adalah bug yang ternyata ada pada validator yang sebelumnya terasa sudah selesai, karena pola email lama hanya mensyaratkan satu titik pada domain sehingga alamat seperti `dina@kampus..id` lolos. Saya memperbaikinya dengan memecah pola per label dan menulis test regresi yang gagal pada kode lama, lalu memastikan email yang valid tetap diterima supaya perbaikan tidak merusak yang sudah benar. Hal yang masih perlu ditingkatkan adalah pengujian otomatis untuk pemilihan foto serta pengujian izin kamera pada perangkat nyata, yang sekarang masih manual dan simulasi.
