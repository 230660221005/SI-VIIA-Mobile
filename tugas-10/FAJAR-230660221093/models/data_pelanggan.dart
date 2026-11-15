// ============================================================================
// PAB — Tugas 10: Integrasi Data dan Proses Bisnis
// Berkas: data_pelanggan.dart — model data pelanggan (GET /users)
// Domain project: Glazent.pro (usaha jasa glass cleaning & nanocoating)
// ============================================================================
//
// Hanya tiga field yang dipakai proses bisnis:
//   id    <- id            (identifier penghubung ke DataPesanan.userId)
//   nama  <- name          (nama pemesan)
//   kota  <- address.city  (kota pemesan, field bersarang)
// ============================================================================

class DataPelanggan {
  const DataPelanggan({
    required this.id,
    required this.nama,
    required this.kota,
  });

  final int id;
  final String nama;
  final String kota;

  /// Mengubah Map hasil jsonDecode menjadi objek DataPelanggan. Nilai default
  /// (`??`) menjaga aplikasi tetap berjalan bila struktur JSON tidak lengkap.
  factory DataPelanggan.fromJson(Map<String, dynamic> json) {
    final alamat = json['address'];
    final kota = alamat is Map<String, dynamic>
        ? alamat['city'] as String? ?? '-'
        : '-';

    return DataPelanggan(
      id: json['id'] as int? ?? 0,
      nama: json['name'] as String? ?? 'Tanpa Nama',
      kota: kota,
    );
  }
}
