| | |
|:--|:--|
| **Nama** | Galih Permana Sidik |
| **NIM** | 230660221002 |
| **Kelas** | SI-VIIA |

## Soal 1. Validasi Client dan Server

Validasi client berjalan di aplikasi dan bertugas memberi umpan balik cepat: field kosong, format email salah, panjang teks berlebih. Pengguna tahu salahnya sebelum request dikirim. Validasi server berjalan di backend dan menjadi pemeriksa yang berwenang sebelum data diproses: tipe data, hak akses, aturan bisnis, dan identifier.

Validasi form Flutter tidak cukup karena aplikasi ada di tangan pengguna. Kodenya dapat dimodifikasi, dan request dapat dikirim dari alat lain seperti Postman atau skrip tanpa pernah membuka aplikasi. Contoh pada SiLapor: validator membatasi tanggal kejadian maksimal 30 hari ke belakang, tetapi bila server tidak memeriksa ulang, request langsung ke API dapat memasukkan tanggal tahun 1990. Aturan bisnis hanya aman bila ditegakkan di server.

## Soal 2. HTTPS dan Token

Pada `http://` data berjalan tanpa enkripsi. Siapa pun yang berada di jalur jaringan yang sama, misalnya pengguna Wi-Fi publik yang diawasi pihak lain, dapat membaca isi request, termasuk token. Penyerang yang mendapat token dapat memakainya untuk menyamar sebagai pengguna selama token berlaku. Data juga dapat diubah di tengah jalan.

Perbaikannya: ganti endpoint menjadi `https://` dengan sertifikat server yang valid, jangan melewati error sertifikat dengan konfigurasi yang melemahkan, jangan mengirim token lewat query string (URL bisa tercatat di log), dan beri token masa berlaku pendek. Token yang sudah pernah terkirim lewat HTTP sebaiknya dianggap bocor dan diganti.

## Soal 3. Secure Storage

Token ditulis di source code atau log berbahaya karena source code mudah tersebar (repository, hasil dekompilasi aplikasi), dan log dapat dibaca lewat alat debug atau laporan crash. Siapa pun yang membacanya bisa memakai token itu. Secure storage memakai mekanisme platform (Keystore pada Android, Keychain pada iOS) sehingga nilai tersimpan terenkripsi dan terikat pada aplikasi, berbeda dengan `shared_preferences` yang tersimpan sebagai teks biasa.

Saat logout: hapus token dari secure storage, bersihkan salinan di memori, panggil endpoint pencabutan token di server bila tersedia, lalu arahkan pengguna ke halaman login dan kosongkan data yang hanya relevan untuk sesi itu. Token yang tersisa membuat logout hanya terlihat berhasil.

## Soal 4. Permission

Meminta permission kamera saat aplikasi pertama dibuka melanggar prinsip least privilege: aplikasi meminta akses lebih awal dari yang dibutuhkan. Pengguna belum tahu alasannya sehingga cenderung menolak, dan penolakan permanen membuat fitur foto lebih sulit diaktifkan nanti karena harus lewat Pengaturan. Aplikasi juga memegang akses yang tidak terpakai untuk sebagian besar penggunaan.

Alur yang lebih tepat: minta permission saat pengguna menekan tombol lampiran foto pada form, jelaskan singkat tujuannya, tangani izin ditolak dengan pesan dan arahan ke Pengaturan, dan sediakan jalur tanpa foto bila memungkinkan. Pada SiLapor, `image_picker` hanya terpicu saat tombol Kamera atau Galeri ditekan, dan foto bersifat opsional.

## Soal 5. Security Checklist

Lima contoh pemeriksaan beserta buktinya:

| Pemeriksaan | Bukti |
|:------------|:------|
| Input wajib dan format divalidasi | Berkas validator dan tes validator yang memuat kasus lolos dan gagal |
| Endpoint memakai HTTPS | Pencarian `http://` pada source tanpa hasil, dan pemanggilan memakai `Uri.https` |
| Token tidak tertulis di source code | Pemindaian source untuk pola secret tanpa temuan |
| Token tidak dicetak ke log | Pencarian `print` dan `debugPrint` tanpa hasil |
| Permission hanya diminta sesuai fitur | Kode yang menunjukkan permission terpicu saat tombol ditekan, bukan saat startup, ditambah skenario uji izin ditolak |

## Tambahan: 401 dan 403 (dari kuis formatif di materi)

`401 Unauthorized` berarti identitas tidak terbukti: token hilang, tidak valid, atau kedaluwarsa, sehingga aplikasi biasanya mengarahkan ke login ulang. `403 Forbidden` berarti identitas dikenali dan token sah, tetapi pengguna tidak punya hak untuk tindakan itu, sehingga login ulang tidak membantu dan yang tepat adalah pesan bahwa akses tidak diizinkan.
