import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pab_p1_230660221093/halaman-validasi-pesanan.dart';
import 'package:pab_p1_230660221093/services/validasi_input.dart';

void main() {
  group('ValidasiInput', () {
    test('TC-01 nama pemohon valid mengembalikan null', () {
      expect(ValidasiInput.namaPemohon('Rani Kusuma'), isNull);
    });

    test('TC-02 nama pemohon kosong ditolak', () {
      expect(
        ValidasiInput.namaPemohon('   '),
        'Nama pemohon wajib diisi.',
      );
    });

    test('TC-03 email format salah ditolak', () {
      expect(
        ValidasiInput.email('nama@'),
        'Format email tidak valid. Contoh: nama@domain.com',
      );
    });

    test('TC-05 tanggal sebelum hari ini ditolak', () {
      final hasil = ValidasiInput.tanggalLayanan(
        '2026-11-15',
        hariIni: DateTime(2026, 11, 16),
      );
      expect(hasil, 'Tanggal layanan tidak boleh sebelum hari ini.');
    });
  });

  testWidgets('TC-06 form kosong menampilkan pesan validasi', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: HalamanValidasiPesanan()),
    );
    await tester.pumpAndSettle();

    final tombol = find.text('Kirim Pengajuan');
    await tester.dragUntilVisible(
      tombol,
      find.byType(ListView),
      const Offset(0, -200),
    );
    await tester.pumpAndSettle();
    await tester.tap(tombol);
    await tester.pumpAndSettle();

    expect(find.text('Nama pemohon wajib diisi.'), findsWidgets);
    expect(find.text('Email wajib diisi.'), findsWidgets);
    expect(find.text('Tanggal layanan wajib dipilih.'), findsWidgets);
    expect(
      find.text('Catatan atau alamat layanan wajib diisi.'),
      findsWidgets,
    );
  });
}
