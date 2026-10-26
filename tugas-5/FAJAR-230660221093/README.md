# Tugas 5 — Prototype UI/UX

| | |
|:--|:--|
| **Nama** | Fajar |
| **NIM** | 230660221093 |
| **Kelas** | SI-VIIA |
| **Domain** | Usaha mikro jasa — Glazent.pro (glass cleaning & nanocoating) |

---

## 1. Deskripsi Singkat

Tugas ini berisi prototype UI/UX untuk aplikasi Glazent.pro, meliputi information architecture ([`information-architecture.md`](information-architecture.md)), wireframe low fidelity dua layar ([`wireframe.png`](wireframe.png)), implementasi layar utama "Status Pesanan Saya" di Flutter ([`halaman-utama.dart`](halaman-utama.dart)), tangkapan layar hasil ([`screenshot-halaman.png`](screenshot-halaman.png)), dan catatan keputusan UI/UX ([`catatan-keputusan-ui.md`](catatan-keputusan-ui.md)). Layar utama memenuhi F-02 (Must have) dan menjadi titik masuk menuju F-01 melalui tombol aksi utama, tanpa menggunakan `Navigator` sesuai batas cakupan Pertemuan 5.

## 2. Refleksi

Sebagai pemula, menurut saya bagian yang paling sulit dijaga konsistensinya adalah warna status pada ChipStatus, karena warnanya ditulis di tiga tempat berbeda: anotasi wireframe (“hijau = selesai”), ternary di kode (status === 'done' ? 'green' : ...), dan catatan keputusan yang menjelaskan alasan pemilihannya. Ketiganya mudah berbeda karena saat kode diubah, misalnya 'green' diganti jadi '#22c55e' atau ada status baru ditambahkan, kita cenderung lupa kembali memperbarui wireframe dan catatan, sehingga dokumen yang awalnya benar pelan-pelan jadi tidak cocok dengan kode. Selain itu, ternary yang bercabang banyak itu tidak punya “sumber kebenaran tunggal”, jadi tidak ada yang otomatis memberi tahu kita kalau salah satu sisi sudah ketinggalan, dan solusi sederhana yang saya pikirkan adalah memindahkan pemetaan status ke warna ke satu objek (misalnya STATUS_COLORS) lalu merujuk nama itu di wireframe dan catatan keputusan.

## 3. Deklarasi Penggunaan AI

Deklarasi penggunaan AI: Claude (Anthropic) — membantu menyusun kerangka information architecture, wireframe low fidelity, implementasi layar Flutter (tema, Card/ListTile, status berwarna, keadaan kosong), dan catatan keputusan UI/UX berdasarkan domain Glazent.pro dan tabel pemetaan Tugas 4 yang sudah disusun penulis; hasilnya dirumuskan ulang oleh penulis.
