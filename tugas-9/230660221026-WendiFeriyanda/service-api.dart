import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

/// Model buku SI RAKUS untuk latihan konsumsi REST API.
class DataBuku {
  const DataBuku({
    required this.id,
    required this.judul,
    required this.penulis,
    required this.penerbit,
    required this.tahunTerbit,
    required this.kategori,
    required this.ringkasan,
    required this.stok,
  });

  final String id;
  final String judul;
  final String penulis;
  final String penerbit;
  final int tahunTerbit;
  final String kategori;
  final String ringkasan;
  final int stok;

  String get status => stok > 0 ? 'Tersedia' : 'Stok habis';

  /// Mengubah response JSON API menjadi objek DataBuku.
  /// Bentuk response simulasi: {id, name, data: {...}}.
  factory DataBuku.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];
    final data = rawData is Map
        ? Map<String, dynamic>.from(rawData)
        : <String, dynamic>{};

    final tahun = data['tahunTerbit'];
    final jumlahStok = data['stok'];

    return DataBuku(
      id: json['id']?.toString() ?? '',
      judul: json['name']?.toString() ?? '-',
      penulis: data['penulis']?.toString() ?? '-',
      penerbit: data['penerbit']?.toString() ?? '-',
      tahunTerbit: tahun is num
          ? tahun.toInt()
          : int.tryParse(tahun?.toString() ?? '') ?? 0,
      kategori: data['kategori']?.toString() ?? '-',
      ringkasan: data['ringkasan']?.toString() ?? '-',
      stok: jumlahStok is num
          ? jumlahStok.toInt()
          : int.tryParse(jumlahStok?.toString() ?? '') ?? 0,
    );
  }

  /// Mengubah objek DataBuku ke format body JSON API simulasi.
  /// ID tidak dikirim karena akan dibuat oleh server.
  Map<String, dynamic> toApiJson() {
    return {
      'name': judul,
      'data': {
        'jenisData': 'buku',
        'penulis': penulis,
        'penerbit': penerbit,
        'tahunTerbit': tahunTerbit,
        'kategori': kategori,
        'ringkasan': ringkasan,
        'stok': stok,
      },
    };
  }
}

/// Service untuk memisahkan request HTTP dari widget antarmuka.
class BukuApiService {
  static final Uri _url = Uri.parse(
    'https://api.restful-api.dev/objects',
  );

  static const Duration _batasWaktu = Duration(seconds: 10);

  /// GET: mengambil daftar objek dan menyaring data bertanda jenisData=buku.
  Future<List<DataBuku>> ambilKatalog() async {
    try {
      final response = await http.get(_url).timeout(_batasWaktu);

      if (response.statusCode != 200) {
        throw Exception(
          'Gagal mengambil katalog. Kode HTTP: ${response.statusCode}',
        );
      }

      final decoded = jsonDecode(response.body);
      if (decoded is! List) {
        throw const FormatException('Format daftar katalog tidak sesuai.');
      }

      final daftar = <DataBuku>[];
      for (final item in decoded) {
        if (item is! Map) continue;
        final jsonItem = Map<String, dynamic>.from(item);
        final rawData = jsonItem['data'];
        if (rawData is Map && rawData['jenisData'] == 'buku') {
          daftar.add(DataBuku.fromJson(jsonItem));
        }
      }
      return daftar;
    } on TimeoutException {
      throw Exception('Waktu tunggu habis. Periksa jaringan lalu coba lagi.');
    } on FormatException catch (error) {
      throw Exception('Format response tidak valid: $error');
    } catch (error) {
      throw Exception('Terjadi kesalahan saat mengambil katalog: $error');
    }
  }

  /// POST: mengirim data buku contoh ke API simulasi.
  Future<DataBuku> kirimBuku(DataBuku buku) async {
    try {
      final response = await http
          .post(
            _url,
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(buku.toApiJson()),
          )
          .timeout(_batasWaktu);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(
          'Gagal mengirim data. Kode HTTP: ${response.statusCode}',
        );
      }

      final decoded = jsonDecode(response.body);
      if (decoded is! Map) {
        throw const FormatException('Format response POST tidak sesuai.');
      }

      return DataBuku.fromJson(Map<String, dynamic>.from(decoded));
    } on TimeoutException {
      throw Exception('Waktu pengiriman habis. Silakan coba lagi.');
    } on FormatException catch (error) {
      throw Exception('Format response tidak valid: $error');
    } catch (error) {
      throw Exception('Terjadi kesalahan saat mengirim buku: $error');
    }
  }
}
