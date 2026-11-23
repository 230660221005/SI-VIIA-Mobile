class PengajuanBuku {
  const PengajuanBuku({
    required this.id,
    required this.userId,
    required this.judulBuku,
    required this.catatanKeperluan,
    required this.status,
  });

  final int id;
  final int userId;
  final String judulBuku;
  final String catatanKeperluan;
  final String status;

  factory PengajuanBuku.fromJson(Map<String, dynamic> json) {
    final rawId = json['id'] as int? ?? 0;
    // Simulasi status pengajuan peminjaman buku dari API publik
    final statusSimulasi = rawId % 3 == 0
        ? 'disetujui'
        : (rawId % 3 == 1 ? 'menunggu' : 'ditolak');

    return PengajuanBuku(
      id: rawId,
      userId: json['userId'] as int? ?? 0,
      judulBuku: json['title'] as String? ?? 'Judul Buku Tidak Tersedia',
      catatanKeperluan: json['body'] as String? ?? '-',
      status: json['status'] as String? ?? statusSimulasi,
    );
  }
}