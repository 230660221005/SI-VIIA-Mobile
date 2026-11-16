# Bug Report — Tugas 13

| Bagian | Isi |
|:-------|:----|
| ID bug | BUG-01 |
| Skenario reproduksi | Buka `HalamanValidasiPesanan`, isi semua field dengan data valid, lalu picu aksi kirim berulang sangat cepat (misalnya tap ganda sebelum frame rebuild menonaktifkan tombol) saat proses simulasi pengiriman sedang berjalan. |
| Expected result | Hanya satu proses pengajuan yang diproses; aksi kirim tambahan selama proses berlangsung diabaikan. |
| Actual result (sebelum perbaikan) | Method `_kirim()` tidak memiliki guard awal terhadap status `_sedangKirim`, sehingga pemanggilan ulang yang masuk sebelum/tanpa kendali state berpotensi memulai proses pengiriman lagi. |
| Dugaan penyebab | Tidak ada pengecekan `if (_sedangKirim) return;` di awal `_kirim()`, sehingga pencegahan submit ganda hanya bergantung pada disable tombol setelah `setState`. |
| Perbaikan | Menambahkan guard `if (_sedangKirim) return;` di awal `Future<void> _kirim()` pada `lib/halaman-validasi-pesanan.dart` agar pemanggilan berulang diabaikan selama proses berlangsung. |
| Test regresi | `flutter analyze` (tanpa issue) dan `flutter test test/tugas13_validasi_dan_form_test.dart` (5 test lulus). Test widget/unit terkait validasi form tetap lulus. |

## Catatan bukti

- Bukti analisis: `flutter analyze` → `No issues found!`
- Bukti test otomatis: `flutter test test/tugas13_validasi_dan_form_test.dart` → `All tests passed!` (4 unit test + 1 widget test).
- Perbaikan diverifikasi tidak mengubah perilaku validasi form (TC-06 tetap menampilkan pesan validasi yang sama).
