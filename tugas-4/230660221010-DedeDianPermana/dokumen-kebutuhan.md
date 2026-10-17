# Dokumen Kebutuhan — SiRuang Kampus

| Identitas | Keterangan |
|:--|:--|
| **Nama** | Dede Dian Permana |
| **NIM** | 230660221010 |
| **Kelas** | SI-VIIA |
| **Domain** | Sistem Informasi Peminjaman Ruang Kelas — SiRuang Kampus |

---

## 1. Deskripsi Aplikasi

**SiRuang Kampus — Peminjaman Ruang Kelas** merupakan aplikasi mobile yang dirancang untuk membantu mahasiswa mencari informasi ketersediaan ruangan dan mengajukan peminjaman ruang kelas untuk kegiatan akademik, seperti diskusi kelompok, rapat organisasi, dan kegiatan perkuliahan. Tanpa informasi yang terpusat, mahasiswa dapat mengalami kesulitan mengetahui jadwal penggunaan ruangan dan harus menghubungi petugas untuk memastikan ketersediaannya, sedangkan petugas perlu memeriksa jadwal serta mencatat permohonan yang masuk agar tidak terjadi benturan waktu pemakaian. Aplikasi mobile dipilih karena mahasiswa dapat mencari ruangan dan mengajukan peminjaman melalui ponsel, sementara petugas dapat memeriksa serta mengelola permohonan ketika berada di lingkungan kampus. SiRuang Kampus diharapkan dapat membuat proses peminjaman lebih terstruktur, memudahkan pemantauan status permohonan, dan mengurangi kesalahan pencatatan jadwal.

## 2. User Persona

### Persona 1 — Dinda — Mahasiswa Peminjam

| Komponen | Isi |
|:--|:--|
| Nama dan peran | Dinda — mahasiswa yang membutuhkan ruang kelas untuk kegiatan akademik. |
| Tujuan | Menemukan ruangan yang tersedia dan mengajukan peminjaman sesuai tanggal, waktu, dan tujuan kegiatan. |
| Kendala | Tidak selalu mengetahui jadwal penggunaan ruangan dan harus menghubungi petugas untuk memastikan ketersediaannya. |
| Perangkat dan konteks | Ponsel pribadi yang digunakan saat berada di kampus atau ketika merencanakan kegiatan dari rumah. |
| Frekuensi penggunaan | Sesuai kebutuhan, terutama ketika akan mengadakan diskusi kelompok, rapat, atau kegiatan akademik lainnya. |

### Persona 2 — Budi — Petugas Pengelola Ruangan

| Komponen | Isi |
|:--|:--|
| Nama dan peran | Budi — petugas yang memeriksa permohonan dan mengelola jadwal peminjaman ruang kelas. |
| Tujuan | Memastikan permohonan memenuhi ketentuan, memeriksa benturan jadwal, dan memberikan keputusan peminjaman. |
| Kendala | Harus memeriksa jadwal yang sudah ada dan memastikan ruangan tidak dipinjam oleh pihak lain pada waktu yang sama. |
| Perangkat dan konteks | Ponsel atau komputer yang digunakan saat bertugas di lingkungan kampus untuk memeriksa permohonan dan jadwal. |
| Frekuensi penggunaan | Setiap hari kerja atau ketika terdapat permohonan peminjaman ruangan yang perlu diperiksa. |

## 3. Kebutuhan Fungsional

Kebutuhan fungsional berikut dirumuskan berdasarkan aktivitas mahasiswa dalam mencari dan meminjam ruangan serta aktivitas petugas dalam memeriksa permohonan.

| ID | Rumusan Kebutuhan | Terkait Persona |
|:--|:--|:--|
| F-01 | Mahasiswa dapat melihat daftar ruangan beserta kategori dan status ketersediaannya agar dapat memilih ruangan yang sesuai. | Persona 1 |
| F-02 | Mahasiswa dapat melihat jadwal penggunaan ruangan berdasarkan tanggal yang dipilih agar dapat menentukan waktu peminjaman. | Persona 1 |
| F-03 | Mahasiswa dapat mengirim permohonan peminjaman dengan mengisi ruangan, tanggal, waktu, dan tujuan kegiatan sehingga permohonan tercatat untuk diperiksa petugas. | Persona 1 |
| F-04 | Mahasiswa dapat melihat status permohonan yang telah dikirim agar mengetahui apakah permohonan masih menunggu, disetujui, atau ditolak. | Persona 1 |
| F-05 | Petugas dapat melihat daftar permohonan peminjaman yang masuk agar dapat memeriksa pengajuan mahasiswa. | Persona 2 |
| F-06 | Petugas dapat memeriksa benturan jadwal pada permohonan agar tidak terjadi peminjaman ruangan yang sama pada waktu bersamaan. | Persona 2 |
| F-07 | Petugas dapat menyetujui permohonan peminjaman yang memenuhi ketentuan agar mahasiswa memperoleh kepastian atas pengajuannya. | Persona 2 |
| F-08 | Petugas dapat menolak permohonan peminjaman dengan menyertakan alasan agar mahasiswa mengetahui penyebab penolakan. | Persona 2 |

