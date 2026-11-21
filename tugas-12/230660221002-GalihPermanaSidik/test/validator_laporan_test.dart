// Tugas 12 PAB: pengujian validator form laporan.
// Nama: Galih Permana Sidik | NIM 230660221002 | SI-VIIA
//
// Jalankan: flutter test test/validator_laporan_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:silapor_kampus/validators/validator_laporan.dart';

void main() {
  group('lokasi', () {
    test('null ditolak', () {
      expect(ValidatorLaporan.lokasi(null), 'Lokasi wajib diisi.');
    });
    test('hanya spasi ditolak', () {
      expect(ValidatorLaporan.lokasi('   '), 'Lokasi wajib diisi.');
    });
    test('lebih dari 100 karakter ditolak', () {
      expect(
        ValidatorLaporan.lokasi('a' * 101),
        'Lokasi maksimal 100 karakter.',
      );
    });
    test('tepat 100 karakter diterima', () {
      expect(ValidatorLaporan.lokasi('a' * 100), isNull);
    });
    test('lokasi wajar diterima', () {
      expect(ValidatorLaporan.lokasi('Gedung B, R. 204'), isNull);
    });
  });

  group('kategori', () {
    test('null ditolak', () {
      expect(ValidatorLaporan.kategori(null), 'Kategori wajib dipilih.');
    });
    test('kategori di luar daftar ditolak', () {
      expect(ValidatorLaporan.kategori('Laptop'), 'Kategori tidak dikenal.');
    });
    test('kategori dalam daftar diterima', () {
      expect(ValidatorLaporan.kategori('AC'), isNull);
    });
  });

  group('deskripsi', () {
    test('kosong ditolak', () {
      expect(ValidatorLaporan.deskripsi(''), 'Deskripsi wajib diisi.');
    });
    test('kurang dari 10 karakter ditolak', () {
      expect(
        ValidatorLaporan.deskripsi('rusak'),
        'Deskripsi minimal 10 karakter.',
      );
    });
    test('lebih dari 500 karakter ditolak', () {
      expect(
        ValidatorLaporan.deskripsi('a' * 501),
        'Deskripsi maksimal 500 karakter.',
      );
    });
    test('deskripsi wajar diterima', () {
      expect(ValidatorLaporan.deskripsi('AC bocor dan meneteskan air'), isNull);
    });
  });

  group('email (opsional)', () {
    test('kosong diterima karena opsional', () {
      expect(ValidatorLaporan.email(''), isNull);
      expect(ValidatorLaporan.email(null), isNull);
    });
    test('tanpa tanda @ ditolak', () {
      expect(ValidatorLaporan.email('dina'), 'Format email tidak valid.');
    });
    test('tanpa titik pada domain ditolak', () {
      expect(ValidatorLaporan.email('dina@kampus'), 'Format email tidak valid.');
    });
    test('lebih dari 254 karakter ditolak', () {
      expect(
        ValidatorLaporan.email('${'a' * 250}@b.co'),
        'Email maksimal 254 karakter.',
      );
    });
    test('email valid diterima', () {
      expect(ValidatorLaporan.email('dina@kampus.ac.id'), isNull);
    });
  });

  group('tanggal kejadian', () {
    final sekarang = DateTime(2026, 11, 20, 10, 30);

    test('null ditolak', () {
      expect(
        ValidatorLaporan.tanggalKejadian(null, sekarang: sekarang),
        'Tanggal kejadian wajib dipilih.',
      );
    });
    test('besok ditolak', () {
      expect(
        ValidatorLaporan.tanggalKejadian(DateTime(2026, 11, 21), sekarang: sekarang),
        'Tanggal kejadian tidak boleh di masa depan.',
      );
    });
    test('lebih dari 30 hari lalu ditolak', () {
      expect(
        ValidatorLaporan.tanggalKejadian(DateTime(2026, 10, 1), sekarang: sekarang),
        'Tanggal kejadian maksimal 30 hari ke belakang.',
      );
    });
    test('hari ini diterima walau jam berbeda', () {
      expect(
        ValidatorLaporan.tanggalKejadian(DateTime(2026, 11, 20, 23, 59), sekarang: sekarang),
        isNull,
      );
    });
    test('batas 30 hari ke belakang diterima', () {
      expect(
        ValidatorLaporan.tanggalKejadian(DateTime(2026, 10, 21), sekarang: sekarang),
        isNull,
      );
    });
  });

  group('berkas foto', () {
    test('format GIF ditolak', () {
      expect(
        ValidatorLaporan.fotoBerkas(nama: 'a.gif', ukuranByte: 1000),
        'Format foto tidak didukung. Gunakan JPG atau PNG.',
      );
    });
    test('lebih dari 5 MB ditolak', () {
      expect(
        ValidatorLaporan.fotoBerkas(
          nama: 'a.jpg',
          ukuranByte: ValidatorLaporan.batasFotoByte + 1,
        ),
        'Ukuran foto melebihi 5 MB. Pilih foto yang lebih kecil.',
      );
    });
    test('tepat 5 MB diterima', () {
      expect(
        ValidatorLaporan.fotoBerkas(
          nama: 'a.jpg',
          ukuranByte: ValidatorLaporan.batasFotoByte,
        ),
        isNull,
      );
    });
    test('ekstensi huruf besar diterima', () {
      expect(ValidatorLaporan.fotoBerkas(nama: 'FOTO.PNG', ukuranByte: 1000), isNull);
    });
    test('tanpa ekstensi diterima bila MIME gambar', () {
      expect(
        ValidatorLaporan.fotoBerkas(
          nama: 'blob',
          ukuranByte: 1000,
          mimeType: 'image/jpeg',
        ),
        isNull,
      );
    });
    test('tanpa ekstensi dan tanpa MIME ditolak', () {
      expect(
        ValidatorLaporan.fotoBerkas(nama: 'blob', ukuranByte: 1000),
        'Format foto tidak didukung. Gunakan JPG atau PNG.',
      );
    });
  });
}
