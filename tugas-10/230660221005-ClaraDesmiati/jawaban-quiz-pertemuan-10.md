# Jawaban Quiz Pertemuan 10
**Nama:** Clara Desmiati  
**NIM:** 230660221005  
**Kelas:** SI-VIIA

## 1. Apa yang dimaksud dengan integrasi data?

Integrasi data adalah proses menggabungkan data dari beberapa sumber agar dapat digunakan secara bersama. Contohnya pada aplikasi SIAngkut, data pengguna dan data pengajuan diambil dari endpoint yang berbeda kemudian digabungkan. Identifier yang digunakan adalah `userId`, yaitu `DataPengajuan.userId` dicocokkan dengan `DataPengguna.id`.

## 2. Kapan menggunakan Future.wait dan kapan menggunakan request berurutan?

Future.wait digunakan ketika beberapa request tidak saling bergantung sehingga dapat dijalankan secara bersamaan. Pada SIAngkut, request GET `/users` dan `/posts` dapat menggunakan Future.wait karena keduanya bisa diambil secara mandiri. Request berurutan digunakan jika request berikutnya membutuhkan hasil dari request sebelumnya.

## 3. Apa fungsi model DataPengajuan dan fromJson?

DataPengajuan digunakan untuk menampung data pengajuan dalam bentuk objek Dart. Factory `fromJson` mengubah data JSON menjadi objek DataPengajuan. Jika nilai tidak tersedia, aplikasi menggunakan nilai default seperti id 0, userId 0, Tanpa Judul, dan Tidak ada deskripsi. Status Menunggu ditentukan secara lokal karena API tidak menyediakan field status.

## 4. Apa perbedaan service layer dan widget?

Service layer bertugas mengurus request HTTP, pemeriksaan respons, parsing JSON, dan penggabungan data. Widget bertugas menampilkan hasil kepada pengguna. Penggabungan tidak dilakukan di widget agar kode lebih teratur, mudah diuji, dan tanggung jawab setiap bagian aplikasi lebih jelas.

## 5. Apa saja kondisi halaman dan mengapa kosong berbeda dengan error?

Kondisi halaman terdiri dari loading, sukses, kosong, dan error. Loading muncul saat request berlangsung, sukses ketika data berhasil diterima, kosong ketika request berhasil tetapi tidak ada data, sedangkan error ketika request gagal. Kondisi kosong harus dibedakan dari error karena keduanya memiliki arti dan penanganan yang berbeda.
