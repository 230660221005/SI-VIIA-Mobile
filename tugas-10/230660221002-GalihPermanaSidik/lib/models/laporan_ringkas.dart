// Tugas 10 PAB: Integrasi Data dan Proses Bisnis
// Nama: Galih Permana Sidik | NIM 230660221002 | SI-VIIA
//
// Model tampilan (view model): hasil gabungan DataLaporan dan DataPengguna.
// Halaman hanya menerima model ini, bukan JSON mentah dan bukan dua model
// terpisah.

import 'data_laporan.dart';

class LaporanRingkas {
  const LaporanRingkas({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.namaPelapor,
    required this.status,
  });

  final int id;
  final String judul;
  final String deskripsi;
  final String namaPelapor; // dari DataPengguna.nama, dicocokkan lewat userId
  final StatusLaporan status;
}
