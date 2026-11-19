// Tugas 10 PAB: Integrasi Data dan Proses Bisnis (antarmuka)
// Nama: Galih Permana Sidik | NIM 230660221002 | SI-VIIA
//
// Halaman tidak memuat kode HTTP maupun parsing JSON. Semua lewat
// IntegrasiService. Empat kondisi: loading, data, kosong, error (dengan tombol
// Coba Lagi).
//
// Bantuan: Claude, menyusun pola kondisi halaman dan pengecekan `mounted`
// setelah await.

import 'package:flutter/material.dart';

import 'models/data_laporan.dart';
import 'models/laporan_ringkas.dart';
import 'services/integrasi_service.dart';

void main() => runApp(const SiLaporApp());

class SiLaporApp extends StatelessWidget {
  const SiLaporApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SiLapor Kampus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HalamanDaftarLaporan(),
    );
  }
}

class HalamanDaftarLaporan extends StatefulWidget {
  const HalamanDaftarLaporan({super.key});

  @override
  State<HalamanDaftarLaporan> createState() => _HalamanDaftarLaporanState();
}

class _HalamanDaftarLaporanState extends State<HalamanDaftarLaporan> {
  bool _memuat = true;
  String? _pesanError;
  List<LaporanRingkas> _semua = [];
  StatusLaporan? _filter; // null berarti semua status

  @override
  void initState() {
    super.initState();
    _muat();
  }

  // senyap = true dipakai tarik-untuk-muat-ulang, agar daftar tidak diganti
  // spinner di tengah gestur.
  Future<void> _muat({bool senyap = false}) async {
    if (!senyap) {
      setState(() {
        _memuat = true;
        _pesanError = null;
      });
    }

    try {
      final hasil = await IntegrasiService.ambilDataTerintegrasi();
      if (!mounted) return;
      setState(() {
        _semua = hasil;
        _pesanError = null;
        _memuat = false;
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        _pesanError = e.pesan;
        _memuat = false;
      });
    }
  }

  List<LaporanRingkas> get _terfilter {
    if (_filter == null) return _semua;
    return _semua.where((l) => l.status == _filter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SiLapor Kampus')),
      body: _bangunKonten(),
    );
  }

  Widget _bangunKonten() {
    // Kondisi 1: loading
    if (_memuat) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Memuat laporan dan data pelapor...'),
          ],
        ),
      );
    }

    // Kondisi 2: error request, dengan tombol Coba Lagi
    if (_pesanError != null) {
      return _PesanStatus(
        ikon: Icons.cloud_off,
        judul: 'Laporan gagal dimuat',
        pesan: _pesanError!,
        warnaIkon: Theme.of(context).colorScheme.error,
        labelTombol: 'Coba Lagi',
        onTombol: _muat,
      );
    }

    // Kondisi 3: data kosong dari server. Request berhasil, hanya tidak ada
    // isinya, jadi bukan error dan tidak memakai pesan kegagalan.
    if (_semua.isEmpty) {
      return _PesanStatus(
        ikon: Icons.inbox_outlined,
        judul: 'Belum ada laporan',
        pesan: 'Server tidak memiliki laporan untuk ditampilkan.',
        warnaIkon: Theme.of(context).colorScheme.outline,
        labelTombol: 'Muat Ulang',
        onTombol: _muat,
      );
    }

    // Kondisi 4: data berhasil dimuat
    final daftar = _terfilter;
    return Column(
      children: [
        _BarisFilter(
          dipilih: _filter,
          onPilih: (status) => setState(() => _filter = status),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => _muat(senyap: true),
            child: daftar.isEmpty
                ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(32),
                        child: Center(
                          child: Text(
                            'Tidak ada laporan berstatus ${_filter?.label}.',
                          ),
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                    itemCount: daftar.length,
                    itemBuilder: (context, index) => _KartuLaporan(daftar[index]),
                  ),
          ),
        ),
      ],
    );
  }
}

class _BarisFilter extends StatelessWidget {
  const _BarisFilter({required this.dipilih, required this.onPilih});

  final StatusLaporan? dipilih;
  final ValueChanged<StatusLaporan?> onPilih;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          ChoiceChip(
            label: const Text('Semua'),
            selected: dipilih == null,
            onSelected: (_) => onPilih(null),
          ),
          for (final status in StatusLaporan.values) ...[
            const SizedBox(width: 8),
            ChoiceChip(
              label: Text(status.label),
              selected: dipilih == status,
              onSelected: (_) => onPilih(status),
            ),
          ],
        ],
      ),
    );
  }
}

class _KartuLaporan extends StatelessWidget {
  const _KartuLaporan(this.laporan);

  final LaporanRingkas laporan;

  @override
  Widget build(BuildContext context) {
    final teks = Theme.of(context).textTheme;
    final warna = Theme.of(context).colorScheme;

    Color latar;
    switch (laporan.status) {
      case StatusLaporan.menunggu:
        latar = warna.tertiaryContainer;
        break;
      case StatusLaporan.diproses:
        latar = warna.secondaryContainer;
        break;
      case StatusLaporan.selesai:
        latar = warna.primaryContainer;
        break;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        isThreeLine: true,
        leading: Icon(Icons.report_problem_outlined, color: warna.primary),
        title: Text(
          laporan.judul,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: teks.titleSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pelapor: ${laporan.namaPelapor}'),
            Text(
              laporan.deskripsi,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: teks.bodySmall?.copyWith(color: warna.onSurfaceVariant),
            ),
          ],
        ),
        trailing: Chip(
          label: Text(laporan.status.label),
          backgroundColor: latar,
          side: BorderSide.none,
        ),
      ),
    );
  }
}

/// Tampilan tengah layar untuk kondisi error dan data kosong.
class _PesanStatus extends StatelessWidget {
  const _PesanStatus({
    required this.ikon,
    required this.judul,
    required this.pesan,
    required this.warnaIkon,
    required this.labelTombol,
    required this.onTombol,
  });

  final IconData ikon;
  final String judul;
  final String pesan;
  final Color warnaIkon;
  final String labelTombol;
  final VoidCallback onTombol;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(ikon, size: 56, color: warnaIkon),
            const SizedBox(height: 12),
            Text(judul, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(pesan, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: onTombol,
              icon: const Icon(Icons.refresh),
              label: Text(labelTombol),
            ),
          ],
        ),
      ),
    );
  }
}
