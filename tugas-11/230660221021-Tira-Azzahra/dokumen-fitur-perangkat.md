# Analisis Kebutuhan Fitur Perangkat — SI Perpustakaan Kampus

- **Nama:** Tira Azzahra
- **NIM:** 230660221021
- **Kelas:** SI-VIIA
- **Domain Project:** SI Perpustakaan Kampus (Pengajuan Peminjaman Buku)

## 1. Fitur Perangkat yang Dipilih
**Kamera dan Galeri (`image_picker`)** untuk fitur **Lampiran Foto Kondisi Buku / Kartu Tanda Mahasiswa (KTM)**.

## 2. Detail Analisis Kebutuhan

| Aspek | Keterangan |
|:---|:---|
| **Aktor Pengguna** | Mahasiswa peminjam buku perpustakaan kampus. |
| **Tujuan pada Proses Bisnis** | Mendokumentasikan bukti kondisi fisik awal buku yang akan dipinjam (atau verifikasi KTM fisik) sebelum transaksi pengajuan dikirim ke petugas perpustakaan, sehingga mencegah sengketa kerusakan buku saat pengembalian. |
| **Data Keluaran Fitur** | Objek `XFile` yang dikonversi menjadi `HasilLampiranFoto` berisi `namaFile` (`String`), `path` (`String`), `bytes` (`Uint8List`), dan `ukuranKb` (`double`). |
| **Permission yang Diperlukan** | Android: `android.permission.CAMERA` dan akses media/galeri (`READ_MEDIA_IMAGES`). iOS: `NSCameraUsageDescription` dan `NSPhotoLibraryUsageDescription`. Web: izin browser (`MediaDevices.getUserMedia` untuk kamera / file dialog untuk galeri). |
| **Target Platform Verifikasi** | Flutter Web (`flutter run -d chrome`) pada Windows 11. |
| **Konsekuensi Batal / Permission Ditolak** | Jika pengguna membatalkan (`XFile == null`), state lampiran sebelumnya tetap dipertahankan tanpa dianggap error. Jika permission ditolak (`PlatformException`), aplikasi menampilkan pesan informatif cara mengaktifkan izin beserta tombol **Coba Lagi**. |

## 3. Diagram Lifecycle & Alur Fitur

```mermaid
flowchart TD
    A[Mahasiswa tekan Ambil Kamera / Pilih Galeri] --> B[LampiranFotoService.pilihFotoLampiran]
    B --> C{Hasil XFile?}
    C -->|XFile Valid <= 5MB| D[Simpan ke state & tampilkan preview]
    C -->|null / Batal| E[Pertahankan foto sebelumnya + info batal]
    C -->|File > 5MB| F[Tampilkan pesan batas ukuran + Coba Lagi]
    B -->|PlatformException Permission| G[Tampilkan pesan izin ditolak + Coba Lagi]

    ### 2. `skenario-pengujian.md`
```markdown
# Skenario Pengujian Fitur Perangkat — Tugas 11

- **Target Pengujian:** Flutter Web (`chrome`)
- **Package:** `image_picker: ^1.1.2`

| Skenario | Langkah Uji | Expected Result | Actual Result |
|:---|:---|:---|:---|
| **Fitur berhasil digunakan** | Klik tombol **Pilih Galeri**, pilih file gambar `.jpg`/`.png` berukuran di bawah 5 MB. | Indikator loading muncul sesaat, lalu preview gambar, nama file, dan ukuran KB tampil pada kartu lampiran; tombol **Kirim Pengajuan Peminjaman** dapat memproses data. | **Berhasil** — Preview foto tampil dengan benar beserta nama file dan ukuran dalam KB, serta dialog konfirmasi pengajuan berhasil muncul. |
| **Pengguna membatalkan aksi** | Setelah memilih satu foto, klik **Pilih Galeri** lagi lalu tekan tombol **Cancel** pada dialog pemilihan file. | Aplikasi tidak menampilkan layar error; foto lampiran sebelumnya tetap tampil dan muncul keterangan bahwa pemilihan dibatalkan. | **Berhasil** — Foto sebelumnya tetap dipertahankan di layar dan muncul teks informasi pembatalan berwarna kuning kecokelatan. |
| **Permission ditolak** | Blokir izin kamera pada pengaturan situs Google Chrome (`Site settings > Camera > Block`), lalu klik **Ambil Kamera**. | `PlatformException` ditangkap oleh `LampiranFotoService`; UI menampilkan kotak peringatan *Akses Izin Ditolak*, instruksi pengaturan izin, dan tombol **Coba Lagi**. | **Berhasil** — Pesan informatif *Akses Izin Ditolak* beserta tombol **Coba Lagi** tampil tanpa aplikasi mengalami *crash*. |
| **Package atau perangkat menghasilkan error** | Pilih file gambar berukuran lebih dari 5 MB atau simulasikan pengecualian pada service. | Service melempar `LampiranFotoException`; halaman menampilkan pesan kegagalan yang jelas serta tombol **Coba Lagi**. | **Berhasil** — Pesan batas ukuran / error perangkat tampil rapi dan tombol **Coba Lagi** berfungsi mengulang proses pemilihan. |