### Kriteria Verifikasi Kebutuhan Fungsional

- **F-01:** Pengujian berhasil jika daftar menampilkan nama ruangan, kategori, dan status ketersediaannya.
- **F-02:** Pengujian berhasil jika jadwal penggunaan ruangan berubah sesuai tanggal yang dipilih.
- **F-03:** Pengujian berhasil jika permohonan dengan seluruh data wajib terisi dapat dikirim dan tercatat.
- **F-04:** Pengujian berhasil jika mahasiswa dapat melihat status permohonan yang telah dikirim.
- **F-05:** Pengujian berhasil jika petugas dapat melihat daftar permohonan yang masuk.
- **F-06:** Pengujian berhasil jika petugas memperoleh informasi ketika jadwal permohonan bertabrakan dengan jadwal yang sudah tercatat.
- **F-07:** Pengujian berhasil jika petugas dapat menyetujui permohonan yang memenuhi ketentuan dan statusnya berubah menjadi disetujui.
- **F-08:** Pengujian berhasil jika petugas dapat menolak permohonan dengan mengisi alasan dan statusnya berubah menjadi ditolak.

## 4. Kebutuhan Nonfungsional

| ID | Kategori | Rumusan | Kriteria Terukur |
|:--|:--|:--|:--|
| NF-01 | Kinerja | Aplikasi harus menampilkan daftar ruangan dengan waktu respons yang memadai pada kondisi jaringan normal. | Daftar ruangan tampil maksimal 3 detik pada jaringan normal dengan data uji tersedia. |
| NF-02 | Kegunaan | Proses pengajuan harus dapat diselesaikan dengan langkah yang jelas agar mahasiswa tidak kesulitan menggunakan aplikasi. | Pengajuan dapat diselesaikan maksimal 5 langkah utama setelah mahasiswa memilih ruangan, tidak termasuk perbaikan data yang salah. |
| NF-03 | Keamanan | Data permohonan hanya boleh diakses oleh pengguna yang memiliki kewenangan. | Mahasiswa hanya dapat melihat permohonannya sendiri, sedangkan petugas yang berwenang dapat melihat dan mengelola permohonan sesuai perannya. |

## 5. Prioritas Fitur (MoSCoW)

Prioritas ditetapkan berdasarkan fungsi yang diperlukan agar proses utama peminjaman dapat berjalan, kemudian diikuti fitur yang meningkatkan kenyamanan dan kejelasan informasi.

| Prioritas | ID Kebutuhan | Alasan |
|:--|:--|:--|
| **Must have** | F-01, F-03, F-05, F-06, F-07 | Kelima kebutuhan ini menjadi fungsi inti. Mahasiswa harus dapat menemukan ruangan dan mengajukan permohonan, sedangkan petugas harus dapat memeriksa permohonan, menghindari benturan jadwal, dan memberikan keputusan. Jumlah fitur Must have adalah lima, sesuai batas maksimal tugas. |
| **Should have** | F-02, F-04 | Informasi jadwal berdasarkan tanggal dan status permohonan membantu Dinda merencanakan kegiatan serta mengetahui perkembangan pengajuan. Fitur ini penting, tetapi pengembangan awal dapat berfokus pada proses pengajuan dan keputusan petugas terlebih dahulu. |
| **Could have** | F-08 | Fitur penolakan disertai alasan meningkatkan transparansi kepada mahasiswa. Pada tahap awal, prioritas pengembangan dapat difokuskan pada pengajuan, pemeriksaan, dan persetujuan terlebih dahulu; mekanisme penolakan dengan alasan dapat disempurnakan berikutnya. |
| **Won't have (saat ini)** | Notifikasi otomatis melalui pesan instan atau push notification, di luar F-01 sampai F-08. | Notifikasi otomatis ditunda agar pengembangan awal berfokus pada fungsi peminjaman inti. Mahasiswa tetap dapat memeriksa status melalui F-04 ketika fitur tersebut tersedia. |

