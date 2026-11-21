# Refleksi Tugas 12

| | |
|:--|:--|
| **Nama** | Galih Permana Sidik |
| **NIM** | 230660221002 |
| **Kelas** | SI-VIIA |

Risiko keamanan paling penting pada SiLapor adalah aturan laporan yang hanya dijaga oleh aplikasi, karena request dapat dibuat dari client lain yang melewati validator Flutter sehingga isi laporan dan foto yang diterima server tidak terkendali. Mitigasi yang dipilih adalah memusatkan aturan pada validator yang diuji otomatis, memakai HTTPS untuk semua pemanggilan, dan menuliskan pemeriksaan wajib di server pada `validasi-input.md` sebagai kebutuhan backend. Hal yang masih perlu diperbaiki adalah penyimpanan token dengan secure storage dan alur logout yang belum ada karena SiLapor belum punya login, serta pesan error Tugas 9 yang masih meneruskan teks error asli.
