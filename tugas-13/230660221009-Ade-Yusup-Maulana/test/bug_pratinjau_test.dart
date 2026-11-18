
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tugas_11/pages/halaman_foto.dart';
import 'package:tugas_11/services/foto_service.dart';

class FotoServicePalsu extends FotoService {
  final List<XFile?> daftarFoto;
  int indeks = 0;

  FotoServicePalsu(this.daftarFoto);

  @override
  Future<XFile?> pilihFotoDariGaleri() async {
    final hasil = daftarFoto[indeks++];
    return hasil;
  }
}

void main() {
  testWidgets(
    'Foto lama tidak tampil setelah foto baru tidak valid',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1;

      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final Uint8List bytesPng = base64Decode(
        'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO+/pWQAAAAASUVORK5CYII=',
      );

      // Membuat contoh foto PNG yang valid.
      final fotoValid = XFile.fromData(
        bytesPng,
        path: 'foto.png',
      );

      // Membuat contoh file TXT yang tidak valid.
      final fotoTidakValid = XFile.fromData(
        Uint8List.fromList([1, 2, 3, 4]),
        path: 'dokumen.txt',
      );

      final servicePalsu = FotoServicePalsu([
        fotoValid,
        fotoTidakValid,
      ]);

      await tester.pumpWidget(
        MaterialApp(
          home: HalamanFoto(fotoService: servicePalsu),
        ),
      );

      // Memilih foto pertama.
      await tester.tap(find.text('Pilih dari Galeri'));
      await tester.pumpAndSettle();

      expect(
        find.text('Foto berhasil dipilih dan lolos 5 validasi.'),
        findsOneWidget,
      );

      expect(
        find.text('Nama file: foto.png'),
        findsOneWidget,
      );

      // Memilih foto kedua yang tidak valid.
      await tester.tap(find.text('Pilih dari Galeri'));
      await tester.pumpAndSettle();

      expect(
        find.text('Format foto harus JPG, JPEG, atau PNG.'),
        findsOneWidget,
      );

      // Memastikan foto lama sudah tidak ditampilkan.
      expect(
        find.text('Nama file: foto.png'),
        findsNothing,
      );
    },
  );
}
