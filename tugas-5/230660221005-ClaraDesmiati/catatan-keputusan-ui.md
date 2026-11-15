# Tugas 5 — Catatan Keputusan UI/UX SiAngkut

| Keputusan | Pilihan | Alasan (kebutuhan/persona/prinsip) |
|:--|:--|:--|
| Warna benih | `ColorScheme.fromSeed` dengan benih hijau toska `#14877C`; warna komponen lain diambil dari `ThemeData.colorScheme`. | Hijau toska diasosiasikan dengan layanan lingkungan dan membantu menjaga konsistensi warna antar komponen; mendukung kebutuhan warga Persona 1 untuk membaca informasi layanan dengan jelas. |
| Bentuk status | Status ditampilkan sebagai label/pill berisi teks; warna dipilih dengan ekspresi ternary dari `colorScheme` (`primary`, `secondary`, atau `tertiary`). | F-03 meminta warga melihat status setiap jadwal. Teks tetap ditampilkan agar status tidak bergantung pada warna saja. |
| Posisi aksi utama | `FloatingActionButton.extended` di bagian bawah kanan dengan label “Laporkan Belum Diangkut”. | F-04 adalah kebutuhan Must have. Tombol besar dan label eksplisit membuat aksi pelaporan mudah dikenali; tombol belum membuka layar lain karena `Navigator` berada di luar cakupan Tugas 5. |
| Hierarki teks | Judul “Informasi layanan warga” memakai gaya headline, judul bagian memakai title besar, nama jadwal memakai title kecil tebal, dan keterangan memakai body text. | Informasi utama (F-01 dan F-02) perlu mudah dipindai oleh warga. Hierarki ukuran dan ketebalan teks membedakan ringkasan dari detail. |
| Keadaan kosong | Jika daftar jadwal kosong, tampilkan ikon, pesan “Belum ada jadwal pengangkutan”, dan keterangan di tengah layar. | Keadaan kosong membuat pengguna memahami bahwa daftar belum tersedia, bukan mengira aplikasi gagal memuat data; mendukung kegunaan dan perlu diuji sesuai checklist. |
