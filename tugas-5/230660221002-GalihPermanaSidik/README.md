# Tugas 5: Prototype UI/UX SiLapor Kampus

Tugas ini menerjemahkan kebutuhan Tugas 4 menjadi rancangan dan satu halaman Flutter untuk aplikasi pelaporan kerusakan fasilitas kampus. Isinya information architecture, wireframe dua layar (Daftar Laporan Saya dan Form Laporan Kerusakan), halaman utama `halaman-utama.dart`, tangkapan layar, dan catatan keputusan UI.

## Refleksi

Bagian yang paling sulit dijaga konsistensinya adalah warna dan bentuk status laporan, karena di wireframe hanya berupa kotak abu-abu berlabel sedangkan di kode warnanya ditentukan tema. Saat memindahkan pilihan itu ke catatan keputusan, saya harus memastikan alasan "status terbedakan sekilas" benar-benar terlihat pada hasil berjalan, bukan hanya tertulis. Karena itu saya menambahkan ikon pada setiap status dan memperbarui wireframe serta catatan agar ketiganya menyebut hal yang sama.

Deklarasi penggunaan AI: Claude, menjelaskan cara kerja ColorScheme.fromSeed, mengkritik wireframe dari sisi target sentuh dan hierarki visual, dan memeriksa konsistensi pemetaan widget ke kebutuhan; hasilnya dirumuskan ulang oleh penulis.