## 6. User Flow

### 6.1 Identitas Alur

| Aspek | Isi |
|:--|:--|
| Nama alur | Pengajuan peminjaman ruang kelas |
| Aktor | Dinda — mahasiswa peminjam |
| Tujuan alur | Permohonan peminjaman tercatat dan Dinda menerima konfirmasi bahwa pengajuan menunggu pemeriksaan petugas. |

### 6.2 Diagram User Flow

Diagram ini menggambarkan alur utama mahasiswa mulai dari membuka aplikasi, memilih ruangan, memeriksa jadwal, mengisi formulir, hingga permohonan tercatat. Terdapat dua keputusan utama, yaitu pemeriksaan ketersediaan ruangan dan pemeriksaan kelengkapan data.

flowchart TD
    S(["Mulai: Mahasiswa membuka aplikasi"]) --> A["Halaman utama SiRuang Kampus"]
    A --> B["Buka daftar ruangan"]
    B --> C["Pilih ruangan"]
    C --> D["Pilih tanggal dan waktu"]
    D --> E["Tampilkan jadwal penggunaan"]
    E --> F{"Ruangan tersedia?"}

    F -- "Tidak" --> G["Tampilkan jadwal bentrok"]
    G --> C
    F -- "Ya" --> H["Buka formulir peminjaman"]
    H --> I["Isi tujuan dan data peminjaman"]
    I --> J{"Data lengkap dan valid?"}

    J -- "Tidak" --> K["Tampilkan pesan kesalahan"]
    K --> H
    J -- "Ya" --> L["Kirim permohonan"]
    L --> M["Simpan permohonan"]
    M --> N["Tampilkan konfirmasi pengajuan"]
    N --> T(["Tujuan tercapai: permohonan tercatat dan menunggu pemeriksaan"])


### 6.3 Daftar Langkah

| No. | Jenis | Langkah/Halaman | Bila gagal |
|:--:|:--|:--|:--|
| 1 | Mulai | Dinda membuka aplikasi SiRuang Kampus. | Jika aplikasi tidak terbuka, Dinda dapat mencoba membukanya kembali. |
| 2 | Halaman | Aplikasi menampilkan halaman utama. | Jika halaman gagal dimuat, aplikasi menampilkan pesan dan opsi untuk mencoba kembali. |
| 3 | Halaman | Dinda membuka daftar ruangan. | Jika daftar gagal dimuat, aplikasi menampilkan pesan dan opsi memuat ulang. |
| 4 | Halaman | Dinda memilih ruangan yang diinginkan. | Dinda dapat kembali ke daftar dan memilih ruangan lain. |
| 5 | Halaman | Dinda menentukan tanggal dan waktu penggunaan. | Dinda dapat memperbaiki tanggal atau waktu yang dipilih. |
| 6 | Proses | Aplikasi menampilkan jadwal penggunaan ruangan. | Jika jadwal gagal dimuat, aplikasi meminta Dinda mencoba kembali. |
| 7 | Keputusan | Apakah ruangan tersedia pada waktu yang dipilih? | Jika tidak, aplikasi menampilkan informasi benturan jadwal dan Dinda kembali memilih ruangan atau waktu lain. |
| 8 | Halaman | Dinda membuka formulir peminjaman. | Dinda dapat kembali ke daftar ruangan jika ingin mengganti pilihan. |
| 9 | Halaman | Dinda mengisi tujuan kegiatan dan data peminjaman. | Dinda dapat memeriksa dan memperbaiki isian formulir. |
| 10 | Keputusan | Apakah data lengkap dan valid? | Jika tidak, aplikasi menampilkan pesan kesalahan dan mengarahkan Dinda kembali ke formulir. |
| 11 | Proses | Dinda mengirim permohonan peminjaman. | Jika pengiriman gagal, aplikasi menampilkan pesan kegagalan dan memberikan kesempatan untuk mencoba kembali. |
| 12 | Proses | Aplikasi mencatat permohonan yang berhasil dikirim. | Jika penyimpanan gagal, aplikasi tidak menampilkan konfirmasi berhasil dan meminta Dinda mencoba kembali. |
| 13 | Tujuan | Aplikasi menampilkan konfirmasi bahwa permohonan tercatat dan menunggu pemeriksaan petugas. | Jika konfirmasi tidak tampil, Dinda dapat memeriksa status permohonan sebelum mengirim ulang. |

