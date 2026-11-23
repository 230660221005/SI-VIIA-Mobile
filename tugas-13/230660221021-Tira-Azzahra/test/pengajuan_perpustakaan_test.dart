import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tugas_13_testing_bug_fixes/main.dart';
import 'package:tugas_13_testing_bug_fixes/validators/pengajuan_validator.dart';

void main() {
  group('Unit Test — PengajuanValidator', () {
    test('menolak nama kosong dan menerima nama valid', () {
      expect(
        PengajuanValidator.validasiNama(''),
        'Nama lengkap mahasiswa wajib diisi.',
      );
      expect(PengajuanValidator.validasiNama('Tira Azzahra'), isNull);
    });

    test('menolak NIM bukan 12 digit dan menerima NIM 12 digit', () {
      expect(
        PengajuanValidator.validasiNim('23066'),
        'Format NIM tidak valid (harus 12 digit angka, contoh: 230660221021).',
      );
      expect(PengajuanValidator.validasiNim('230660221021'), isNull);
    });

    test('menolak durasi di luar 1-14 hari', () {
      expect(
        PengajuanValidator.validasiDurasiHari('20'),
        'Durasi peminjaman buku hanya diizinkan antara 1 hingga 14 hari.',
      );
      expect(PengajuanValidator.validasiDurasiHari('7'), isNull);
    });
  });

  group('Widget Test — HalamanPengajuanPerpustakaan', () {
    testWidgets('TC-02: menampilkan pesan validasi saat field wajib kosong',
        (tester) async {
      await tester.pumpWidget(const PerpustakaanTestingApp());

      await tester.tap(find.byKey(const Key('btn_kirim_pengajuan')));
      await tester.pump();

      expect(
        find.text('Nama lengkap mahasiswa wajib diisi.'),
        findsOneWidget,
      );
      expect(find.text('NIM mahasiswa wajib diisi.'), findsOneWidget);
    });

    testWidgets(
        'TC-06: menolak pengiriman jika sesi token belum diaktifkan (HTTP 401)',
        (tester) async {
      await tester.pumpWidget(const PerpustakaanTestingApp());

      await tester.enterText(
          find.byKey(const Key('field_nama')), 'Tira Azzahra');
      await tester.enterText(
          find.byKey(const Key('field_nim')), '230660221021');
      await tester.enterText(find.byKey(const Key('field_email')),
          '230660221021@student.unsap.ac.id');
      await tester.enterText(find.byKey(const Key('field_judul_buku')),
          'Rekayasa Perangkat Lunak');

      await tester.tap(find.byKey(const Key('btn_kirim_pengajuan')));
      await tester.pump();

      expect(
        find.textContaining('Sesi akses tidak ditemukan (HTTP 401)'),
        findsOneWidget,
      );
    });

    testWidgets(
        'TC-01 & TC-04 (Regresi BUG-01): input valid dan double-tap cepat hanya membuat 1 pengajuan',
        (tester) async {
      await tester.pumpWidget(const PerpustakaanTestingApp());

      // 1. Aktifkan sesi token
      await tester.tap(find.byKey(const Key('btn_toggle_sesi')));
      await tester.pump();

      // 2. Isi seluruh form dengan data valid
      await tester.enterText(
          find.byKey(const Key('field_nama')), 'Tira Azzahra');
      await tester.enterText(
          find.byKey(const Key('field_nim')), '230660221021');
      await tester.enterText(find.byKey(const Key('field_email')),
          '230660221021@student.unsap.ac.id');
      await tester.enterText(
          find.byKey(const Key('field_judul_buku')), 'Basis Data Lanjut');

      // 3. Simulasi double tap cepat pada tombol Kirim Pengajuan
      final tombolKirim = find.byKey(const Key('btn_kirim_pengajuan'));
      await tester.tap(tombolKirim);
      await tester.pump(const Duration(milliseconds: 50));
      await tester.tap(tombolKirim, warnIfMissed: false);

      // 4. Tunggu proses async 400ms selesai
      await tester.pump(const Duration(milliseconds: 500));

      // Verifikasi hanya 1 item tersimpan (bukan ganda)
      expect(find.text('Daftar Pengajuan (1)'), findsOneWidget);
      expect(find.text('Basis Data Lanjut'), findsOneWidget);
    });
  });
}