// ============================================================================
// PAB — Tugas 10: Integrasi Data dan Proses Bisnis
// Halaman daftar pesanan yang menampilkan data gabungan dari tiga endpoint.
// Domain project: Glazent.pro (usaha jasa glass cleaning & nanocoating)
// ============================================================================
//
// Tampilan dirombak agar terasa seperti dashboard web: header gradien dengan
// ringkasan status, kartu pesanan responsif (satu kolom di ponsel, dua kolom
// di layar lebar), serta keadaan loading, kosong, dan error yang konsisten.
//
// Berkas ini tidak berisi request HTTP maupun parsing JSON. Seluruhnya ada pada
// lib/services/integrasi_service.dart; halaman hanya memanggil service dan
// mengubah state berdasarkan hasilnya.
//
// Cara menjalankan (target web):
//   flutter pub get
//   flutter run -d chrome
// ============================================================================

import 'package:flutter/material.dart';

import 'models/pesanan_ringkas.dart';
import 'services/integrasi_service.dart';

// API simulasi (jsonplaceholder) mengirim judul dan nama berbahasa asing.
// Agar contoh pesanan sesuai domain Glazent.pro di Indonesia, halaman memetakan
// data tersebut ke label contoh berbahasa Indonesia. Pemetaan hanya untuk
// tampilan; penggabungan data dan aturan status tetap memakai identifier asli.
const List<({String nama, String kota})> _pelangganContoh = [
  (nama: 'Rani Kusuma', kota: 'Bandung'),
  (nama: 'Dedi Pratama', kota: 'Sumedang'),
  (nama: 'Siti Nurhaliza', kota: 'Jakarta Selatan'),
  (nama: 'Agus Setiawan', kota: 'Bekasi'),
  (nama: 'Maya Anggraini', kota: 'Depok'),
  (nama: 'Rizky Ramadhan', kota: 'Bandung Barat'),
  (nama: 'Dewi Lestari', kota: 'Cimahi'),
  (nama: 'Budi Santoso', kota: 'Jakarta Timur'),
  (nama: 'Nabila Putri', kota: 'Bogor'),
  (nama: 'Fajar Nugraha', kota: 'Garut'),
];

const List<String> _layananContoh = [
  'Cleaning Kaca Rumah',
  'Nanocoating Kaca Shower',
  'Cleaning Kanopi',
  'Cleaning Kaca Facade Gedung',
  'Nanocoating Kaca Mobil',
  'Cleaning Kaca Jendela',
  'Perawatan Kaca Balkon',
  'Coating Kaca Meja',
];

void main() {
  runApp(const MyApp());
}

/// Aplikasi utama — tema terpusat, konsisten dengan Tugas 5-9.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF0F6CBD),
      surface: const Color(0xFFF4F7FB),
    );

    return MaterialApp(
      title: 'Glazent.pro — Pesanan Terintegrasi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: const Color(0xFFF4F7FB),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF10233F),
          elevation: 0,
          scrolledUnderElevation: 1,
          surfaceTintColor: Colors.transparent,
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: BorderSide(
              color: colorScheme.outlineVariant.withValues(alpha: 0.7),
            ),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const HalamanDaftarPesanan(),
    );
  }
}

/// Halaman daftar pesanan terintegrasi. Menangani empat kondisi: loading,
/// sukses, kosong, dan error (dengan tombol coba lagi).
class HalamanDaftarPesanan extends StatefulWidget {
  const HalamanDaftarPesanan({super.key, this.pengambilData});

  /// Sumber data halaman. Bila null, halaman memakai
  /// [IntegrasiService.ambilDataTerintegrasi]. Parameter ini dipakai pengujian
  /// untuk mengganti sumber data tanpa permintaan jaringan.
  final Future<List<PesananRingkas>> Function()? pengambilData;

  @override
  State<HalamanDaftarPesanan> createState() => _HalamanDaftarPesananState();
}

class _HalamanDaftarPesananState extends State<HalamanDaftarPesanan> {
  // State halaman integrasi data.
  bool _sedangMemuat = true;
  String? _pesanError;
  List<PesananRingkas> _daftar = [];

  @override
  void initState() {
    super.initState();
    _muatData();
  }

