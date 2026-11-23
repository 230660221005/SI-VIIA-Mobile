class AnggotaPerpustakaan {
  const AnggotaPerpustakaan({
    required this.id,
    required this.nama,
    required this.email,
  });

  final int id;
  final String nama;
  final String email;

  factory AnggotaPerpustakaan.fromJson(Map<String, dynamic> json) {
    return AnggotaPerpustakaan(
      id: json['id'] as int? ?? 0,
      nama: json['name'] as String? ?? 'Mahasiswa Tidak Diketahui',
      email: json['email'] as String? ?? '-',
    );
  }
}