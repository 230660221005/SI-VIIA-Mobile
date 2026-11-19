// Tugas 10 PAB: Integrasi Data dan Proses Bisnis (service layer)
// Nama: Galih Permana Sidik | NIM 230660221002 | SI-VIIA
//
// Satu-satunya tempat kode HTTP, parsing JSON, penggabungan data, dan aturan
// status. Halaman memanggil ambilDataTerintegrasi() dan menerima
// List<LaporanRingkas>.
//
// Endpoint simulasi JSONPlaceholder:
//   GET /users  -> DataPengguna (pelapor)
//   GET /posts  -> DataLaporan  (laporan, memuat userId)
// Penghubung: DataLaporan.userId == DataPengguna.id
//
// Bantuan: Claude, menyusun kerangka Future.wait dan helper penanganan error.
// Pemilihan aturan status simulasi dan pengujian dilakukan oleh penulis.

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/data_laporan.dart';
import '../models/data_pengguna.dart';
import '../models/laporan_ringkas.dart';

/// Kegagalan dengan pesan yang siap ditampilkan kepada pengguna.
class ApiException implements Exception {
  const ApiException(this.pesan);

  final String pesan;

  @override
  String toString() => pesan;
}

class IntegrasiService {
  static const String _host = 'jsonplaceholder.typicode.com';
  static const String _jalurPengguna = '/users';

  // Untuk skenario error: ubah menjadi '/postsx' (server membalas 404).
  static const String _jalurLaporan = '/posts';

  static const Duration _batasWaktu = Duration(seconds: 10);

  // Alat bantu skenario uji. Kembalikan ke nilai awal sebelum mengumpulkan.
  // Loading: isi 3 agar indikator tampil 3 detik.
  static const int jedaSimulasiDetik = 0;
  // Data kosong: isi 999, server membalas list kosong karena tidak ada
  // laporan milik userId 999. Nilai 0 berarti tanpa filter.
  static const int filterUserId = 0;

  /// GET /users: daftar pelapor.
  static Future<List<DataPengguna>> ambilPengguna() {
    return _jalankan(() async {
      final data = await _ambilList(_jalurPengguna);
      return data
          .whereType<Map<String, dynamic>>()
          .map(DataPengguna.fromJson)
          .toList();
    });
  }

  /// GET /posts: daftar laporan (maksimal 20 data, pagination di luar cakupan).
  static Future<List<DataLaporan>> ambilLaporan() {
    return _jalankan(() async {
      final query = <String, String>{'_limit': '20'};
      if (filterUserId > 0) {
        query['userId'] = '$filterUserId';
      }
      final data = await _ambilList(_jalurLaporan, query: query);
      return data
          .whereType<Map<String, dynamic>>()
          .map(DataLaporan.fromJson)
          .toList();
    });
  }

  /// Mengambil dua endpoint, lalu menggabungkannya berdasarkan userId.
  ///
  /// Future.wait dipakai karena kedua request tidak saling bergantung: URL
  /// /posts tidak membutuhkan hasil /users. Keduanya berjalan bersamaan,
  /// sehingga waktu tunggu mengikuti request yang paling lambat, bukan jumlah
  /// keduanya. Bila salah satu gagal, seluruh pemuatan dianggap gagal, sebab
  /// daftar tanpa nama pelapor tidak lengkap bagi petugas.
  static Future<List<LaporanRingkas>> ambilDataTerintegrasi() async {
    if (jedaSimulasiDetik > 0) {
      await Future.delayed(const Duration(seconds: jedaSimulasiDetik));
    }

    final hasil = await Future.wait([ambilPengguna(), ambilLaporan()]);
    final pengguna = hasil[0] as List<DataPengguna>;
    final laporan = hasil[1] as List<DataLaporan>;

    final namaPerId = {for (final p in pengguna) p.id: p.nama};

    return laporan.map((l) {
      return LaporanRingkas(
        id: l.id,
        judul: l.judul,
        deskripsi: l.deskripsi,
        namaPelapor: namaPerId[l.userId] ?? 'Pelapor tidak dikenal',
        status: l.statusDariServer ? l.status : _statusSimulasi(l.id),
      );
    }).toList();
  }

  /// Aturan status untuk data simulasi, karena /posts tidak punya field status.
  /// Kelipatan 5 dianggap Selesai, kelipatan 2 Diproses, sisanya Menunggu.
  /// Dengan backend SiLapor, aturan ini dihapus dan status diambil dari server.
  static StatusLaporan _statusSimulasi(int id) {
    if (id % 5 == 0) return StatusLaporan.selesai;
    if (id % 2 == 0) return StatusLaporan.diproses;
    return StatusLaporan.menunggu;
  }

  /// GET satu jalur, memeriksa status 200, dan memastikan isinya berupa list.
  static Future<List<dynamic>> _ambilList(
    String jalur, {
    Map<String, String>? query,
  }) async {
    final response = await http.get(Uri.https(_host, jalur, query));

    if (response.statusCode != 200) {
      throw _kesalahanStatus(response.statusCode);
    }

    final data = jsonDecode(response.body);
    if (data is! List) {
      throw const ApiException('Format data dari server tidak sesuai.');
    }
    return data;
  }

  /// Membungkus request dengan timeout dan try-catch, lalu mengubah semua
  /// kegagalan menjadi ApiException. Dart Web tidak punya dart:io, jadi
  /// koneksi putus ditangkap sebagai http.ClientException.
  static Future<T> _jalankan<T>(Future<T> Function() aksi) async {
    try {
      return await aksi().timeout(_batasWaktu);
    } on ApiException {
      rethrow;
    } on TimeoutException {
      throw const ApiException(
        'Waktu tunggu habis. Periksa jaringan Anda, lalu coba lagi.',
      );
    } on http.ClientException {
      throw const ApiException(
        'Tidak dapat terhubung ke server. Pastikan perangkat terhubung ke internet.',
      );
    } on FormatException {
      throw const ApiException(
        'Data dari server tidak dapat dibaca (format JSON tidak valid).',
      );
    } catch (_) {
      // Detail teknis tidak ditampilkan ke pengguna.
      throw const ApiException('Terjadi kegagalan yang tidak terduga. Coba lagi.');
    }
  }

  static ApiException _kesalahanStatus(int kode) {
    if (kode == 400) {
      return const ApiException('Permintaan tidak valid (400).');
    }
    if (kode == 404) {
      return const ApiException(
        'Data laporan tidak ditemukan di server (404). Periksa alamat endpoint.',
      );
    }
    if (kode >= 500) {
      return ApiException(
        'Server sedang bermasalah (kode $kode). Coba lagi beberapa saat lagi.',
      );
    }
    return ApiException('Server mengembalikan kode yang tidak diharapkan: $kode.');
  }
}
