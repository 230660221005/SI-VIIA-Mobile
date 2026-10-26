# Catatan Keputusan Navigasi — Tugas 6

| Keputusan | Pilihan | Alasan (rujuk IA/kebutuhan) |
|---|---|---|
| Initial route | `/` (Katalog Buku) | Katalog adalah entry point utama dan memenuhi kebutuhan melihat daftar buku (F-02). |
| Route detail | `/detail` | Dibutuhkan agar pengguna dapat melihat informasi lengkap buku (F-03) dari item yang diketuk. |
| Data antarlayar | Katalog → Detail mengirim `Buku` via `arguments` | Detail harus menampilkan buku yang dipilih; pola read-only cukup untuk pert. 6 (tanpa CRUD). |
| Route form | `/form` | Dibutuhkan untuk kebutuhan pengajuan peminjaman (F-01). |
| Validator form | NIM wajib angka, Nama wajib, Durasi 1–14 | Mencegah pengajuan kosong/tidak valid sebelum feedback dan kembali ke katalog. |
| Feedback | `SnackBar` setelah kirim valid | Konfirmasi aksi agar pengguna tahu pengajuan “terkirim (simulasi)” sesuai batas cakupan pertemuan 6. |