import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/anggota_perpustakaan.dart';
import '../models/pengajuan_buku.dart';
import '../models/peminjaman_ringkas.dart';

class PerpustakaanService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';
  static const Duration _timeoutDuration = Duration(seconds: 10);

  // Endpoint 1: Mengambil daftar anggota perpustakaan (mahasiswa peminjam)
  static Future<List<AnggotaPerpustakaan>> ambilDaftarAnggota() async {
    final response = await http
        .get(Uri.parse('$_baseUrl/users'))
        .timeout(_timeoutDuration);

    if (response.statusCode != 200) {
      throw Exception(
          'Gagal memuat data anggota perpustakaan (HTTP ${response.statusCode})');
    }

    final List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;
    return jsonList
        .map((item) =>
            AnggotaPerpustakaan.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  // Endpoint 2: Mengambil daftar pengajuan peminjaman buku
  static Future<List<PengajuanBuku>> ambilDaftarPengajuanBuku() async {
    final response = await http
        .get(Uri.parse('$_baseUrl/posts'))
        .timeout(_timeoutDuration);

    if (response.statusCode != 200) {
      throw Exception(
          'Gagal memuat daftar pengajuan buku (HTTP ${response.statusCode})');
    }

    final List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;
    return jsonList
        .take(15)
        .map((item) => PengajuanBuku.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  // Menggabungkan data anggota dan pengajuan buku secara paralel dengan Future.wait
  static Future<List<PeminjamanRingkas>> ambilDataPeminjamanTerintegrasi() async {
    try {
      final hasil = await Future.wait([
        ambilDaftarAnggota(),
        ambilDaftarPengajuanBuku(),
      ]);

      final daftarAnggota = hasil[0] as List<AnggotaPerpustakaan>;
      final daftarPengajuan = hasil[1] as List<PengajuanBuku>;

      // Pemetaan userId -> AnggotaPerpustakaan untuk pencocokan O(1)
      final Map<int, AnggotaPerpustakaan> petaAnggota = {
        for (final anggota in daftarAnggota) anggota.id: anggota,
      };

      return daftarPengajuan.map((pengajuan) {
        final peminjam = petaAnggota[pengajuan.userId];
        return PeminjamanRingkas(
          id: pengajuan.id,
          namaPeminjam: peminjam?.nama ?? 'Anggota #${pengajuan.userId}',
          emailPeminjam: peminjam?.email ?? '-',
          judulBuku: pengajuan.judulBuku,
          status: pengajuan.status,
        );
      }).toList();
    } on TimeoutException {
      throw Exception('Koneksi waktu habis (timeout). Periksa jaringan Anda.');
    } catch (e) {
      throw Exception('Terjadi kesalahan integrasi data perpustakaan: $e');
    }
  }
}