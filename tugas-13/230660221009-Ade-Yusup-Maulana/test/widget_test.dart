
import 'package:flutter_test/flutter_test.dart';
import 'package:tugas_11/main.dart';
import 'package:tugas_11/pages/halaman_foto.dart';

void main() {
  testWidgets('Aplikasi berhasil ditampilkan', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(MyApp), findsOneWidget);
    expect(find.byType(HalamanFoto), findsOneWidget);
  });

  testWidgets('Judul halaman Bukti Foto ditampilkan', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Bukti Foto'), findsOneWidget);
  });

  testWidgets('Tombol kamera dan galeri ditampilkan', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Ambil Foto dengan Kamera'), findsOneWidget);
    expect(find.text('Pilih dari Galeri'), findsOneWidget);
  });

  testWidgets('Pesan awal ditampilkan sebelum memilih foto', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(
      find.text('Belum ada foto yang dipilih.'),
      findsOneWidget,
    );
  });
}
