# Catatan Keputusan UI/UX — Perpustakaan Kampus

Dokumen ini mencatat keputusan desain antarmuka untuk aplikasi perpustakaan kampus berbasis Flutter (Target Web/Mobile). Setiap keputusan diambil berdasarkan hasil analisis kebutuhan (Tugas 4), prinsip UI mobile, dan keterbatasan perangkat target (layar kecil, koneksi tidak stabil).

## Tabel Keputusan Desain

| No | Aspek Desain | Pilihan Desain yang Diimplementasikan | Alasan Teknis & Kaitan dengan Kebutuhan |
|:--:|:-------------|:--------------------------------------|:----------------------------------------|
| **1** | **Skema Warna (Theme)** | **Seed Color: Indigo**<br>Menyesuaikan `ColorScheme.fromSeed(seedColor: Colors.indigo)` dengan `useMaterial3: true`. | - **Kontras & Keterbacaan:** Warna indigo memberikan kontras tinggi terhadap latar putih, penting untuk pengguna (Persona Rani) yang sering mengakses di lingkungan kampus dengan pencahayaan berbeda.<br>- **Konsistensi Otomatis:** Menggunakan Material 3 memastikan warna primer (tombol), sekunder (aksi), dan aksen terkelola otomatis tanpa hard-coding, menjaga konsistensi visual seluruh aplikasi.<br>- **Identitas Akademik:** Warna indigo diasosiasikan dengan kepercayaan dan profesionalisme, cocok untuk institusi pendidikan. |
| **2** | **Representasi Status Stok** | **Chip Berwarna (Ternary Logic)**<br>Gunakan widget `Chip` dengan logika: Biru untuk "Tersedia", Abu-abu untuk "Habis". | - **Efisiensi Memindai (Scanning):** Mahasiswa perlu mengetahu ketersediaan buku dalam hitungan detik saat menggulir daftar (F-01). Chip berwarna memungkinkan pengenalan visual instan tanpa harus membaca teks penuh.<br>- **Feedback Visual:** Memberikan feedback status secara langsung di list item, mengurangi klik tambahan ke halaman detail hanya untuk mengecek stok.<br>- **Hierarki Informasi:** Status diletakkan di sisi kanan (`trailing`) agar judul buku tetap dominan namun status tetap terlihat. |
| **3** | **Komponen Aksi Utama (Primary CTA)** | **FloatingActionButton.extended**<br>Teks "Ajukan" + Icon Tambah, melayang di pojok kanan bawah. | - **Target Sentuh Memadai:** Sesuai prinsip mobile UI, elemen aksi utama harus memiliki area sentuh minimal 48x48dp. FAB extended memenuhi kriteria ini dan mudah ditekan menggunakan jempol satu tangan.<br>- **Prioritas Visual:** Posisi melayang di luar flow konten membuat tombol selalu terlihat (sticky) bahkan saat daftar panjang digulir, memfasilitasi tindakan cepat untuk peminjaman (F-04).<br>- **Aksesibilitas:** Label teks eksplisit ("Ajukan") membantu pengguna memahami fungsi tanpa menebak icon saja. |
| **4** | **Struktur Hierarki Teks** | **Judul Tebal (TitleLarge) + Deskripsi Redup (BodyMedium)**<br>Judul layar tebal, sub-judul/catatan menggunakan warna `Colors.black54`. | - **Pemindaian Cepat:** Mengikuti pola skimming pengguna mobile. Judul tebal menarik perhatian pertama kali untuk konteks layar, sementara deskripsi redup memberikan info pendukung tanpa mendominasi.<br>- **Pengurangan Beban Kognitif:** Membedakan jenis informasi mencegah layar terlihat "penuh" atau berantakan, sangat penting bagi pengguna yang mengakses di sela jadwal kuliah.<br>- **Standar Material Design:** Konsisten dengan panduan Google sehingga terasa familiar bagi pengguna smartphone Android/Web. |
| **5** | **Layout Daftar Data** | **ListView.builder dengan Card**<br>Item dibungkus `Card` dengan bayangan halus. | - **Pemisah Visual Jelas:** Border dan shadow pada `Card` memisahkan setiap entri buku secara tegas, memudahkan fokus pada satu item (F-01).<br>- **Efisiensi Performa:** `ListView.builder` hanya merender item yang terlihat di layar, menjaga performa aplikasi tetap responsif meskipun jumlah data buku bertambah banyak (NF-02).<br>- **Interaksi Jelas:** Efek kartu memberikan kesan elemen dapat diklik/dipilih menuju detail buku. |
| **6** | **Penanganan Kondisi Kosong** | **Empty State dengan Ikon & Pesan**<br>Tampilan khusus jika `daftarBuku.isEmpty`: Ikon buku besar + teks "Belum ada buku...". | - **Kejelasan Sistem:** Mencegah kebingungan pengguna (misal: berpikir aplikasi error) ketika data belum dimuat atau tidak ada hasil pencarian.<br>- **Guidance:** Memberikan instruksi sederhana kepada pengguna untuk mencoba ulang atau ubah kata kunci.<br>- **Estetika:** Menjaga tampilan tetap rapi dan informatif bahkan dalam kondisi tanpa data. |
| **7** | **Field Pencarian** | **TextField dengan Icon Prefix**<br>Icon kaca pembesar di kiri field input. | - **Intuitif:** Icon universal pencarian memudahkan identifikasi fungsi input tanpa perlu membaca label.<br>- **Target Input:** Ukuran field cukup besar untuk akses jari yang akurat, mendukung kebutuhan pencarian cepat (F-02). |

## Referensi Prinsip yang Diterapkan

Keputusan di atas menerapkan lima prinsip utama antarmuka mobile:

1.  **Target Sentuh Memadai:** Semua tombol (FAB, Chip, List Item) memiliki luas tap area yang aman untuk interaksi sentuh.
2.  **Hierarki Visual:** Penggunaan ukuran font dan warna membedakan tingkat kepentingan informasi.
3.  **Feedback:** Perubahan status warna (stok tersedia/habis) memberikan respon instan atas kondisi data.
4.  **Konsistensi:** Gaya komponen (Card, Chip, Text) seragam di seluruh halaman sesuai tema.
5.  **Keterbacaan:** Kontras warna teks terhadap latar belakang memenuhi standar aksesibilitas dasar.

## Deklarasi Penggunaan AI

Deklarasi penggunaan AI: ChatGPT — membantu menyusun kerangka tabel keputusan dan menerjemahkan prinsip desain teknis ke dalam alasan yang jelas; hasil akhir disesuaikan dengan kode implementasi dan kebutuhan spesifik domain perpustakaan kampus oleh penulis.