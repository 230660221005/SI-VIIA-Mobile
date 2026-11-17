
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class ValidasiFoto {
  static const int batasUkuran = 2 * 1024 * 1024;

  // Validasi 1: Foto wajib dipilih
  static String? cekFotoWajib(XFile? foto) {
    if (foto == null) {
      return 'Foto wajib dipilih.';
    }

    return null;
  }

  // Validasi 2: Format nama file harus JPG, JPEG, atau PNG
  static String? cekFormatFoto(XFile foto) {
    final namaFile = foto.name.toLowerCase();

    const formatDiizinkan = ['.jpg', '.jpeg', '.png'];

    final valid = formatDiizinkan.any(
      (format) => namaFile.endsWith(format),
    );

    if (!valid) {
      return 'Format foto harus JPG, JPEG, atau PNG.';
    }

    return null;
  }

  // Validasi 3: Ukuran foto maksimal 2 MB
  static Future<String?> cekUkuranFoto(XFile foto) async {
    final ukuran = await foto.length();

    if (ukuran > batasUkuran) {
      return 'Ukuran foto maksimal 2 MB.';
    }

    return null;
  }

  // Validasi 4: Data foto tidak boleh kosong
  static String? cekDataFoto(Uint8List bytes) {
    if (bytes.isEmpty) {
      return 'Data foto kosong.';
    }

    return null;
  }

  // Validasi 5: Memeriksa tanda pengenal isi file JPG atau PNG
  static String? cekIsiFileFoto(Uint8List bytes) {
    final isJpeg = bytes.length >= 3 &&
        bytes[0] == 0xFF &&
        bytes[1] == 0xD8 &&
        bytes[2] == 0xFF;

    final isPng = bytes.length >= 8 &&
        bytes[0] == 0x89 &&
        bytes[1] == 0x50 &&
        bytes[2] == 0x4E &&
        bytes[3] == 0x47 &&
        bytes[4] == 0x0D &&
        bytes[5] == 0x0A &&
        bytes[6] == 0x1A &&
        bytes[7] == 0x0A;

    if (!isJpeg && !isPng) {
      return 'Isi file bukan gambar JPG/JPEG/PNG yang valid.';
    }

    return null;
  }
}
