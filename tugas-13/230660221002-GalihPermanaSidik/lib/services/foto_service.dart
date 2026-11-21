// Tugas 12 PAB: Validasi dan Keamanan Praktis (service foto)
// Nama: Galih Permana Sidik | NIM 230660221002 | SI-VIIA
//
// Dibawa dari Tugas 11. Perubahan pada Tugas 12: validasi format dan ukuran foto
// dipindah ke ValidatorLaporan.fotoBerkas agar dapat diuji otomatis. Service
// tetap menjadi satu-satunya berkas yang mengenal image_picker, dan permission
// kamera atau galeri hanya diminta saat pengguna menekan tombolnya.
//
// Kontrak pilih(): berhasil mengembalikan LampiranFoto, pembatalan
// mengembalikan null, kegagalan melempar FotoException.
//
// Bantuan: Claude, menyusun pemisahan batal dan gagal serta pemetaan kode
// PlatformException ke jenis kesalahan.

import 'dart:typed_data';

import 'package:flutter/services.dart' show PlatformException;
import 'package:image_picker/image_picker.dart';

import '../validators/validator_laporan.dart';

enum SumberFoto { kamera, galeri }

enum JenisKesalahanFoto { izinDitolak, tidakValid, gagal }

class FotoException implements Exception {
  const FotoException(this.jenis, this.pesan);

  final JenisKesalahanFoto jenis;
  final String pesan;

  @override
  String toString() => pesan;
}

/// Alat bantu pengujian skenario yang sulit dipicu pada web.
enum SimulasiFoto { tidakAda, izinDitolak, error }

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

  // Kembalikan ke tidakAda sebelum mengumpulkan.
  static const SimulasiFoto simulasi = SimulasiFoto.tidakAda;

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

      // null berarti pengguna membatalkan, bukan error.
      if (berkas == null) return null;

      final ukuran = await berkas.length();
      final alasan = ValidatorLaporan.fotoBerkas(
        nama: berkas.name,
        ukuranByte: ukuran,
        mimeType: berkas.mimeType,
      );
      if (alasan != null) {
        throw FotoException(JenisKesalahanFoto.tidakValid, alasan);
      }

      final bytes = await berkas.readAsBytes();
      return LampiranFoto(
        nama: berkas.name.isEmpty ? 'foto-laporan' : berkas.name,
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
      // Detail teknis sengaja tidak diteruskan ke pengguna.
      throw const FotoException(
        JenisKesalahanFoto.gagal,
        'Terjadi kegagalan saat memproses foto. Coba lagi.',
      );
    }
  }
}
