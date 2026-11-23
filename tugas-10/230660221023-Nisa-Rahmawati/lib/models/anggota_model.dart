class AnggotaModel {
  final int id;
  final String nama;
  final String nim;
  final String email;
  final String prodi;

  const AnggotaModel({
    required this.id,
    required this.nama,
    required this.nim,
    required this.email,
    required this.prodi,
  });

  factory AnggotaModel.fromJson(Map<String, dynamic> json) {
    final int parsedId = json['id'] as int? ?? 0;
    final Map<String, dynamic>? company =
        json['company'] as Map<String, dynamic>?;

    // Pemetaan username dari API menjadi format NIM kampus yang rapi
    final String nimDefault =
        '23066022${parsedId.toString().padLeft(4, '0')}';

    return AnggotaModel(
      id: parsedId,
      nama: (json['name'] as String?)?.trim().isNotEmpty == true
          ? json['name'] as String
          : 'Mahasiswa Tanpa Nama',
      nim: json['nim'] as String? ?? nimDefault,
      email: (json['email'] as String?)?.trim().isNotEmpty == true
          ? json['email'] as String
          : 'anggota$parsedId@kampus.ac.id',
      prodi: company?['name'] as String? ?? 'Sistem Informasi',
    );
  }
}