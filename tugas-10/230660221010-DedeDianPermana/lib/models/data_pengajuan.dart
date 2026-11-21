
class DataPengajuan {
  final int id;
  final int userId;
  final String namaPengguna;
  final String judul;
  final String deskripsi;

  DataPengajuan({
    required this.id,
    required this.userId,
    this.namaPengguna = 'Tidak diketahui',
    required this.judul,
    required this.deskripsi,
  });

  factory DataPengajuan.fromJson(Map<String, dynamic> json) {
    return DataPengajuan(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      namaPengguna: 'Tidak diketahui',
      judul: json['title'] ?? 'Pengajuan tanpa judul',
      deskripsi: json['body'] ?? '-',
    );
  }

  DataPengajuan copyWith({
  String? namaPengguna,
  String? judul,
  String? deskripsi,
}) {
  return DataPengajuan(
    id: id,
    userId: userId,
    namaPengguna: namaPengguna ?? this.namaPengguna,
    judul: judul ?? this.judul,
    deskripsi: deskripsi ?? this.deskripsi,
  );
}
}
