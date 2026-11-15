// ============================================================================
// PAB — Tugas 11: Integrasi Fitur Perangkat
// Berkas: foto_service.dart — service kamera dan galeri
// Domain project: Glazent.pro (usaha jasa glass cleaning & nanocoating)
// ============================================================================
//
// Bantuan: Claude — menyusun kerangka service (pemilihan foto, pembedaan
// batal/izin ditolak/error, validasi) mengikuti materi Pertemuan 11, dengan
// konteks disesuaikan ke domain Glazent.pro.
//
// Service ini memisahkan package image_picker dari widget. Berkas ini tidak
// membuat widget apa pun.
//
// Kontrak hasil pemilihan foto:
//   - XFile                : pengguna memilih atau mengambil foto.
//   - null                 : pengguna MEMBATALKAN. Bukan error.
//   - IzinDitolakException : izin kamera/galeri ditolak pengguna.
//   - FotoException        : package atau perangkat gagal (error).
// ============================================================================

import 'package:flutter/services.dart' show PlatformException;
import 'package:image_picker/image_picker.dart';

import 'validasi_foto.dart';

/// Kegagalan fitur foto, dengan pesan siap tampil bagi pengguna.
class FotoException implements Exception {
  const FotoException(this.pesan);

  final String pesan;

  @override
  String toString() => pesan;
}

/// Izin kamera atau galeri ditolak. Dibedakan dari [FotoException] karena
/// penanganannya berbeda: pengguna perlu mengaktifkan izin di pengaturan.
class IzinDitolakException extends FotoException {
  const IzinDitolakException(super.pesan);
}

/// Mode simulasi, hanya untuk pengujian skenario yang sulit dipicu pada target
/// web (izin ditolak dan error package).
enum SimulasiFoto { tidak, izinDitolak, error }

class FotoService {
  FotoService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  /// Mode simulasi. Ubah sementara menjadi SimulasiFoto.izinDitolak atau
  /// SimulasiFoto.error untuk menguji skenario tersebut pada target web, lalu
  /// kembalikan ke SimulasiFoto.tidak. Pada perangkat Android/iOS, izin
  /// ditolak dapat diuji sungguhan lewat pengaturan perangkat.
  static const SimulasiFoto simulasi = SimulasiFoto.tidak;

  static const String _pesanIzin =
      'Izin kamera atau galeri ditolak. Aktifkan izin pada Pengaturan '
      'perangkat, atau pilih foto dari sumber lain.';

  /// Memilih foto dari galeri. Menghasilkan `null` bila dibatalkan.
  Future<XFile?> pilihDariGaleri() => _ambil(ImageSource.gallery);

  /// Mengambil foto dengan kamera. Menghasilkan `null` bila dibatalkan.
  Future<XFile?> ambilDenganKamera() => _ambil(ImageSource.camera);

  /// Memeriksa format dan ukuran foto. Menghasilkan `null` bila valid, atau
  /// pesan alasan bila ditolak.
  Future<String?> validasi(XFile foto) async {
    try {
      final ukuran = await foto.length();
      return ValidasiFoto.periksa(
        nama: foto.name,
        mimeType: foto.mimeType,
        ukuranByte: ukuran,
      );
    } catch (_) {
      throw const FotoException('Foto tidak dapat dibaca. Coba pilih ulang.');
    }
  }

  Future<XFile?> _ambil(ImageSource sumber) async {
    if (simulasi == SimulasiFoto.izinDitolak) {
      throw const IzinDitolakException(_pesanIzin);
    }
    if (simulasi == SimulasiFoto.error) {
      throw const FotoException(
        'Foto tidak dapat dipilih karena terjadi kesalahan pada perangkat.',
      );
    }

    try {
      return await _picker.pickImage(
        source: sumber,
        maxWidth: 1600,
        imageQuality: 80,
      );
    } on PlatformException catch (e) {
      if (e.code.endsWith('access_denied')) {
        throw const IzinDitolakException(_pesanIzin);
      }
      throw FotoException('Foto tidak dapat dipilih (kode: ${e.code}).');
    } catch (_) {
      throw const FotoException(
        'Foto tidak dapat dipilih karena terjadi kesalahan pada perangkat.',
      );
    }
  }
}
