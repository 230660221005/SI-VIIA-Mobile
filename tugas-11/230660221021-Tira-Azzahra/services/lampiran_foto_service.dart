import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class HasilLampiranFoto {
  const HasilLampiranFoto({
    required this.namaFile,
    required this.path,
    required this.bytes,
    required this.ukuranKb,
  });

  final String namaFile;
  final String path;
  final Uint8List bytes;
  final double ukuranKb;
}

class LampiranFotoException implements Exception {
  const LampiranFotoException(this.pesan, {this.isPermissionDitolak = false});

  final String pesan;
  final bool isPermissionDitolak;

  @override
  String toString() => pesan;
}

class LampiranFotoService {
  final ImagePicker _picker = ImagePicker();
  static const int _maksUkuranBytes = 5 * 1024 * 1024; // Maksimal 5 MB

  /// Mengambil foto dari kamera atau galeri.
  /// Mengembalikan `null` jika pengguna membatalkan pemilihan (bukan error).
  Future<HasilLampiranFoto?> pilihFotoLampiran(ImageSource sumber) async {
    try {
      final XFile? fileTerpilih = await _picker.pickImage(
        source: sumber,
        maxWidth: 1600,
        imageQuality: 85,
      );

      // Pengguna menekan tombol batal / menutup dialog kamera atau file
      if (fileTerpilih == null) {
        return null;
      }

      final Uint8List bytes = await fileTerpilih.readAsBytes();

      // Validasi ukuran file maksimal 5 MB
      if (bytes.length > _maksUkuranBytes) {
        throw const LampiranFotoException(
          'Ukuran foto melebihi batas maksimal 5 MB. Silakan pilih foto lain.',
        );
      }

      return HasilLampiranFoto(
        namaFile: fileTerpilih.name,
        path: fileTerpilih.path,
        bytes: bytes,
        ukuranKb: bytes.length / 1024,
      );
    } on PlatformException catch (e) {
      final kode = e.code.toLowerCase();
      if (kode.contains('access_denied') ||
          kode.contains('permission') ||
          kode.contains('denied')) {
        throw const LampiranFotoException(
          'Izin akses kamera/galeri ditolak. Aktifkan izin pada pengaturan browser atau perangkat Anda.',
          isPermissionDitolak: true,
        );
      }
      throw LampiranFotoException(
        'Perangkat gagal memproses kamera/galeri: ${e.message ?? e.code}',
      );
    } on LampiranFotoException {
      rethrow;
    } catch (e) {
      throw LampiranFotoException(
        'Terjadi kesalahan saat memuat lampiran foto: $e',
      );
    }
  }
}