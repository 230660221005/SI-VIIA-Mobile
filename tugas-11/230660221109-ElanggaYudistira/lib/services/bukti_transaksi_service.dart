import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

class FiturPerangkatException implements Exception {
  final String message;
  final bool permissionDenied;

  const FiturPerangkatException(
    this.message, {
    this.permissionDenied = false,
  });

  @override
  String toString() => message;
}

class BuktiTransaksiService {
  final ImagePicker _picker;

  BuktiTransaksiService({ImagePicker? picker})
      : _picker = picker ?? ImagePicker();

  Future<XFile?> pilihBukti({required ImageSource sumber}) async {
    try {
      return await _picker.pickImage(
        source: sumber,
        maxWidth: 1600,
        imageQuality: 85,
      );
    } on PlatformException catch (error) {
      final permission = error.code.contains('denied') ||
          error.code.contains('permission') ||
          error.code.contains('access');
      throw FiturPerangkatException(
        permission
            ? 'Izin kamera atau galeri ditolak. Aktifkan izin lalu coba lagi.'
            : 'Fitur perangkat gagal: ' + error.message.toString(),
        permissionDenied: permission,
      );
    } catch (error) {
      throw FiturPerangkatException(
        'Tidak dapat membaca foto bukti transaksi: ' + error.toString(),
      );
    }
  }
}
