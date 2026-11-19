// Tugas 10 PAB: Integrasi Data dan Proses Bisnis
// Nama: Galih Permana Sidik | NIM 230660221002 | SI-VIIA
//
// Model data pelapor, hasil GET /users. Dalam SiLapor, pengguna adalah pihak
// yang membuat laporan. Identifier `id` dipakai untuk mencocokkan `userId`
// pada data laporan.

class DataPengguna {
  const DataPengguna({required this.id, required this.nama});

  final int id; // JSON "id", identifier penghubung dengan DataLaporan.userId
  final String nama; // JSON "name"

  factory DataPengguna.fromJson(Map<String, dynamic> json) {
    return DataPengguna(
      id: json['id'] as int? ?? 0,
      nama: json['name'] as String? ?? 'Tanpa nama',
    );
  }
}
