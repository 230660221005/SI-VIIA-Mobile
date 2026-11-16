# Validasi Input — Tugas 12 (Glazent.pro)

Domain: pengajuan/pemesanan layanan Glazent.pro. Validator client diimplementasikan pada `lib/services/validasi_input.dart` dan digunakan pada `lib/halaman-validasi-pesanan.dart`.

| Input | Aturan client | Pemeriksaan server (yang diperlukan) | Pesan error (client) |
|:------|:--------------|:-------------------------------------|:--------------------|
| Nama pemohon | Wajib diisi (`trim`), maksimal 100 karakter | Tipe string, panjang, sanitasi/aturan karakter, otorisasi pengguna | "Nama pemohon wajib diisi." / "Nama maksimal 100 karakter." |
| Email | Wajib diisi (`trim`), format dasar `nama@domain.tld` | Format ketat, normalisasi, keunikan/relasi akun, rate limiting | "Email wajib diisi." / "Format email tidak valid. Contoh: nama@domain.com" |
| Tanggal layanan | Wajib dipilih, format tanggal valid, tidak sebelum hari ini | Rentang/slot tersedia, aturan bentrokan jadwal, zona waktu/kebijakan bisnis | "Tanggal layanan wajib dipilih." / "Format tanggal tidak valid." / "Tanggal layanan tidak boleh sebelum hari ini." |
| Catatan/alamat layanan | Wajib diisi (`trim`), maksimal 200 karakter | Panjang, encoding, penyaringan sesuai kebijakan, tidak dieksekusi sebagai perintah | "Catatan atau alamat layanan wajib diisi." / "Catatan maksimal 200 karakter." |
| Lampiran foto bukti (fitur perangkat) | Format JPG/JPEG/PNG, ukuran > 0 dan ≤ 5 MB, pembatalan bukan error | Tipe MIME/konten sebenarnya, ukuran, pemindaian sesuai kebijakan, kepemilikan resource | "Format foto tidak didukung. Gunakan JPG atau PNG." / "Ukuran foto ... MB melebihi batas 5 MB." / "File foto kosong atau tidak dapat dibaca." (lihat `lib/services/validasi_foto.dart`) |

## Lokasi validator dan cara uji
- **`lib/services/validasi_input.dart`**: `ValidasiInput.namaPemohon`, `ValidasiInput.email`, `ValidasiInput.catatan`, `ValidasiInput.tanggalLayanan` (>= 4 validator yang dapat dijalankan).
- **`lib/services/validasi_foto.dart`**: `ValidasiFoto.periksa` untuk format/ukuran file foto.
- **Cara uji manual**: jalankan aplikasi, buka ikon **"Form validasi & keamanan"** pada AppBar halaman utama.
  - Kosongkan nama/email/catatan lalu tekan kirim → pesan error tampil.
  - Isi email tanpa `@`/domain → ditolak.
  - Pilih tanggal hari ini (valid) atau uji dengan data lampau melalui pemanggilan fungsi (unit) → ditolak jika sebelum hari ini.
  - Isi catatan > 200 karakter → dibatasi/ditolak.
  - Pada halaman bukti pekerjaan, coba unggah file non-gambar/terlalu besar (sesuai platform) → ditolak dengan pesan aman.

## Catatan sanitasi
- Input teks di-`trim()` sebelum diproses (`ValidasiInput.sanitasi`).
- Tidak ada password/token/secret pada form atau pesan error.
- Sanitasi client bukan pengganti validasi dan proteksi injection di server.
