
import 'dart:convert';
import 'package:http/http.dart' as http;

// Model untuk menampung data laporan dari API
class LaporanApi {
  final int id;
  final int userId;
  final String title;
  final String body;

  LaporanApi({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  // Mengubah data JSON menjadi objek Dart
  factory LaporanApi.fromJson(Map<String, dynamic> json) {
    return LaporanApi(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
    );
  }
}

// Service untuk mengakses REST API
class ServiceApi {
  static const String baseUrl =
      'https://jsonplaceholder.typicode.com';

  // GET: Mengambil daftar data laporan
  Future<List<LaporanApi>> getLaporan() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/posts?_limit=10'))
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        return data
            .map((item) => LaporanApi.fromJson(item))
            .toList();
      } else {
        throw Exception(
          'Gagal mengambil data. Kode: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan saat mengambil data: $e');
    }
  }

  // POST: Mengirim laporan baru
  Future<LaporanApi> kirimLaporan({
    required String judul,
    required String keterangan,
    required int userId,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/posts'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'title': judul,
              'body': keterangan,
              'userId': userId,
            }),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return LaporanApi.fromJson(data);
      } else {
        throw Exception(
          'Gagal mengirim laporan. Kode: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan saat mengirim laporan: $e');
    }
  }
}
