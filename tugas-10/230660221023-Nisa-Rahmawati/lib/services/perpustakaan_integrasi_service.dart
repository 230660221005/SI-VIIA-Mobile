import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/anggota_model.dart';
import '../models/detail_peminjaman_model.dart';
import '../models/peminjaman_model.dart';

class PerpustakaanIntegrasiService {
  static const String _usersUrl = 'https://jsonplaceholder.typicode.com/users';
  static const String _todosUrl = 'https://jsonplaceholder.typicode.com/todos';
  static const String _invalidUrl =
      'https://jsonplaceholder.typicode.com/endpoint-tidak-valid';
  static const Duration _timeoutDuration = Duration(seconds: 10);

  /// Request 1: Mengambil daftar master anggota/mahasiswa perpustakaan
  Future<List<AnggotaModel>> ambilDaftarAnggota({
    bool simulasiError = false,
  }) async {
    final Uri url = Uri.parse(simulasiError ? _invalidUrl : _usersUrl);

    try {
      final response = await http.get(url).timeout(_timeoutDuration);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList =
            jsonDecode(response.body) as List<dynamic>;
        return jsonList
            .map((item) => AnggotaModel.fromJson(item as Map<String, dynamic>))
            .toList();
      } else if (response.statusCode == 404) {
        throw Exception('Endpoint data anggota tidak ditemukan (HTTP 404).');
      } else {
        throw Exception(
            'Gagal memuat data anggota (HTTP ${response.statusCode}).');
      }
    } on TimeoutException {
      throw Exception(
          'Waktu tunggu server habis (Timeout 10 detik) saat memuat anggota.');
    } on http.ClientException {
      throw Exception(
          'Koneksi jaringan bermasalah saat menghubungi server anggota.');
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  /// Request 2: Mengambil daftar transaksi peminjaman buku
  Future<List<PeminjamanModel>> ambilDaftarPeminjaman({
    bool simulasiError = false,
  }) async {
    final Uri url = Uri.parse(simulasiError ? _invalidUrl : _todosUrl);

    try {
      final response = await http.get(url).timeout(_timeoutDuration);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList =
            jsonDecode(response.body) as List<dynamic>;
        return jsonList
            .map((item) =>
                PeminjamanModel.fromJson(item as Map<String, dynamic>))
            .toList();
      } else if (response.statusCode == 404) {
        throw Exception(
            'Endpoint transaksi peminjaman tidak ditemukan (HTTP 404).');
      } else {
        throw Exception(
            'Gagal memuat data peminjaman (HTTP ${response.statusCode}).');
      }
    } on TimeoutException {
      throw Exception(
          'Waktu tunggu server habis (Timeout 10 detik) saat memuat peminjaman.');
    } on http.ClientException {
      throw Exception(
          'Koneksi jaringan bermasalah saat menghubungi server peminjaman.');
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  /// Integrasi Data: Menjalankan kedua request secara paralel dengan Future.wait
  /// lalu menggabungkan hasilnya berdasarkan identifier `userId`.
  Future<List<DetailPeminjamanModel>> ambilDataPeminjamanTerintegrasi({
    bool simulasiError = false,
    bool simulasiKosong = false,
  }) async {
    final hasilParalel = await Future.wait([
      ambilDaftarAnggota(simulasiError: simulasiError),
      ambilDaftarPeminjaman(simulasiError: simulasiError),
    ]);

    if (simulasiKosong) {
      return [];
    }

    final List<AnggotaModel> daftarAnggota =
        hasilParalel[0] as List<AnggotaModel>;
    final List<PeminjamanModel> daftarPeminjaman =
        hasilParalel[1] as List<PeminjamanModel>;

    // Indeks anggota dalam Map berdasarkan id untuk pencocokan cepat O(1)
    final Map<int, AnggotaModel> petaAnggota = {
      for (final anggota in daftarAnggota) anggota.id: anggota,
    };

    // Ambil 20 transaksi lintas anggota lalu gabungkan berdasarkan userId
    final List<PeminjamanModel> transaksiTerpilih = daftarPeminjaman
        .where((item) => item.id % 10 == 1 || item.id % 10 == 2)
        .take(20)
        .toList();

    return transaksiTerpilih.map((peminjaman) {
      final AnggotaModel? anggotaCocok = petaAnggota[peminjaman.userId];
      return DetailPeminjamanModel.gabungkan(
        peminjaman: peminjaman,
        anggota: anggotaCocok,
      );
    }).toList();
  }
}