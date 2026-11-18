import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/data_pengguna.dart';
import '../models/data_pengajuan.dart';

class DataPengajuanGabungan {
  final DataPengajuan pengajuan;
  final String namaPengguna;

  DataPengajuanGabungan({
    required this.pengajuan,
    required this.namaPengguna,
  });
}

class IntegrasiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // GET: Mengambil dan menggabungkan data pengguna dan pengajuan.
  Future<List<DataPengajuanGabungan>> ambilDataGabungan() async {
    try {
      final hasil = await Future.wait([
        http.get(Uri.parse('$baseUrl/users')).timeout(
              const Duration(seconds: 15),
            ),
        http.get(Uri.parse('$baseUrl/posts?_limit=10')).timeout(
              const Duration(seconds: 15),
            ),
      ]);

      if (hasil[0].statusCode != 200 || hasil[1].statusCode != 200) {
        throw Exception('Gagal mengambil data dari server.');
      }

      final List<dynamic> jsonPengguna = jsonDecode(hasil[0].body);
      final List<dynamic> jsonPengajuan = jsonDecode(hasil[1].body);

      final pengguna =
          jsonPengguna.map((json) => DataPengguna.fromJson(json)).toList();

      final pengajuan =
          jsonPengajuan.map((json) => DataPengajuan.fromJson(json)).toList();

      final List<DataPengajuanGabungan> dataGabungan = [];

      for (final item in pengajuan) {
        final pemilik = pengguna.where(
          (user) => user.id == item.userId,
        );

        if (pemilik.isNotEmpty) {
          dataGabungan.add(
            DataPengajuanGabungan(
              pengajuan: item,
              namaPengguna: pemilik.first.nama,
            ),
          );
        }
      }

      return dataGabungan;
    } catch (e) {
      throw Exception('Terjadi kesalahan saat integrasi data: $e');
    }
  }

  // POST: Mengirim data pengajuan baru.
  Future<DataPengajuan> kirimPengajuan({
    required int userId,
    required String judul,
    required String deskripsi,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/posts'),
            headers: {'Content-Type': 'application/json; charset=UTF-8'},
            body: jsonEncode({
              'userId': userId,
              'title': judul,
              'body': deskripsi,
            }),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode != 201) {
        throw Exception('Gagal mengirim pengajuan.');
      }

      final Map<String, dynamic> hasil = jsonDecode(response.body);
      return DataPengajuan.fromJson(hasil);
    } catch (e) {
      throw Exception('Terjadi kesalahan saat mengirim pengajuan: $e');
    }
  }
}
