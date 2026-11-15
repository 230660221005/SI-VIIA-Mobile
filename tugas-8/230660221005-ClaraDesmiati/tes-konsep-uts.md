# Tes Konsep UTS — Clara Desmiati 230660221005

**Mata Kuliah:** Pemrograman Aplikasi Bergerak  
**Kelas:** SI-VIIA

## Soal 1 — Konsep Aplikasi Bergerak dalam SI

**Jawaban:**

1. Karakteristik: Portabilitas & Aksesibilitas Tinggi
   Contoh penerapan: Mahasiswa bisa isi dan ajukan surat keterangan aktif kuliah langsung dari HP kapan saja (misal: saat di kantin atau di jalan) tanpa perlu bawa laptop atau antre di loket.

2. Karakteristik: Notifikasi Real-Time
   Contoh penerapan: Begitu surat selesai ditandatangani staf kampus, HP mahasiswa langsung dapat notifikasi pop-up tanpa harus rajin mengecek web secara manual.

3. Karakteristik: Integrasi Fitur Perangkat
   Contoh penerapan: Mahasiswa bisa langsung ambil foto KRS/KTM fisik pakai kamera HP saat mengisi lampiran persyaratan di formulir pengajuan.

## Soal 2 — Dasar Pemrograman Dart

**Jawaban:**

- `List<String> daftarSurat = []`: Bikin variabel wadah (list/array) kosong yang khusus menyimpan kumpulan teks (string) nama-nama surat.
- Parameter `String jenis`: Variabel masukan untuk fungsi yang menampung nama jenis surat yang mau ditambahkan.
- `jenis.isEmpty`: Pengecekan logika apakah variabel jenis itu kosong (tidak berisi karakter/tulisan).
- `return` pada kondisi error: Menghentikan jalannya fungsi secara instan agar kode penambahan data di bawahnya tidak dieksekusi saat input tidak valid.
- `daftarSurat.add(jenis)`: Memasukkan data jenis surat yang baru ke dalam list daftarSurat.
- Perulangan `for`: Memproses atau menampilkan seluruh isi data di dalam list daftarSurat satu per satu dari awal sampai akhir.

**Kesalahan umum bila validasi `isEmpty` dihapus:** Data kosong/hampa ("") bakal tetap masuk ke dalam list. Tampilannya jadi jelek karena ada baris kosong di aplikasi, dan bisa bikin error pada proses selanjutnya yang butuh nama surat valid.

## Soal 3 — Struktur Flutter dan Widget

**Jawaban:**

- `MaterialApp`: Widget utama penentu fondasi aplikasi (ngatur tema, warna dasar, dan rute navigasi).
- `Scaffold`: LayOut/kerangka dasar halaman (menyediakan tempat untuk AppBar, Body, dan tombol).
- `AppBar`: Strip/header di bagian atas layar untuk judul halaman dan tombol kembali (back).
- `Column`: Widget tata letak untuk menyusun elemen UI secara vertikal dari atas ke bawah.
- `Text`: Widget sederhana untuk menampilkan tulisan/teks di layar.
- `ListView.builder`: Widget daftar yang merender item secara dinamis dan hemat memori sesuai apa yang terlihat di layar.

**Masalah bila ListView.builder berada di dalam Column tanpa Expanded:** Terjadi error RenderFlex overflow / Unbounded Height (layar muncul garis hitam-kuning).

**Penyebab:** Column butuh tinggi pasti dari anaknya, sedangkan ListView.builder secara bawaan minta ruang tinggi tak terbatas (infinite height), jadi terjadi bentrok layout.

**Perbaikan:** Bungkus ListView.builder dengan widget Expanded agar ukurannya otomatis menyesuaikan sisa ruang kosong di Column.

## Soal 4 — Analisis Kebutuhan dan User Flow

**Klasifikasi dan prioritas:**

| No. | Permintaan | Fungsional/Nonfungsional | Prioritas MoSCoW | Alasan |
|---|---|---|---|---|
| 1 | Mengajukan surat keterangan aktif kuliah |Fungsional |Must |Fitur utama aplikasi. Tanpa ini, aplikasi pengajuan surat tidak ada fungsinya sama sekali. |
| 2 | Melihat status pengajuan |Fungsional |Must |Mahasiswa butuh kejelasan transparan apakah suratnya sedang diproses, disetujui, atau ditolak. |
| 3 | Menerima notifikasi saat surat siap diambil |Fungsional |Should |Sangat berguna agar mahasiswa tidak perlu cek status manual terus-menerus, tapi tanpa ini fitur utama tetap bisa berjalan. |

**User flow untuk kebutuhan Must:**