  /// Alur pemuatan: set loading -> hapus error lama -> panggil service ->
  /// simpan hasil -> matikan loading; bila gagal, simpan pesan error.
  ///
  /// [tampilkanLoading] bernilai false saat pull-to-refresh agar daftar lama
  /// tetap terlihat selama data baru diambil.
  Future<void> _muatData({bool tampilkanLoading = true}) async {
    if (tampilkanLoading) {
      setState(() {
        _sedangMemuat = true;
        _pesanError = null;
      });
    }

    try {
      final hasil = widget.pengambilData != null
          ? await widget.pengambilData!()
          : await IntegrasiService.ambilDataTerintegrasi();
      if (!mounted) return;
      setState(() {
        _daftar = hasil;
        _pesanError = null;
        _sedangMemuat = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _pesanError = e is ApiException
            ? e.pesan
            : 'Terjadi kesalahan saat memuat data.';
        _sedangMemuat = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16,
        title: const _MerekAplikasi(),
        actions: [
          IconButton(
            onPressed: _sedangMemuat ? null : () => _muatData(),
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Muat ulang',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _bangunKonten(),
    );
  }

  /// Menentukan tampilan berdasarkan state. Kondisi kosong sengaja dibedakan
  /// dari error: kosong berarti request berhasil tetapi belum ada pesanan,
  /// sedangkan error berarti request gagal.
  Widget _bangunKonten() {
    // Kondisi 1 — loading.
    if (_sedangMemuat) {
      return const TampilanLoading();
    }

    // Kondisi 2 — error, dengan tombol coba lagi.
    if (_pesanError != null) {
      return TampilanError(
        pesan: _pesanError!,
        onCobaLagi: () => _muatData(),
      );
    }

    // Kondisi 3 — data kosong.
    if (_daftar.isEmpty) {
      return TampilanKosong(onMuatUlang: () => _muatData());
    }

    // Kondisi 4 — sukses.
    return RefreshIndicator(
      onRefresh: () => _muatData(tampilkanLoading: false),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 32),
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 960),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  KepalaRingkasan(daftar: _daftar),
                  const SizedBox(height: 20),
                  _JudulDaftar(jumlah: _daftar.length),
                  const SizedBox(height: 12),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      // Dua kolom pada layar lebar agar nyaman dibaca di web.
                      final duaKolom = constraints.maxWidth >= 760;
                      final lebarKartu = duaKolom
                          ? (constraints.maxWidth - 12) / 2
                          : constraints.maxWidth;

                      return Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          for (final pesanan in _daftar)
                            SizedBox(
                              width: lebarKartu,
                              child: KartuPesanan(pesanan: pesanan),
                            ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 18),
                  const _CatatanSumberData(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Merek kecil di AppBar: ikon berwarna + nama aplikasi dan keterangannya.
class _MerekAplikasi extends StatelessWidget {
  const _MerekAplikasi();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1273D4), Color(0xFF0A3F7A)],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.cleaning_services_rounded,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(width: 11),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Glazent.pro',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.2,
              ),
            ),
            Text(
              'Pesanan terintegrasi',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Header gradien: sapaan, jumlah pesanan, dan ringkasan per status.
class KepalaRingkasan extends StatelessWidget {
  const KepalaRingkasan({super.key, required this.daftar});

  final List<PesananRingkas> daftar;

  int _hitung(StatusPesanan status) {
    return daftar.where((p) => p.status == status).length;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0B63B6), Color(0xFF0A3F7A)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0B63B6).withValues(alpha: 0.28),
            blurRadius: 26,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Ornamen lingkaran transparan agar header tidak terasa datar.
          Positioned(
            right: -36,
            top: -52,
            child: _Lingkaran(ukuran: 170, opacity: 0.09),
          ),
          Positioned(
            right: 84,
            bottom: -64,
            child: _Lingkaran(ukuran: 132, opacity: 0.06),
          ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.16),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.18),
                        ),
                      ),
                      child: const Icon(
                        Icons.auto_awesome_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 13),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Halo, Rani!',
                            style: textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Pesanan Glazent.pro Anda sudah dirangkum.',
                            style: textTheme.bodySmall?.copyWith(
                              color: Colors.white.withValues(alpha: 0.78),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${daftar.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 42,
                        height: 1,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(width: 9),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        'pesanan aktif',
                        style: textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.78),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _PilStatus(
                      label: 'Menunggu',
                      nilai: _hitung(StatusPesanan.menunggu),
                      icon: Icons.schedule_rounded,
                    ),
                    _PilStatus(
                      label: 'Dijadwalkan',
                      nilai: _hitung(StatusPesanan.dijadwalkan),
                      icon: Icons.event_available_rounded,
                    ),
                    _PilStatus(
                      label: 'Selesai',
                      nilai: _hitung(StatusPesanan.selesai),
                      icon: Icons.check_circle_rounded,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Lingkaran dekoratif pada header.
class _Lingkaran extends StatelessWidget {
  const _Lingkaran({required this.ukuran, required this.opacity});

  final double ukuran;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ukuran,
      height: ukuran,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: opacity),
      ),
    );
  }
}

/// Pil ringkasan jumlah pesanan per status.
class _PilStatus extends StatelessWidget {
  const _PilStatus({
    required this.label,
    required this.nilai,
    required this.icon,
  });

  final String label;
  final int nilai;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            '$nilai $label',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// Judul bagian daftar beserta jumlah data.
class _JudulDaftar extends StatelessWidget {
  const _JudulDaftar({required this.jumlah});

