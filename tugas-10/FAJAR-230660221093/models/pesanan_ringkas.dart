// ============================================================================
// PAB — Tugas 10: Integrasi Data dan Proses Bisnis
// Berkas: pesanan_ringkas.dart — model tampilan hasil penggabungan tiga sumber
// Domain project: Glazent.pro (usaha jasa glass cleaning & nanocoating)
// ============================================================================
//
// Model ini tidak dibuat langsung dari JSON. Objeknya dibentuk oleh
// IntegrasiService.gabungkan() dari DataPesanan, DataPelanggan, dan
// DataProgres.
// ============================================================================

/// Status proses sebuah pesanan — hasil aturan bisnis pada
/// IntegrasiService.tentukanStatus.
enum StatusPesanan {
  menunggu('Menunggu'),
  dijadwalkan('Dijadwalkan'),
  selesai('Selesai');

  const StatusPesanan(this.label);

  /// Label siap tampil pada antarmuka.
  final String label;
}

/// Satu baris pesanan yang sudah digabungkan: data pesanan, data pelanggan
/// pemesan, dan status prosesnya.
class PesananRingkas {
  const PesananRingkas({
    required this.id,
    required this.userId,
    required this.layanan,
    required this.namaPelanggan,
    required this.kota,
    required this.status,
  });

  final int id;
  final int userId;
  final String layanan;
  final String namaPelanggan;
  final String kota;
  final StatusPesanan status;
}
