# Tugas 7 — Model Data SiAngkut

**Nama:** Clara Desmiati  
**NIM:** 230660221005
**Mata Kuliah:** Pemrograman Aplikasi Bergerak

## 1. Entitas Data

Entitas yang digunakan dalam MVP SiAngkut adalah `JadwalPengangkutan`. Entitas ini menyimpan informasi jadwal angkutan sampah berdasarkan hari, wilayah, status, dan keterangan. Data digunakan untuk menampilkan jadwal kepada pengguna serta mendukung pengelolaan jadwal oleh petugas.

## 2. Daftar Field

| No. | Field | Tipe Data | Kebutuhan Terkait | Sumber Nilai |
|---|---|---|---|---|
| 1 | `id` | `int` | F-02, F-03, F-06, F-07 | Dibuat oleh sistem sebagai identitas unik setiap jadwal. |
| 2 | `hari` | `String` | F-02, F-07 | Diisi melalui form pengelolaan jadwal oleh petugas. |
| 3 | `wilayah` | `String` | F-02, F-07 | Diisi melalui form pengelolaan jadwal oleh petugas. |
| 4 | `status` | `String` | F-03, F-06 | Memiliki nilai awal `Terjadwal` dan dapat diperbarui petugas menjadi `Selesai`. |
| 5 | `keterangan` | `String` | F-07 | Diisi melalui form untuk memberikan informasi tambahan mengenai jadwal. |

## 3. Fungsi Data dalam CRUD

**Create (Tambah):** Petugas dapat menambahkan jadwal baru melalui form. Penambahan jadwal merupakan bagian dari rancangan pengelolaan jadwal F-07.

**Read (Baca):** Aplikasi menampilkan daftar jadwal beserta hari, wilayah, dan statusnya. Fungsi ini mendukung kebutuhan F-02 dan F-03.

**Update (Ubah):** Petugas dapat memperbarui informasi jadwal atau mengubah status pengangkutan menjadi `Selesai`. Fungsi ini berkaitan dengan F-06 dan F-07.

**Delete (Hapus):** Petugas dapat menghapus jadwal yang salah, duplikat, atau sudah tidak berlaku setelah konfirmasi. Penghapusan ini merupakan perluasan operasional pada prototipe CRUD dan perlu disesuaikan apabila aturan layanan sebenarnya tidak mengizinkan penghapusan jadwal.

## 4. Keputusan Model Data

Model `JadwalPengangkutan` menggunakan field `final` agar nilai setiap objek tidak diubah secara langsung setelah dibuat. Jika informasi jadwal perlu diperbarui, aplikasi akan membuat objek pengganti dengan `id` yang sama.

Field `id` digunakan sebagai identitas unik agar proses update dan delete tidak bergantung pada posisi data dalam daftar. Data pada tugas ini disimpan sementara dalam state aplikasi; penyimpanan permanen belum diterapkan karena fokus tugas adalah memahami CRUD lokal menggunakan Flutter.

## 5. Batasan Implementasi

Data jadwal pada prototipe merupakan data contoh. Implementasi ini belum terhubung ke backend atau database permanen, sehingga data dapat kembali ke kondisi awal ketika aplikasi dimulai ulang.