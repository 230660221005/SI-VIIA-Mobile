# Tugas 6 — Navigation Flow dan Interaksi

| | |
|:--|:--|
| **Nama** | Fajar |
| **NIM** | 230660221093 |
| **Kelas** | SI-VIIA |
| **Domain** | Usaha mikro jasa — Glazent.pro (glass cleaning & nanocoating) |

---

## 1. Deskripsi Singkat

Tugas ini menghubungkan layar utama Tugas 5 ("Status Pesanan Saya") menjadi alur bernavigasi: route bernama `/` → `/form` (mengajukan pemesanan, F-01) dan `/` → `/detail` (melihat detail pesanan, perluasan F-02). Lihat [`navigation-flow.md`](navigation-flow.md) untuk peta route lengkap, [`form-interaksi.dart`](form-interaksi.dart) untuk implementasinya, dan [`catatan-keputusan-navigasi.md`](catatan-keputusan-navigasi.md) untuk alasan tiap keputusan.

## 2. Refleksi

Bagian yang paling sulit saya jaga konsistensinya adalah route /detail, karena layar ini tidak muncul secara eksplisit di diagram IA Tugas 5 sehingga saya awalnya bingung apakah boleh menambahkannya begitu saja. Saya akhirnya memutuskan menganggapnya sebagai perluasan dari F-02, tapi itu membuat saya harus menuliskan alasannya berulang kali di tiga tempat berbeda (navigation-flow.md, kode, dan catatan keputusan) supaya tidak terlihat seperti route sembarangan. Ke depannya saya belajar bahwa sebaiknya layar seperti ini didaftarkan dulu di tahap IA, bukan ditambahkan belakangan saat menulis kode navigasi.

## 3. Deklarasi Penggunaan AI

Deklarasi penggunaan AI: Claude (Anthropic) — membantu menyusun kerangka navigation flow, implementasi route bernama, form validasi, pengiriman arguments, dan catatan keputusan navigasi berdasarkan domain Glazent.pro dan layar utama Tugas 5 yang sudah disusun penulis; hasilnya dirumuskan ulang oleh penulis.
