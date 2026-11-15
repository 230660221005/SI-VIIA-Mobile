// ============================================================================
// PAB — Tugas 10: Integrasi Data dan Proses Bisnis
// Berkas: data_progres.dart — model progres pekerjaan teknisi (GET /todos)
// Domain project: Glazent.pro (usaha jasa glass cleaning & nanocoating)
// ============================================================================
//
// Pemetaan field:
//   id      <- id         (identifier penghubung ke DataPesanan.id)
//   selesai <- completed  (true = pekerjaan sudah selesai)
// ============================================================================

class DataProgres {
  const DataProgres({required this.id, required this.selesai});

  final int id;
  final bool selesai;

  /// Mengubah Map hasil jsonDecode menjadi objek DataProgres. Nilai default
  /// (`??`) menjaga aplikasi tetap berjalan bila struktur JSON tidak lengkap.
  factory DataProgres.fromJson(Map<String, dynamic> json) {
    return DataProgres(
      id: json['id'] as int? ?? 0,
      selesai: json['completed'] as bool? ?? false,
    );
  }
}
