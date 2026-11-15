// ============================================================================
// PAB — Tugas 10: Integrasi Data dan Proses Bisnis
// Service layer — seluruh request HTTP, parsing JSON, penggabungan data, dan
// aturan status berada di sini, bukan di widget.
// Domain project: Glazent.pro (usaha jasa glass cleaning & nanocoating)
// ============================================================================
//
// Bantuan: Claude — menyusun kerangka service integrasi (tiga endpoint,
// Future.wait, penggabungan berdasarkan identifier, aturan status) mengikuti
// materi Pertemuan 10, dengan konteks disesuaikan ke domain Glazent.pro.
//
// Endpoint (API simulasi publik):
//   GET /users            -> DataPelanggan  (nama pemesan)
//   GET /posts?_limit=20  -> DataPesanan    (pesanan)
//   GET /todos?_limit=12  -> DataProgres    (progres pekerjaan teknisi)
//
// Identifier penghubung:
//   DataPesanan.userId == DataPelanggan.id   (siapa pemesannya)
//   DataPesanan.id     == DataProgres.id     (progres pesanan yang mana)
// ============================================================================

import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;

import 'package:http/http.dart' as http;

import '../models/data_pelanggan.dart';
import '../models/data_pesanan.dart';
import '../models/data_progres.dart';
import '../models/pesanan_ringkas.dart';

/// Kegagalan komunikasi dengan server, dengan pesan siap tampil bagi pengguna
/// (tanpa stack trace) yang menyebutkan data mana yang gagal dimuat.
class ApiException implements Exception {
  const ApiException(this.pesan);

  final String pesan;

  @override
  String toString() => pesan;
}

class IntegrasiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';
  static const Duration _timeout = Duration(seconds: 10);

  /// Jeda buatan sebelum setiap request, hanya untuk pengujian. Ubah menjadi
  /// Duration(seconds: 3) untuk melihat indikator loading, lalu kembalikan ke
  /// Duration.zero.
  static const Duration jedaUji = Duration.zero;

  /// Tambahan filter pada request pesanan, hanya untuk pengujian. Isi dengan
  /// '&userId=999' untuk menghasilkan daftar kosong (uji kondisi kosong),
  /// lalu kembalikan menjadi ''.
  static const String _filterPesananUji = '';

  // --------------------------------------------------------------------------
  // Request per endpoint — masing-masing mengembalikan model Dart
  // --------------------------------------------------------------------------

  /// GET /users — data pelanggan pemesan.
  ///
  /// [klien] hanya dipakai pengujian untuk menyuntikkan klien HTTP tiruan.
  static Future<List<DataPelanggan>> ambilPelanggan({http.Client? klien}) {
    return _ambilDaftar(
      '/users',
      'pelanggan',
      DataPelanggan.fromJson,
      klien: klien,
    );
  }

  /// GET /posts — data pesanan.
  static Future<List<DataPesanan>> ambilPesanan({http.Client? klien}) {
    return _ambilDaftar(
      '/posts?_limit=20$_filterPesananUji',
      'pesanan',
      DataPesanan.fromJson,
      klien: klien,
    );
  }

  /// GET /todos — catatan progres pekerjaan teknisi. Dibatasi 12 data
  /// sehingga sebagian pesanan belum memiliki catatan progres.
  static Future<List<DataProgres>> ambilProgres({http.Client? klien}) {
    return _ambilDaftar(
      '/todos?_limit=12',
      'progres pekerjaan',
      DataProgres.fromJson,
      klien: klien,
    );
  }

  // --------------------------------------------------------------------------
  // Integrasi: Future.wait + penggabungan berdasarkan identifier
  // --------------------------------------------------------------------------

  /// Mengambil ketiga sumber data lalu menggabungkannya menjadi daftar ringkas.
  ///
  /// Ketiga request tidak saling bergantung (tidak ada yang membutuhkan hasil
  /// request lain sebagai masukan), sehingga dijalankan bersamaan dengan
  /// `Future.wait`. Waktu tunggu mengikuti request terlambat, bukan jumlah
  /// ketiganya. Bila salah satu gagal, seluruh proses gagal dengan pesan yang
  /// menyebutkan data yang gagal.
  static Future<List<PesananRingkas>> ambilDataTerintegrasi({
    http.Client? klien,
  }) async {
    final hasil = await Future.wait([
      ambilPelanggan(klien: klien),
      ambilPesanan(klien: klien),
      ambilProgres(klien: klien),
    ]);

    final pelanggan = hasil[0] as List<DataPelanggan>;
    final pesanan = hasil[1] as List<DataPesanan>;
    final progres = hasil[2] as List<DataProgres>;

    return gabungkan(pelanggan: pelanggan, pesanan: pesanan, progres: progres);
  }

  /// Menggabungkan tiga daftar menjadi daftar ringkas berdasarkan identifier:
  ///   - pesanan.userId -> pelanggan.id  (nama dan kota pemesan)
  ///   - pesanan.id     -> progres.id    (status proses)
  static List<PesananRingkas> gabungkan({
    required List<DataPelanggan> pelanggan,
    required List<DataPesanan> pesanan,
    required List<DataProgres> progres,
  }) {
    final pelangganById = {for (final p in pelanggan) p.id: p};
    final progresById = {for (final p in progres) p.id: p};

    return pesanan.map((item) {
      final pemesan = pelangganById[item.userId];
      return PesananRingkas(
        id: item.id,
        userId: item.userId,
        layanan: item.layanan,
        namaPelanggan: pemesan?.nama ?? 'Pelanggan tidak dikenal',
        kota: pemesan?.kota ?? '-',
        status: tentukanStatus(progresById[item.id]),
      );
    }).toList();
  }

  // --------------------------------------------------------------------------
  // Aturan proses bisnis
  // --------------------------------------------------------------------------

  /// Aturan status pesanan berdasarkan catatan progres teknisi:
  ///   - tidak ada catatan progres          -> menunggu
  ///   - ada catatan progres, belum selesai -> dijadwalkan
  ///   - ada catatan progres, sudah selesai -> selesai
  /// Aturan ini hanya berada di sini sehingga perubahan aturan cukup dilakukan
  /// pada satu tempat.
  static StatusPesanan tentukanStatus(DataProgres? progres) {
    if (progres == null) {
      return StatusPesanan.menunggu;
    }
    return progres.selesai ? StatusPesanan.selesai : StatusPesanan.dijadwalkan;
  }

  // --------------------------------------------------------------------------
  // Utilitas: GET daftar + parsing + penanganan error
  // --------------------------------------------------------------------------

  /// GET [path], memeriksa status code, mengurai JSON list menjadi model
  /// memakai [dariJson], dan menerjemahkan seluruh kegagalan menjadi
  /// [ApiException] yang menyebutkan [namaData].
  static Future<List<T>> _ambilDaftar<T>(
    String path,
    String namaData,
    T Function(Map<String, dynamic> json) dariJson, {
    http.Client? klien,
  }) async {
    try {
      final url = Uri.parse('$_baseUrl$path');
      await Future<void>.delayed(jedaUji);
      final response = await (klien == null ? http.get(url) : klien.get(url))
          .timeout(_timeout);

      if (response.statusCode == 200) {
        final List<dynamic> dataMentah =
            jsonDecode(response.body) as List<dynamic>;
        return dataMentah
            .map((item) => dariJson(item as Map<String, dynamic>))
            .toList();
      }
      throw ApiException(_pesanStatus(response.statusCode, namaData));
    } on ApiException {
      rethrow;
    } on TimeoutException {
      throw ApiException(
        'Waktu tunggu habis saat memuat data $namaData. '
        'Periksa koneksi internet Anda.',
      );
    } on http.ClientException {
      throw ApiException(
        'Tidak dapat terhubung ke server saat memuat data $namaData. '
        'Periksa koneksi internet Anda.',
      );
    } on FormatException {
      throw ApiException('Format data $namaData dari server tidak dikenali.');
    } catch (e) {
      // Detail error dicatat untuk debugging; pengguna hanya melihat pesan umum.
      developer.log(
        'Kesalahan tak terduga saat memuat data $namaData',
        name: 'IntegrasiService',
        error: e,
      );
      throw ApiException(
        'Terjadi kesalahan tak terduga saat memuat data $namaData.',
      );
    }
  }

  /// Menerjemahkan status code HTTP menjadi pesan yang mudah dipahami.
  static String _pesanStatus(int kode, String namaData) {
    if (kode == 404) {
      return 'Data $namaData tidak ditemukan di server (HTTP 404).';
    }
    if (kode >= 500) {
      return 'Server sedang bermasalah saat memuat data $namaData '
          '(HTTP $kode). Coba lagi nanti.';
    }
    return 'Permintaan data $namaData ditolak server (HTTP $kode).';
  }
}
