# Refleksi — Tugas 10

| | |
|:--|:--|
| **Nama** | Fajar |
| **NIM** | 230660221093 |
| **Kelas** | SI-VIIA |

---

## 1. Bagian Integrasi Data yang Paling Sulit

Bagian yang paling sulit bagi saya adalah memahami cara menghubungkan tiga data yang terpisah menjadi satu daftar. Ketiga endpoint tidak langsung cocok, jadi saya harus menentukan identifier yang menyambungkannya: `userId` pada pesanan sama dengan `id` pada pelanggan, dan `id` pesanan sama dengan `id` pada progres. Saya juga baru paham bahwa `Future.wait` mengembalikan daftar yang isinya harus saya ubah tipenya satu per satu (`hasil[0] as List<DataPelanggan>`), karena ketiganya berbeda jenis.

## 2. Cara Menangani Response Kosong atau Error

Saya membedakan keduanya. Daftar kosong berarti request berhasil tetapi belum ada pesanan, sehingga halaman menampilkan "Belum ada pesanan". Error berarti request gagal, sehingga halaman menampilkan pesan yang menyebutkan data mana yang gagal dimuat beserta tombol "Coba Lagi". Di model, saya memakai nilai default (`??`) agar field yang tidak ada tidak membuat aplikasi berhenti, dan pengguna tidak melihat detail teknis error.

## 3. Alasan Pemisahan Service dan Widget

Request HTTP, parsing JSON, penggabungan data, dan aturan status saya letakkan di `IntegrasiService`, sedangkan widget hanya menampilkan hasilnya. Dengan begitu halaman menerima daftar `PesananRingkas` yang sudah rapi, bukan tiga response JSON mentah. Kalau aturan status berubah, saya cukup mengubah satu fungsi (`tentukanStatus`) dan tidak perlu mencari di banyak widget.

---

Deklarasi penggunaan AI: Claude (Anthropic) — membantu menyusun draf refleksi ini dari struktur Tugas 10; isinya dirumuskan ulang oleh penulis.
