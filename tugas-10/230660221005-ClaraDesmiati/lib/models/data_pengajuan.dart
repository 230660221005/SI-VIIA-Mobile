class DataPengajuan {
  final int id;
  final int userId;
  final String judul;
  final String deskripsi;
  final String status;

  DataPengajuan({
    required this.id,
    required this.userId,
    required this.judul,
    required this.deskripsi,
    required this.status,
  });

  factory DataPengajuan.fromJson(Map<String, dynamic> json) {
    return DataPengajuan(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      judul: json['title'] ?? 'Tanpa Judul',
      deskripsi: json['body'] ?? 'Tidak ada deskripsi',
      status: 'Menunggu',
    );
  }
}