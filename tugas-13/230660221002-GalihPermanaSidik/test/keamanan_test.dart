// Tugas 12 PAB: pemeriksaan keamanan otomatis pada source code.
// Nama: Galih Permana Sidik | NIM 230660221002 | SI-VIIA
//
// Memindai seluruh berkas .dart pada lib/ sebagai bukti untuk security-checklist.md.
// Pemindaian teks ini pemeriksaan dasar, bukan audit keamanan. Jalankan dari
// folder project: flutter test test/keamanan_test.dart

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

List<File> _berkasDart() {
  return Directory('lib')
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .toList();
}

void main() {
  test('ada berkas Dart yang dipindai', () {
    expect(_berkasDart(), isNotEmpty);
  });

  test('tidak ada alamat http:// tanpa TLS', () {
    for (final berkas in _berkasDart()) {
      expect(
        berkas.readAsStringSync().contains('http://'),
        isFalse,
        reason: 'Ditemukan http:// pada ${berkas.path}',
      );
    }
  });

  test('tidak ada print atau debugPrint (mencegah kebocoran lewat log)', () {
    final pola = RegExp(r'\b(print|debugPrint)\s*\(');
    for (final berkas in _berkasDart()) {
      expect(
        pola.hasMatch(berkas.readAsStringSync()),
        isFalse,
        reason: 'Ditemukan pemanggilan log pada ${berkas.path}',
      );
    }
  });

  test('tidak ada secret atau token tertulis pada source', () {
    final pola = RegExp(
      r'''(password|passwd|secret|token|api[_-]?key)\s*[:=]\s*['"][^'"]+['"]''',
      caseSensitive: false,
    );
    for (final berkas in _berkasDart()) {
      final isi = berkas.readAsStringSync();
      expect(
        pola.hasMatch(isi) || isi.contains('Bearer '),
        isFalse,
        reason: 'Ditemukan pola secret pada ${berkas.path}',
      );
    }
  });
}
