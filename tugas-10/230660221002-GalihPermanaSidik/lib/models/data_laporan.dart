// Tugas 10 PAB: Integrasi Data dan Proses Bisnis
// Nama: Galih Permana Sidik | NIM 230660221002 | SI-VIIA
//
// Model laporan kerusakan, hasil GET /posts, serta enum status proses.
// Status laporan mengikuti alur SiLapor: Menunggu, Diproses, Selesai.

enum StatusLaporan { menunggu, diproses, selesai }

extension StatusLaporanLabel on StatusLaporan {
  String get label {
    switch (this) {
      case StatusLaporan.menunggu:
        return 'Menunggu';
      case StatusLaporan.diproses:
        return 'Diproses';
      case StatusLaporan.selesai:
        return 'Selesai';
    }
  }
}

/// Aturan pemetaan teks status dari server ke enum. Nilai yang tidak dikenal
/// atau kosong dianggap Menunggu, yaitu status awal laporan baru (F-01).
/// Aturan ini hanya ada di sini agar perubahan status dicek pada satu tempat.
StatusLaporan statusDariJson(String? nilai) {
  switch (nilai?.toLowerCase()) {
    case 'diproses':
      return StatusLaporan.diproses;
    case 'selesai':
      return StatusLaporan.selesai;
    default:
      return StatusLaporan.menunggu;
  }
}

class DataLaporan {
  const DataLaporan({
    required this.id,
    required this.userId,
    required this.judul,
    required this.deskripsi,
    required this.status,
    required this.statusDariServer,
  });

  final int id; // JSON "id"
  final int userId; // JSON "userId", identifier penghubung ke DataPengguna.id
  final String judul; // JSON "title"
  final String deskripsi; // JSON "body"
  final StatusLaporan status; // JSON "status", bila ada
  final bool statusDariServer; // false bila server tidak mengirim field status

  factory DataLaporan.fromJson(Map<String, dynamic> json) {
    return DataLaporan(
      id: json['id'] as int? ?? 0,
      userId: json['userId'] as int? ?? 0,
      judul: json['title'] as String? ?? 'Tanpa judul',
      deskripsi: json['body'] as String? ?? '-',
      status: statusDariJson(json['status'] as String?),
      statusDariServer: json['status'] is String,
    );
  }
}
