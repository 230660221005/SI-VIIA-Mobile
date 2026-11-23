class PeminjamanModel {
  final int id;
  final int userId;
  final String judulBuku;
  final bool sudahKembali;
  final String statusPeminjaman;

  const PeminjamanModel({
    required this.id,
    required this.userId,
    required this.judulBuku,
    required this.sudahKembali,
    required this.statusPeminjaman,
  });

  factory PeminjamanModel.fromJson(Map<String, dynamic> json) {
    final int parsedId = json['id'] as int? ?? 0;
    final int parsedUserId = json['userId'] as int? ?? 0;
    final bool isCompleted = json['completed'] as bool? ?? false;

    const daftarKatalogBuku = [
      'Analisis dan Perancangan Sistem Informasi',
      'Pemrograman Aplikasi Bergerak dengan Flutter',
      'Manajemen Basis Data Relasional',
      'Rekayasa Perangkat Lunak Berorientasi Objek',
      'Jaringan Komputer dan Keamanan Siber',
      'Interaksi Manusia dan Komputer',
      'Algoritma dan Struktur Data Lanjut',
      'Sistem Pendukung Keputusan',
      'Tata Kelola Teknologi Informasi',
      'Metodologi Penelitian Sistem Informasi',
    ];

    final String judulFallback = parsedId > 0
        ? daftarKatalogBuku[(parsedId - 1) % daftarKatalogBuku.length]
        : (json['title'] as String? ?? 'Buku Perpustakaan Umum');

    return PeminjamanModel(
      id: parsedId,
      userId: parsedUserId,
      judulBuku: json['judulBuku'] as String? ?? judulFallback,
      sudahKembali: isCompleted,
      statusPeminjaman: isCompleted ? 'Sudah Dikembalikan' : 'Sedang Dipinjam',
    );
  }
}