  final int jumlah;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Daftar Pesanan',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Data pelanggan, pesanan, dan progres teknisi digabungkan '
                'otomatis.',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            '$jumlah data',
            style: textTheme.labelSmall?.copyWith(
              color: colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

/// Satu pesanan: ikon layanan, nama layanan, pelanggan, status, dan id.
class KartuPesanan extends StatelessWidget {
  const KartuPesanan({super.key, required this.pesanan});

  final PesananRingkas pesanan;

  /// Nama layanan contoh berbahasa Indonesia, dipilih konsisten dari id.
  String get _layananTampil {
    final indeks = pesanan.id <= 0
        ? 0
        : (pesanan.id - 1) % _layananContoh.length;
    return _layananContoh[indeks];
  }

  /// Nama dan kota pelanggan contoh, dipilih konsisten dari userId.
  ({String nama, String kota}) get _pelangganTampil {
    final indeks = pesanan.userId <= 0
        ? 0
        : (pesanan.userId - 1) % _pelangganContoh.length;
    return _pelangganContoh[indeks];
  }

  /// Ikon menyesuaikan jenis layanan agar kartu lebih mudah dipindai.
  IconData get _ikon {
    final nama = _layananTampil.toLowerCase();
    if (nama.contains('nano')) return Icons.shield_outlined;
    if (nama.contains('kanopi')) return Icons.roofing_outlined;
    if (nama.contains('facade') || nama.contains('gedung')) {
      return Icons.apartment_rounded;
    }
    if (nama.contains('mobil')) return Icons.directions_car_outlined;
    return Icons.cleaning_services_outlined;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(_ikon, color: colorScheme.onPrimaryContainer),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          _layananTampil,
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            height: 1.25,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 10),
                      ChipStatus(status: pesanan.status),
                    ],
                  ),
                  const SizedBox(height: 9),
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline_rounded,
                        size: 15,
                        color: colorScheme.outline,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          '${_pelangganTampil.nama} • ${_pelangganTampil.kota}',
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 11),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest.withValues(
                        alpha: 0.6,
                      ),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Text(
                      'Pesanan #${pesanan.id}',
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Label status berbentuk pil berwarna — warna diambil dari tema.
class ChipStatus extends StatelessWidget {
  const ChipStatus({super.key, required this.status});

  final StatusPesanan status;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final (Color latar, Color teks, IconData ikon) = switch (status) {
      StatusPesanan.selesai => (
        colorScheme.tertiaryContainer,
        colorScheme.onTertiaryContainer,
        Icons.check_circle_rounded,
      ),
      StatusPesanan.dijadwalkan => (
        colorScheme.primaryContainer,
        colorScheme.onPrimaryContainer,
        Icons.event_available_rounded,
      ),
      StatusPesanan.menunggu => (
        colorScheme.secondaryContainer,
        colorScheme.onSecondaryContainer,
        Icons.schedule_rounded,
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: latar,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(ikon, size: 13, color: teks),
          const SizedBox(width: 5),
          Text(
            status.label,
            style: TextStyle(
              color: teks,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

/// Kondisi loading — indikator berputar disertai teks agar jelas bahwa
/// aplikasi sedang menghubungi server.
class TampilanLoading extends StatelessWidget {
  const TampilanLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 82,
              height: 82,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.primary.withValues(alpha: 0.12),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const CircularProgressIndicator(strokeWidth: 4),
            ),
            const SizedBox(height: 24),
            Text(
              'Menyiapkan pesanan Anda...',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 360),
              child: Text(
                'Mengambil data pelanggan, pesanan, dan progres pekerjaan '
                'secara bersamaan.',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Kondisi error — pesan informatif tanpa detail teknis dan tombol coba lagi.
class TampilanError extends StatelessWidget {
  const TampilanError({
    super.key,
    required this.pesan,
    required this.onCobaLagi,
  });

  final String pesan;
  final VoidCallback onCobaLagi;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: colorScheme.outlineVariant),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: colorScheme.errorContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.cloud_off_rounded,
                    size: 34,
                    color: colorScheme.onErrorContainer,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Gagal Memuat Pesanan',
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  pesan,
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 22),
                FilledButton.icon(
                  onPressed: onCobaLagi,
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Coba Lagi'),
                ),
                const SizedBox(height: 14),
                Text(
                  'Periksa koneksi internet Anda, lalu coba lagi.',
                  style: textTheme.labelSmall?.copyWith(
                    color: colorScheme.outline,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Keadaan kosong — request berhasil, tetapi belum ada pesanan. Bukan error.
class TampilanKosong extends StatelessWidget {
  const TampilanKosong({super.key, required this.onMuatUlang});

  final VoidCallback onMuatUlang;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: colorScheme.outlineVariant),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    color: colorScheme.secondaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.inbox_rounded,
                    size: 36,
                    color: colorScheme.onSecondaryContainer,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Belum ada pesanan',
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Pesanan dari pelanggan akan tampil di sini setelah data '
                  'tersedia di server.',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.45,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 22),
                OutlinedButton.icon(
                  onPressed: onMuatUlang,
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Muat Ulang'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Catatan kecil di bawah daftar — menjelaskan asal data yang ditampilkan.
class _CatatanSumberData extends StatelessWidget {
  const _CatatanSumberData();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.info_outline_rounded, size: 14, color: colorScheme.outline),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            'Data gabungan dari endpoint pelanggan, pesanan, dan progres '
            'pekerjaan (API simulasi).',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: colorScheme.outline,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
