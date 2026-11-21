// Tugas 13 PAB: widget test form Buat Laporan.
// Nama: Galih Permana Sidik | NIM 230660221002 | SI-VIIA
//
// Menguji interaksi pada halaman: kondisi awal, form kosong, deskripsi pendek,
// dan email salah. Layar uji dibuat tinggi agar seluruh form terbangun tanpa
// perlu menggulir. Memerlukan Flutter 3.10 atau lebih baru (tester.view).
//
// Jalankan: flutter test test/widget_form_test.dart
//
// Bantuan: Claude, menyusun variasi skenario dan pola finder. Hasil dijalankan
// dan diverifikasi oleh penulis.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silapor_kampus/main.dart';

Future<void> _pasangHalaman(WidgetTester tester) async {
  tester.view.physicalSize = const Size(800, 2400);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(const MaterialApp(home: HalamanBuatLaporan()));
}

Future<void> _tekanKirim(WidgetTester tester) async {
  await tester.tap(find.text('Kirim laporan'));
  await tester.pump();
}

void main() {
  testWidgets('kondisi awal menampilkan bagian foto kosong', (tester) async {
    await _pasangHalaman(tester);

    expect(
      find.text('Belum ada foto. Foto membantu petugas menilai kerusakan.'),
      findsOneWidget,
    );
    expect(find.text('Kamera'), findsOneWidget);
    expect(find.text('Galeri'), findsOneWidget);
  });

  testWidgets('form kosong menampilkan semua pesan wajib dan tidak mengirim',
      (tester) async {
    await _pasangHalaman(tester);

    await _tekanKirim(tester);

    expect(find.text('Lokasi wajib diisi.'), findsOneWidget);
    expect(find.text('Kategori wajib dipilih.'), findsOneWidget);
    expect(find.text('Tanggal kejadian wajib dipilih.'), findsOneWidget);
    expect(find.text('Deskripsi wajib diisi.'), findsOneWidget);
    expect(find.text('Ringkasan laporan'), findsNothing);
  });

  testWidgets('deskripsi kurang dari 10 karakter ditolak', (tester) async {
    await _pasangHalaman(tester);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Deskripsi'),
      'rusak',
    );
    await _tekanKirim(tester);

    expect(find.text('Deskripsi minimal 10 karakter.'), findsOneWidget);
  });

  testWidgets('email tidak lengkap ditolak', (tester) async {
    await _pasangHalaman(tester);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email kontak (opsional)'),
      'dina@kampus',
    );
    await _tekanKirim(tester);

    expect(find.text('Format email tidak valid.'), findsOneWidget);
  });

  testWidgets('email valid tidak memunculkan pesan format', (tester) async {
    await _pasangHalaman(tester);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email kontak (opsional)'),
      'dina@kampus.ac.id',
    );
    await _tekanKirim(tester);

    expect(find.text('Format email tidak valid.'), findsNothing);
  });
}
