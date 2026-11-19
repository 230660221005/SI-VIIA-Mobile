// Tugas 11 PAB: Integrasi Fitur Perangkat (service layer)
// Nama: Galih Permana Sidik | NIM 230660221002 | SI-VIIA
//
// Satu-satunya berkas yang mengenal package image_picker. Widget hanya
// memanggil FotoService.pilih() dan tidak pernah mengimpor package perangkat.
//
// Kontrak pilih():
//   - berhasil          -> mengembalikan LampiranFoto
//   - pengguna batal    -> mengembalikan null (bukan error)
//   - izin ditolak,
//     berkas tidak valid,
//     perangkat/package
//     gagal             -> melempar FotoException dengan jenis yang berbeda
//
// Bantuan: Claude, menyusun pemisahan antara pembatalan (null) dan kegagalan
// (exception), serta pemetaan kode PlatformException ke jenis kesalahan.

import 'dart:typed_data';

import 'package:flutter/services.dart' show PlatformException;
import 'package:image_picker/image_picker.dart';

/// Sumber foto versi aplikasi, agar widget tidak perlu mengenal ImageSource.
enum SumberFoto { kamera, galeri }

enum JenisKesalahanFoto { izinDitolak, tidakValid, gagal }

/// Kegagalan dengan pesan siap tampil. Pembatalan bukan FotoException.
class FotoException implements Exception {
  const FotoException(this.jenis, this.pesan);

  final JenisKesalahanFoto jenis;
  final String pesan;

  @override
  String toString() => pesan;
}

/// Alat bantu pengujian skenario yang sulit dipicu secara nyata pada web.
enum SimulasiFoto { tidakAda, izinDitolak, error }

/// Foto yang sudah lolos validasi. Dibaca ke bytes supaya preview dapat memakai
/// Image.memory pada web maupun perangkat, tanpa dart:io.
class LampiranFoto {
  const LampiranFoto({
    required this.nama,
    required this.ukuranByte,
    required this.bytes,
  });

  final String nama;
  final int ukuranByte;
  final Uint8List bytes;

  String get ukuranTeks {
    if (ukuranByte < 1024) return '$ukuranByte B';
    if (ukuranByte < 1024 * 1024) {
      return '${(ukuranByte / 1024).toStringAsFixed(0)} KB';
    }
    return '${(ukuranByte / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}

class FotoService {
  FotoService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  // Untuk skenario uji. Isi izinDitolak atau error, lalu kembalikan ke
  // tidakAda sebelum mengumpulkan.
  static const SimulasiFoto simulasi = SimulasiFoto.tidakAda;

  static const int batasUkuranByte = 5 * 1024 * 1024; // 5 MB
  static const List<String> _ekstensiDiizinkan = ['jpg', 'jpeg', 'png'];

  final ImagePicker _picker;

  Future<LampiranFoto?> pilih(SumberFoto sumber) async {
    try {
      if (simulasi == SimulasiFoto.izinDitolak) {
        throw PlatformException(code: 'camera_access_denied');
      }
      if (simulasi == SimulasiFoto.error) {
        throw PlatformException(code: 'simulasi_error');
      }

      final berkas = await _picker.pickImage(
        source: sumber == SumberFoto.kamera
            ? ImageSource.camera
            : ImageSource.gallery,
        maxWidth: 1600,
        imageQuality: 80,
      );

      // null berarti pengguna menutup kamera atau pemilih tanpa memilih.
      if (berkas == null) return null;

      final nama = berkas.name;
      final ekstensi =
          nama.contains('.') ? nama.split('.').last.toLowerCase() : '';
      final adaEkstensiValid = _ekstensiDiizinkan.contains(ekstensi);
      final mimeGambar = (berkas.mimeType ?? '').startsWith('image/');
      if (!adaEkstensiValid && !(ekstensi.isEmpty && mimeGambar)) {
        throw const FotoException(
          JenisKesalahanFoto.tidakValid,
          'Format foto tidak didukung. Gunakan JPG atau PNG.',
        );
      }

      final ukuran = await berkas.length();
      if (ukuran > batasUkuranByte) {
        throw const FotoException(
          JenisKesalahanFoto.tidakValid,
          'Ukuran foto melebihi 5 MB. Pilih foto yang lebih kecil.',
        );
      }

      final bytes = await berkas.readAsBytes();
      return LampiranFoto(
        nama: nama.isEmpty ? 'foto-laporan' : nama,
        ukuranByte: ukuran,
        bytes: bytes,
      );
    } on FotoException {
      rethrow;
    } on PlatformException catch (e) {
      if (e.code.contains('access_denied')) {
        throw const FotoException(
          JenisKesalahanFoto.izinDitolak,
          'Izin kamera atau galeri ditolak. Buka Pengaturan aplikasi, aktifkan izinnya, lalu coba lagi.',
        );
      }
      throw const FotoException(
        JenisKesalahanFoto.gagal,
        'Foto tidak dapat diambil dari perangkat. Coba lagi.',
      );
    } catch (_) {
      throw const FotoException(
        JenisKesalahanFoto.gagal,
        'Terjadi kegagalan saat memproses foto. Coba lagi.',
      );
    }
  }
}
