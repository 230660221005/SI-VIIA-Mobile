class PeminjamanRingkas {
  const PeminjamanRingkas({
    required this.id,
    required this.namaPeminjam,
    required this.emailPeminjam,
    required this.judulBuku,
    required this.status,
  });

  final int id;
  final String namaPeminjam;
  final String emailPeminjam;
  final String judulBuku;
  final String status;
}