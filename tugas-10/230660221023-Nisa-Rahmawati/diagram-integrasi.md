# Tugas 10 — Integrasi Data dan Proses Bisnis (Sistem Informasi Perpustakaan Kampus)

- **Nama:** Nisa Rahmawati
- **NIM:** 230660221023
- **Kelas:** SI-VIIA
- **Studi Kasus:** Sistem Informasi Perpustakaan Kampus (Integrasi Data Peminjaman Buku & Anggota Mahasiswa)

## 1. Endpoint dan Metode HTTP yang Digunakan

| No | Endpoint | Metode HTTP | Fungsi dalam Proses Bisnis |
|---|---|---|---|
| 1 | `https://jsonplaceholder.typicode.com/users` | `GET` | Mengambil data master mahasiswa/anggota peminjam buku (`id`, nama, NIM, email, prodi). |
| 2 | `https://jsonplaceholder.typicode.com/todos` | `GET` | Mengambil data transaksi peminjaman buku (`id`, `userId`, judul buku, status pengembalian). |

## 2. Tabel Pemetaan Field JSON ke Model Dart

### A. `AnggotaModel` (`/users`)
| Field JSON | Tipe JSON | Field Model Dart | Tipe Dart | Nilai Default (Fallback) |
|---|---|---|---|---|
| `id` | `int` | `id` | `int` | `0` |
| `name` | `String` | `nama` | `String` | `'Mahasiswa Tanpa Nama'` |
| `nim` / `id` | `String` / `int` | `nim` | `String` | `'230660220001'` (format NIM otomatis) |
| `email` | `String` | `email` | `String` | `'anggota<id>@kampus.ac.id'` |
| `company.name` | `String` | `prodi` | `String` | `'Sistem Informasi'` |

### B. `PeminjamanModel` (`/todos`)
| Field JSON | Tipe JSON | Field Model Dart | Tipe Dart | Nilai Default (Fallback) |
|---|---|---|---|---|
| `id` | `int` | `id` | `int` | `0` |
| `userId` | `int` | `userId` | `int` | `0` |
| `title` / katalog | `String` | `judulBuku` | `String` | Judul katalog perpustakaan / `'Buku Perpustakaan Umum'` |
| `completed` | `bool` | `sudahKembali` | `bool` | `false` |
| *(turunan)* | — | `statusPeminjaman` | `String` | `'Sudah Dikembalikan'` jika `true`, `'Sedang Dipinjam'` jika `false` |

### C. `DetailPeminjamanModel` (Model Gabungan)
| Field Gabungan | Sumber Data | Keterangan |
|---|---|---|
| `idPeminjaman` | `PeminjamanModel.id` | Nomor transaksi peminjaman |
| `userId` | `PeminjamanModel.userId` | Identifier penghubung (*foreign key*) |
| `namaPeminjam` | `AnggotaModel.nama` | Nama mahasiswa peminjam (fallback: `'Anggota Tidak Terdaftar'`) |
| `nimPeminjam` | `AnggotaModel.nim` | Nomor Induk Mahasiswa |
| `prodiPeminjam` | `AnggotaModel.prodi` | Program studi / unit mahasiswa |
| `judulBuku` | `PeminjamanModel.judulBuku` | Judul buku yang dipinjam |
| `statusPeminjaman` | `PeminjamanModel.statusPeminjaman` | Status peminjaman buku |

## 3. Identifier Penghubung & Alasan Penggunaan `Future.wait`

- **Identifier Penghubung:** Field **`userId`** pada `PeminjamanModel` dicocokkan dengan field **`id`** pada `AnggotaModel` menggunakan struktur `Map<int, AnggotaModel>` agar proses penggabungan berjalan cepat ($O(1)$).
- **Alasan Menggunakan `Future.wait`:** Request ke endpoint `/users` dan `/todos` tidak saling bergantung satu sama lain (keduanya merupakan operasi `GET` independen). Dengan `Future.wait`, kedua request dijalankan secara **paralel (bersamaan)** sehingga total waktu tunggu (*latency*) jauh lebih singkat dibandingkan memanggilnya secara berurutan (`await` satu per satu).

## 4. Diagram Alur Request dan Response

```text
[HalamanPeminjamanPerpustakaan]
       │
       ▼ memanggil ambilDataPeminjamanTerintegrasi()
[PerpustakaanIntegrasiService]
       │
       ├──► Future.wait ──┬──► GET /users ──► JSON ──► List<AnggotaModel>
       │                  └──► GET /todos ──► JSON ──► List<PeminjamanModel>
       │
       ▼ join data berdasarkan (peminjaman.userId == anggota.id)
[List<DetailPeminjamanModel>]
       │
       ▼ setState() pada UI
[Tampilan Halaman: Loading / Sukses / Data Kosong / Error + Coba Lagi]