**Catatan:** Alur ini berakhir ketika permohonan tercatat, bukan ketika peminjaman disetujui. Persetujuan atau penolakan merupakan proses lanjutan yang dilakukan oleh petugas.

### 6.4 Pemeriksaan User Flow

- Alur menggambarkan satu tujuan pengguna, yaitu mengajukan peminjaman ruang kelas.
- Terdapat lebih dari 8 langkah di luar titik mulai dan tujuan.
- Terdapat 2 titik keputusan dengan cabang berhasil dan gagal.
- Setiap cabang gagal mengarah kembali ke proses yang dapat ditindaklanjuti.
- Setiap langkah memiliki label yang menjelaskan tindakan atau hasilnya.

## 7. Pemetaan Kebutuhan ke Antarmuka

Tabel berikut memetakan seluruh kebutuhan fungsional ke halaman dan widget Flutter yang direncanakan berdasarkan materi Pertemuan 3. Widget masih berupa rancangan awal dan dapat disesuaikan pada tahap pengembangan antarmuka berikutnya.

| ID Kebutuhan | Rumusan (Ringkas) | Prioritas | Halaman yang Memenuhi | Widget yang Direncanakan (P3) |
|:--|:--|:--|:--|:--|
| F-01 | Melihat daftar ruangan dan status ketersediaan | Must | Halaman Daftar Ruangan | `Scaffold`, `AppBar`, `Column`, `ListView.builder`, `Card`, `ListTile` |
| F-02 | Melihat jadwal penggunaan berdasarkan tanggal | Should | Halaman Detail dan Jadwal Ruangan | `Scaffold`, `Column`, `Row`, `Card`, `Text` |
| F-03 | Mengirim permohonan peminjaman | Must | Halaman Formulir Peminjaman | `Scaffold`, `AppBar`, `Column`, `TextField`, `ElevatedButton` |
| F-04 | Melihat status permohonan | Should | Halaman Status Peminjaman | `Scaffold`, `ListView.builder`, `Card`, `ListTile`, `Text` |
| F-05 | Melihat daftar permohonan yang masuk | Must | Halaman Daftar Permohonan Petugas | `Scaffold`, `ListView.builder`, `Card`, `ListTile` |
| F-06 | Memeriksa benturan jadwal | Must | Halaman Pemeriksaan Permohonan | `Scaffold`, `Column`, `Card`, `Text` |
| F-07 | Menyetujui permohonan | Must | Halaman Detail Permohonan Petugas | `Scaffold`, `Column`, `Card`, `ElevatedButton` |
| F-08 | Menolak permohonan dengan alasan | Could | Halaman Detail Permohonan Petugas | `Scaffold`, `Column`, `TextField`, `ElevatedButton` |

**Catatan:** Notifikasi otomatis melalui pesan instan atau push notification ditunda dan belum termasuk kebutuhan F-01 sampai F-08. Oleh karena itu, fitur tersebut belum memiliki halaman khusus dalam pemetaan ini.

## 8. Catatan Analisis

Dokumen ini merupakan rancangan awal kebutuhan SiRuang Kampus berdasarkan domain peminjaman ruang kelas. Pelaksanaan setiap kebutuhan perlu disesuaikan dengan peraturan kampus, termasuk persyaratan peminjaman, kewenangan petugas, dan prosedur pemeriksaan jadwal. Kriteria nonfungsional merupakan target rancangan yang perlu diuji ketika aplikasi dikembangkan, bukan hasil pengujian yang sudah dilakukan. Pemetaan widget juga merupakan rencana antarmuka awal yang dapat disempurnakan pada tahap implementasi.

## Deklarasi Penggunaan AI

Deklarasi penggunaan AI: ChatGPT — membantu menyusun dan meninjau kerangka deskripsi aplikasi, persona, kebutuhan fungsional dan nonfungsional, prioritas MoSCoW, user flow, serta pemetaan kebutuhan ke antarmuka; hasilnya diperiksa dan dirumuskan ulang oleh penulis.