1. Mahasiswa membuka aplikasi.
2. Login akun mahasiswa.
3. Masuk ke halaman utama (Dashboard).
4. Pilih menu "Pengajuan Surat".
5. Pilih "Surat Keterangan Aktif Kuliah".
6. Isi formulir data diri & upload dokumen.
7. Tekan tombol "Kirim Pengajuan".
8. Sistem menyimpan data pengajuan baru.
9. Tampil konfirmasi "Pengajuan Berhasil".
10. Mahasiswa pindah ke halaman "Riwayat Pengajuan".
11. Sistem menampilkan daftar pengajuan dengan status (misal: Diproses).
12. Admin memverifikasi dan memperbarui status di backend.
13. Mahasiswa melihat perubahan status menjadi Disetujui / Selesai.

## Soal 5 — UI/UX Mobile

**Jawaban:**

1. Prinsip: Kemudahan Aksi Sentuh
   Keputusan desain: Menggunakan tombol floating action button atau kartu item jenis surat dengan ukuran area tekan yang luas (minimal $48 \times 48$ dp).
   Alasan: Layar HP kecil dan dioperasikan pakai jempol, jadi tombol harus cukup besar agar tidak salah tekan saat jalan/tergesa-gesa.

2. Prinsip: Mudah Dipindai Visual 
   Keputusan desain: Menampilkan 20 jenis surat dalam bentuk list item lengkap dengan ikon pembeda dan fitur search bar di paling atas.
   Alasan: Penggunaan HP umumnya singkat; mahasiswa ingin menemukan jenis surat yang dicari dalam waktu 2–3 detik tanpa membaca satu per satu secara teliti.

3. Prinsip: Feedback & Responsiveness
   Keputusan desain: Kunci Jawaban Pemrograman Mobile - Google Gemini
   Alasan: Pengguna langsung tahu bahwa sentuhannya berhasil direspon oleh sistem, menghindari kebingungan atau menekan tombol berulang kali.

## Soal 6 — Navigasi dan Interaksi

**Metode navigasi dan kapan digunakan:**

- `push`: Menumpuk halaman baru di atas halaman yang sedang aktif. Digunakan saat pindah dari halaman daftar ke halaman form pengajuan (membawa data).
- `pushNamed`: Pindah halaman menggunakan rute bernama (misal: '/detail'). Digunakan untuk navigasi antarhalaman yang sudah didaftarkan di router utama agar kode lebih rapi.
- `pop`: Menutup halaman paling atas dan kembali ke halaman sebelumnya. Digunakan saat mahasiswa menekan tombol back atau setelah sukses kirim form.

**Pengiriman data jenis surat ke halaman form:** Data dikirim via parameter constructor saat dipanggil di push (contoh: Navigator.push(context, MaterialPageRoute(builder: (context) => FormSuratPage(jenisSurat: 'Aktif Kuliah')));) atau melalui atribut arguments di pushNamed.

**Feedback setelah form dikirim:** Tampilkan widget SnackBar berwarna hijau di bawah layar bertuliskan "Pengajuan surat berhasil dikirim!", lalu secara otomatis panggil Navigator.pop(context) untuk mengembalikan mahasiswa ke halaman daftar/riwayat.

## Soal 7 — Model Data dan State

**Jawaban:** 

- Mengapa setiap field bersifat `final`: Agar objek data bersifat immutable (nilainya konsisten dan tidak bisa diubah seenaknya secara tidak sengaja di tengah program), mengurangi risiko bug.
- Mengapa `id` wajib ada: Sebagai identitas unik (primary key) untuk membedakan satu pengajuan dengan pengajuan lainnya, terutama saat pencarian, update status, atau penghapusan data.

**Perbedaan StatelessWidget dan StatefulWidget:** StatelessWidget tampilannya statis dan tidak berubah setelah di-render (misal: label/icon), sedangkan StatefulWidget tampilannya dinamis karena bisa berubah sewaktu-waktu merespon interaksi user atau perubahan data.

**Halaman daftar menggunakan:** StatefulWidget

**Alasan:** Karena isi daftar pengajuan surat akan terus berubah (bertambah saat ajukan baru atau berubah statusnya) sehingga UI butuh di-refresh.

**Fungsi `setState`:** Memberi tahu Flutter bahwa ada data state yang berubah, sehingga Flutter melakukan render ulang (re-build) pada widget yang bersangkutan.

**Apa yang terjadi bila data ditambah tanpa `setState`:** Data di memori sebenarnya bertambah, tapi layar HP tidak akan berubah sama sekali (tampilan daftar surat baru tidak muncul sampai layar di-render ulang pemicu lain).

## Soal 8 — CRUD Lokal

**Jawaban:**

