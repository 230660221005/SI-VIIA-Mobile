# Refleksi — Tugas 11

| | |
|:--|:--|
| **Nama** | Fajar |
| **NIM** | 230660221093 |
| **Kelas** | SI-VIIA |

---

## 1. Alasan Teknis Pemilihan Fitur

Saya memilih kamera dan galeri karena kebutuhan F-05 pada Tugas 4 (foto sebelum dan sesudah pengerjaan) berprioritas Must have dan belum terpenuhi. Foto menjadi bukti hasil kerja teknisi dan dasar klaim garansi nanocoating. Fitur lokasi, file, dan notification tidak saya pilih karena tidak ada kebutuhannya: alamat sudah diisi pada form pemesanan, tidak ada dokumen pendukung, dan notifikasi (F-08) berstatus Won't have. Saya juga menghubungkan hasil foto ke proses bisnis, yaitu tombol Tandai Selesai (F-06) hanya aktif bila kedua foto sudah ada.

## 2. Kesulitan Konfigurasi yang Ditemui

Kesulitan terbesar adalah perbedaan permission antar platform. Android dan iOS memiliki aturan berbeda (iOS memerlukan keterangan pada `Info.plist`), dan web tidak memiliki dialog izin sama sekali. Karena saya hanya menguji pada web (Chrome), skenario izin ditolak tidak dapat dipicu sungguhan, jadi saya menambahkan mode simulasi pada `FotoService` dan mencatatnya sebagai keterbatasan pengujian. Kamera langsung juga tidak dapat diuji pada Chrome desktop karena tombol kamera biasanya membuka pemilih file.

## 3. Hal yang Saya Pelajari

Hasil `null` dari `image_picker` bukan error, melainkan tanda pengguna membatalkan, sehingga halaman harus mempertahankan foto sebelumnya dan tidak menampilkan pesan kegagalan. Karena itu service saya membedakan empat hasil (berhasil, batal, izin ditolak, error), sedangkan widget hanya menampilkan kondisi yang sesuai.

---

Deklarasi penggunaan AI: Claude (Anthropic) — membantu menyusun draf refleksi ini dari struktur Tugas 11; isinya dirumuskan ulang oleh penulis.
