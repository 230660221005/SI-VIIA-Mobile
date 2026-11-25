import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

class FotoService {
  final ImagePicker _picker = ImagePicker();

  // Memilih foto dari galeri perangkat.
  Future<XFile?> pilihFoto() async {
    try {
      final XFile? foto = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1600,
        imageQuality: 80,
      );

      // Null berarti pengguna membatalkan pemilihan.
      return foto;
    } on PlatformException catch (e) {
      final kode = e.code.toLowerCase();

      if (kode.contains('denied')) {
        throw FotoPermissionException(
          'Izin akses foto ditolak. Periksa permission perangkat.',
        );
      }

      throw FotoPickerException(
        'Gagal memilih foto: ${e.message ?? e.code}',
      );
    }
  }
}

class FotoPermissionException implements Exception {
  final String pesan;

  FotoPermissionException(this.pesan);

  @override
  String toString() => pesan;
}

class FotoPickerException implements Exception {
  final String pesan;

  FotoPickerException(this.pesan);

  @override
  String toString() => pesan;
}
