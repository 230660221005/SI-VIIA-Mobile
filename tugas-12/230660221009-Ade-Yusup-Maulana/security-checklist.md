

\# SECURITY CHECKLIST

\## Tugas 12 - Validasi dan Keamanan Praktis



Nama: Ade Yusup Maulana  

NIM: 230660221009  

Program Studi: Sistem Informasi  

Kelas: SI-VIIA  



| No. | Pemeriksaan Keamanan | Status | Bukti |

|---|---|---|---|

| 1 | Foto wajib dipilih sebelum diproses | Lulus | Pengujian cekFotoWajib |

| 2 | Format file dibatasi JPG, JPEG, PNG | Lulus | Pengujian PDF ditolak |

| 3 | Ukuran foto maksimal 2 MB | Lulus | Pengujian ukuran lebih dari 2 MB |

| 4 | Foto di bawah 2 MB dapat diterima | Lulus | Pengujian ukuran di bawah 2 MB |

| 5 | Data foto tidak boleh kosong | Lulus | Pengujian data kosong |

| 6 | Isi file diperiksa berdasarkan signature JPEG/PNG | Lulus | Pengujian signature file |

| 7 | File dengan isi tidak valid ditolak | Lulus | Pengujian isi file tidak valid |

| 8 | Aplikasi meminta akses kamera melalui plugin | Perlu verifikasi | Pengujian pada perangkat Android |

| 9 | Aplikasi meminta akses galeri melalui plugin | Perlu verifikasi | Pengujian pada perangkat Android |

| 10 | Komunikasi menggunakan HTTPS | Tidak diterapkan | Aplikasi belum menggunakan API atau server |

| 11 | Token autentikasi disimpan secara aman | Tidak diperlukan saat ini | Aplikasi belum menggunakan login atau token |



\## Catatan



Pengujian validasi dilakukan menggunakan Flutter Test dengan hasil 9 pengujian berhasil, termasuk pengujian tampilan aplikasi.



Aplikasi masih berjalan secara lokal dan belum menggunakan server, API, maupun autentikasi pengguna.



Pemeriksaan izin kamera dan galeri pada perangkat Android masih perlu dilakukan secara langsung.



