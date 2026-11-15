// ============================================================================
// PAB — Tugas 10: Integrasi Data dan Proses Bisnis
// Berkas: data_pesanan.dart — model data pesanan (GET /posts)
// Domain project: Glazent.pro (usaha jasa glass cleaning & nanocoating)
// ============================================================================
//
// Pemetaan field:
//   id      <- id      (identifier penghubung ke DataProgres.id)
//   userId  <- userId  (identifier penghubung ke DataPelanggan.id)
//   layanan <- title   (jenis layanan yang dipesan)
//
// Field `body` tidak dipakai karena tidak dibutuhkan proses bisnis.
// ============================================================================

class DataPesanan {
  const DataPesanan({
    required this.id,
    required this.userId,
    required this.layanan,
  });

  final int id;
  final int userId;
  final String layanan;

  /// Mengubah Map hasil jsonDecode menjadi objek DataPesanan. Nilai default
  /// (`??`) menjaga aplikasi tetap berjalan bila struktur JSON tidak lengkap.
  factory DataPesanan.fromJson(Map<String, dynamic> json) {
    return DataPesanan(
      id: json['id'] as int? ?? 0,
      userId: json['userId'] as int? ?? 0,
      layanan: json['title'] as String? ?? 'Tanpa Nama Layanan',
    );
  }
}