| Operasi | Method List / Mekanisme |
|---|---|
| Create |daftarSurat.add(pengajuanBaru) |
| Read |daftarSurat[index] atau melalui ListView.builder |
| Update |int i = daftarSurat.indexWhere((e) => e.id == id); daftarSurat[i] = pengajuanUpdated; |
| Delete |daftarSurat.removeWhere((e) => e.id == idTarget); |

**Mengapa id digunakan sebagai kunci update dan delete:** Karena id nilainya unik dan terikat permanen ke data tersebut, terlepas dari mana pun posisi data berada di dalam list.

**Konsekuensi bila index digunakan sebagai kunci:** Sangat rawan salah hapus/salah update. Jika data di-sort, di-filter, atau ada data di atasnya yang dihapus, posisi index bakal bergeser. Akibatnya, sistem bisa menghapus atau mengubah data orang/item lain yang salah.

## Soal 9 — Persistensi Data Lokal

**Jawaban:**

- Perbedaan in-memory dan persistensi: In-memory: Simpan data sementara di RAM. Begitu aplikasi ditutup/HP dimatikan, data hilang total. Persistensi (SharedPreferences): Simpan data ke memori fisik (storage HP). Data tetap tersimpan walaupun aplikasi ditutup atau HP di-restart.
- Mengapa operasi shared_preferences bersifat asinkron (`Future`): Karena baca-tulis data ke memori fisik butuh jeda waktu I/O. Asinkron dipakai agar aplikasi tidak macet (freeze) saat menunggu proses simpan/baca selesai.
- Apa yang terjadi bila `await` diabaikan: Kode bawahnya langsung berjalan sebelum data selesai diambil/disimpan, sehingga variabel penampung bisa bernilai null atau data tidak sempat tersimpan dengan sempurna.
- Contoh situasi in-memory sudah cukup: Menampung teks pencarian sementara (search query) di halaman katalog yang sedang dibuka.
- Contoh situasi persistensi mutlak diperlukan: Menyimpan token login session mahasiswa atau pilihan preferensi Dark Mode.

## Soal 10 — Integrasi Konsep Lintas Pertemuan

**1. Arsitektur**

Hubungan aplikasi mobile, penyimpanan lokal, dan backend Sistem Informasi: Aplikasi mobile menjadi UI (Front-end) tempat mahasiswa berinteraksi. Penyimpanan lokal (SharedPreferences/SQLite) dipakai menyimpan cache ringan seperti status login atau draf pinjaman agar aplikasi cepat saat dibuka offline. Backend SI (Server/API & Database) mengolah logika utama, memverifikasi stok buku, dan menyimpan data transaksi peminjaman seluruh kampus secara permanen.

**2. Kebutuhan & Alur**

Dua kebutuhan Must have: Melihat daftar/katalog buku perpustakaan. Mengajukan peminjaman buku.

Alur pengguna dari membuka aplikasi hingga tugas selesai: Buka aplikasi $\rightarrow$ Login $\rightarrow$ Lihat Katalog Buku $\rightarrow$ Pilih Buku $\rightarrow$ Isi Form Peminjaman (durasi pinjam) $\rightarrow$ Tekan "Pinjam" $\rightarrow$ Sistem menyimpan data $\rightarrow$ Pengguna diarahkan ke halaman "Riwayat Peminjaman".

**3. Struktur Komponen**

Halaman katalog dan form peminjaman, serta navigasi antarhalaman: Pakai Scaffold $\rightarrow$ Column $\rightarrow$ Expanded $\rightarrow$ ListView.builder (menampilkan daftar kartu buku). Pakai Scaffold $\rightarrow$ Form berisi TextFormField (tanggal kembali) dan ElevatedButton (submit). Pindah dari Katalog ke Form memakai Navigator.push dengan mengirimkan objek data Buku yang dipilih.

**4. Data & State**

Definisi model data Buku (minimal 4 field): class Buku {
  final String id;
  final String judul;
  final String pengarang;
  final bool isTersedia;

  Buku({
    required this.id,
    required this.judul,
    required this.pengarang,
    this.isTersedia = true,
  });
}

Cara operasi Create (meminjam) dan Read (melihat riwayat) dikelola dalam state: Di dalam StatefulWidget. Read (Melihat riwayat): Data dibaca dari List<Buku> riwayatPinjam = [] lalu ditampilkan secara langsung menggunakan widget ListView.builder. Create (Meminjam buku): Saat tombol "Pinjam" diklik, buat objek Buku baru dan masukkan ke list menggunakan setState(() { riwayatPinjam.add(bukuBaru); });. Pemanggilan setState akan memicu render ulang UI sehingga buku yang baru dipinjam langsung muncul secara instan di layar riwayat.