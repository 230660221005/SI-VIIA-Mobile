// Tugas 13 PAB: test regresi BUG-01 (email dengan titik tidak wajar lolos).
// Nama: Galih Permana Sidik | NIM 230660221002 | SI-VIIA
//
// Test pada grup "ditolak" gagal pada kode sebelum perbaikan (pola lama
// menerima semua alamat tersebut) dan lulus setelah perbaikan. Test pada grup
// "diterima" memastikan perbaikan tidak menolak email yang valid (regresi).
//
// Jalankan: flutter test test/regresi_email_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:silapor_kampus/validators/validator_laporan.dart';

void main() {
  group('BUG-01: email berformat salah harus ditolak', () {
    const ditolak = <String>[
      'dina@kampus..id', // titik beruntun pada domain
      'dina..x@kampus.id', // titik beruntun pada bagian lokal
      '.dina@kampus.id', // bagian lokal diawali titik
      'dina.@kampus.id', // bagian lokal diakhiri titik
      'dina@-kampus.id', // label domain diawali strip
      'dina@kampus.id.', // domain diakhiri titik
      'dina@kampus.i', // TLD satu huruf
    ];

    for (final email in ditolak) {
      test('menolak $email', () {
        expect(ValidatorLaporan.email(email), 'Format email tidak valid.');
      });
    }
  });

  group('regresi: email valid tetap diterima', () {
    const diterima = <String>[
      'dina@kampus.ac.id',
      'dina.p+lapor@mail.kampus.ac.id',
      'a_b-c@x1.co',
      'a@b.co',
    ];

    for (final email in diterima) {
      test('menerima $email', () {
        expect(ValidatorLaporan.email(email), isNull);
      });
    }

    test('email kosong tetap diterima karena opsional', () {
      expect(ValidatorLaporan.email(''), isNull);
    });
  });
}
