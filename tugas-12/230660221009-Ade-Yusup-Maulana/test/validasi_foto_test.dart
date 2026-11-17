
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tugas_11/validators/validasi_foto.dart';

void main() {
  group('Pengujian Validasi Foto', () {
    test('Foto wajib dipilih', () {
      expect(
        ValidasiFoto.cekFotoWajib(null),
        'Foto wajib dipilih.',
      );
    });

    test('Format PDF harus ditolak', () {
      final foto = XFile.fromData(
        Uint8List.fromList([1, 2, 3]),
        name: 'dokumen.pdf',
      );

      expect(
        ValidasiFoto.cekFormatFoto(foto),
        'Format foto harus JPG, JPEG, atau PNG.',
      );
    });

    test('Ukuran foto lebih dari 2 MB ditolak', () async {
      final foto = XFile.fromData(
        Uint8List(2 * 1024 * 1024 + 1),
        name: 'foto.jpg',
      );

      expect(
        await ValidasiFoto.cekUkuranFoto(foto),
        'Ukuran foto maksimal 2 MB.',
      );
    });

    test('Ukuran foto di bawah 2 MB diterima', () async {
      final foto = XFile.fromData(
        Uint8List(1024),
        name: 'foto.jpg',
      );

      expect(
        await ValidasiFoto.cekUkuranFoto(foto),
        isNull,
      );
    });

    test('Data foto kosong harus ditolak', () {
      expect(
        ValidasiFoto.cekDataFoto(Uint8List(0)),
        'Data foto kosong.',
      );
    });

    test('Isi file tidak valid harus ditolak', () {
      expect(
        ValidasiFoto.cekIsiFileFoto(
          Uint8List.fromList([1, 2, 3, 4]),
        ),
        'Isi file bukan gambar JPG/JPEG/PNG yang valid.',
      );
    });

    test('Tanda pengenal JPEG diterima', () {
      expect(
        ValidasiFoto.cekIsiFileFoto(
          Uint8List.fromList([0xFF, 0xD8, 0xFF, 0xE0]),
        ),
        isNull,
      );
    });

    test('Tanda pengenal PNG diterima', () {
      expect(
        ValidasiFoto.cekIsiFileFoto(
          Uint8List.fromList([
            0x89, 0x50, 0x4E, 0x47,
            0x0D, 0x0A, 0x1A, 0x0A,
          ]),
        ),
        isNull,
      );
    });
  });
}
