import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/data_user.dart';
import '../models/data_pengajuan.dart';

class IntegrasiService {
  static const String baseUrl =
      'https://jsonplaceholder.typicode.com';

  // Mengambil data pengguna.
  Future<List<DataUser>> getDataUser() async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/users'),
            headers: {'Accept': 'application/json'},
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        return data
            .map((json) => DataUser.fromJson(json))
            .toList();
      } else {
        throw Exception(
          'Gagal mengambil data pengguna. Kode HTTP: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan mengambil data pengguna: $e');
    }
  }

  // Mengambil data pengajuan.
  Future<List<DataPengajuan>> getDataPengajuan() async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/posts'),
            headers: {'Accept': 'application/json'},
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        return data
            .map((json) => DataPengajuan.fromJson(json))
            .toList();
      } else {
        throw Exception(
          'Gagal mengambil data pengajuan. Kode HTTP: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan mengambil data pengajuan: $e');
    }
  }

  // Menggabungkan data pengguna dan pengajuan.
  Future<List<DataPengajuan>> integrasiData() async {
    try {
      final hasil = await Future.wait([
        getDataUser(),
        getDataPengajuan(),
      ]);

      final List<DataUser> users = hasil[0] as List<DataUser>;
      final List<DataPengajuan> pengajuan =
          hasil[1] as List<DataPengajuan>;

      // Nama pengguna dalam bahasa Indonesia berdasarkan ID API.
      final Map<int, String> daftarNamaIndonesia = {
        1: 'Andi Saputra',
        2: 'Budi Santoso',
        3: 'Citra Lestari',
        4: 'Dewi Anggraini',
        5: 'Eko Pratama',
        6: 'Fitri Handayani',
        7: 'Gilang Ramadhan',
        8: 'Hana Permata',
        9: 'Indra Wijaya',
        10: 'Siti Nurhaliza',
      };

      // Judul pengajuan dalam bahasa Indonesia berdasarkan ID.
      final Map<int, String> daftarJudul = {
        1: 'Permohonan Peminjaman Ruang Kelas',
        2: 'Pengajuan Ruang Diskusi Mahasiswa',
        3: 'Peminjaman Laboratorium Komputer',
        4: 'Permohonan Ruang Kegiatan Organisasi',
        5: 'Pengajuan Ruang Seminar',
        6: 'Peminjaman Ruang Rapat',
        7: 'Permohonan Ruang Presentasi',
        8: 'Pengajuan Ruang Praktikum',
        9: 'Peminjaman Ruang Belajar',
        10: 'Permohonan Ruang Kegiatan Akademik',
      };

      // Deskripsi pengajuan dalam bahasa Indonesia berdasarkan ID.
      final Map<int, String> daftarDeskripsi = {
        1: 'Mahasiswa mengajukan peminjaman ruang kelas untuk kegiatan perkuliahan.',
        2: 'Ruang diajukan untuk kegiatan diskusi dan kerja kelompok mahasiswa.',
        3: 'Laboratorium komputer dibutuhkan untuk kegiatan praktikum.',
        4: 'Ruang diperlukan untuk pelaksanaan kegiatan organisasi mahasiswa.',
        5: 'Ruang seminar diajukan untuk kegiatan presentasi dan diskusi.',
        6: 'Peminjaman ruang rapat diajukan untuk koordinasi kegiatan kelompok.',
        7: 'Ruang presentasi dibutuhkan untuk menyampaikan hasil tugas.',
        8: 'Ruang praktikum diajukan untuk mendukung kegiatan pembelajaran.',
        9: 'Ruang belajar dibutuhkan untuk kegiatan belajar bersama.',
        10: 'Ruang diajukan untuk mendukung pelaksanaan kegiatan akademik.',
      };

      // Menggabungkan data berdasarkan userId.
      final List<DataPengajuan> hasilIntegrasi =
          pengajuan.map((item) {
        final namaPengguna = users.any(
          (user) => user.id == item.userId,
        )
            ? daftarNamaIndonesia[item.userId] ?? 'Pengguna Kampus'
            : 'Tidak diketahui';

        return item.copyWith(
          namaPengguna: namaPengguna,
          judul: daftarJudul[item.id] ?? 'Pengajuan Ruangan Kampus',
          deskripsi: daftarDeskripsi[item.id] ??
              'Pengajuan peminjaman ruangan untuk kegiatan kampus.',
        );
      }).toList();

      return hasilIntegrasi;
    } catch (e) {
      throw Exception(
        'Gagal mengintegrasikan data SiRuang Kampus: $e',
      );
    }
  }
}