\# Tugas 2 — Modul Hitung Nilai



\## Identitas



\* \*\*Nama:\*\* Ade Yusup Maulana

\* \*\*NIM:\*\* 230660221009

\* \*\*Mata Kuliah:\*\* Pemrograman Aplikasi Bergerak

\* \*\*Bahasa Pemrograman:\*\* Dart



\## Deskripsi



Program \*\*Modul Hitung Nilai\*\* dibuat menggunakan bahasa pemrograman Dart untuk menghitung nilai akhir berdasarkan beberapa komponen penilaian dan bobot masing-masing.



Program menggunakan `List<Map<String, Object>>` untuk menyimpan data komponen nilai. Program kemudian menghitung rata-rata nilai berbobot dan menentukan predikat berdasarkan rentang nilai yang telah ditentukan.



\## Komponen Penilaian



| Komponen  | Bobot | Skor |

| --------- | ----: | ---: |

| Tugas     |   20% |   85 |

| Praktikum |   30% |   90 |

| Kuis      |   15% |   80 |

| UTS       |   15% |   75 |

| UAS       |   20% |   88 |



\## Aturan Predikat



| Rentang Nilai | Predikat        |

| ------------- | --------------- |

| ≥ 86          | A               |

| 76–85         | B               |

| 61–75         | C               |

| < 61          | Perlu perbaikan |



\## Perhitungan



Nilai akhir dihitung berdasarkan bobot setiap komponen:



\* Tugas = 85 × 20% = 17

\* Praktikum = 90 × 30% = 27

\* Kuis = 80 × 15% = 12

\* UTS = 75 × 15% = 11,25

\* UAS = 88 × 20% = 17,60



\*\*Total nilai = 84,85\*\*



Berdasarkan aturan predikat, nilai \*\*84,85\*\* termasuk dalam rentang \*\*76–85\*\*, sehingga mendapatkan predikat \*\*B\*\*.



\## Output Program



Program dijalankan menggunakan perintah:



```bash

dart run hitung\_nilai.dart

```



Hasil output:



```text

=== MODUL HITUNG NILAI PAB ===



Mata Kuliah: Pemrograman Aplikasi Bergerak



Daftar Komponen:

Tugas (Bobot: 20%, Skor: 85)

Praktikum (Bobot: 30%, Skor: 90)

Kuis (Bobot: 15%, Skor: 80)

UTS (Bobot: 15%, Skor: 75)

UAS (Bobot: 20%, Skor: 88)



Rata-rata: 84.85

Predikat : B

```



\## Refleksi



Sintaks yang paling sering saya salahgunakan adalah tipe data dan penggunaan `Map` karena setiap nilai dalam `Map` memiliki pasangan kunci dan nilai yang harus diakses dengan tepat. Saya juga perlu lebih teliti saat menggunakan `as int` untuk mengambil nilai dari `Map` agar sesuai dengan tipe data yang digunakan. Setelah menjalankan program, saya lebih memahami penggunaan `List`, `Map`, perulangan, fungsi, percabangan, dan perhitungan nilai dalam Dart.



