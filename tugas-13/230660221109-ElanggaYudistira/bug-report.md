# Bug Report Tugas 13

| Bagian | Isi |
|:-------|:----|
| ID bug | BUG-001 |
| Skenario reproduksi | Buka form Validasi Transaksi dalam kondisi field wajib belum lengkap, lalu tekan tombol Validasi Transaksi. |
| Expected result | Validator inline tampil dan halaman memberikan pesan ringkas yang menjelaskan bahwa input perlu diperiksa. |
| Actual result sebelum perbaikan | Validator inline dapat tampil, tetapi status message tidak konsisten karena logika hanya memilih error tanggal atau file dan tidak mempertimbangkan hasil Form.validate. |
| Dugaan penyebab | Status message dirakit langsung memakai dateError dan fileError, sehingga hasil validasi field teks dapat terlewat. |
| Perbaikan | Menambahkan InputValidators.summary yang memprioritaskan status validForm, lalu halaman memakai helper tersebut untuk menentukan pesan. |
| Test regresi | test/validation_test.dart menguji bahwa InputValidators.summary(validForm: false) menghasilkan pesan Periksa kembali input yang ditandai. Perintah flutter test lulus. |

## Bukti perubahan

- Lokasi bug fix: lib/main.dart pada method _simpan.
- Helper: lib/services/validation_service.dart pada method summary.
- Regression test: test/validation_test.dart.
- Validasi tambahan: test nominal, email, dan field wajib.
