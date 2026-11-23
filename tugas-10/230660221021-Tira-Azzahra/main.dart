import 'package:flutter/material.dart';
import 'models/peminjaman_ringkas.dart';
import 'services/perpustakaan_service.dart';

void main() {
  runApp(const PerpustakaanKampusApp());
}

class PerpustakaanKampusApp extends StatelessWidget {
  const PerpustakaanKampusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SI Perpustakaan Kampus',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1D4ED8)),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      ),
      home: const HalamanPeminjamanTerintegrasi(),
    );
  }
}

class HalamanPeminjamanTerintegrasi extends StatefulWidget {
  const HalamanPeminjamanTerintegrasi({super.key});

  @override
  State<HalamanPeminjamanTerintegrasi> createState() =>
      _HalamanPeminjamanTerintegrasiState();
}

class _HalamanPeminjamanTerintegrasiState
    extends State<HalamanPeminjamanTerintegrasi> {
  bool _sedangMemuat = true;
  String? _pesanError;
  List<PeminjamanRingkas> _daftarPeminjaman = [];

  @override
  void initState() {
    super.initState();
    _muatData();
  }

  Future<void> _muatData() async {
    setState(() {
      _sedangMemuat = true;
      _pesanError = null;
    });

    try {
      final hasil =
          await PerpustakaanService.ambilDataPeminjamanTerintegrasi();
      if (!mounted) return;
      setState(() {
        _daftarPeminjaman = hasil;
        _sedangMemuat = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _pesanError = e.toString().replaceFirst('Exception: ', '');
        _sedangMemuat = false;
      });
    }
  }

  Color _warnaStatus(String status) {
    switch (status) {
      case 'disetujui':
        return const Color(0xFF10B981);
      case 'ditolak':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFFF59E0B);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengajuan Peminjaman Buku'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Muat Ulang Data',
            onPressed: _muatData,
          ),
        ],
      ),
      body: _bangunKonten(),
    );
  }

  Widget _bangunKonten() {
    // 1. State Loading
    if (_sedangMemuat) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 12),
            Text('Memuat data anggota dan pengajuan buku...'),
          ],
        ),
      );
    }

    // 2. State Error + Tombol Coba Lagi
    if (_pesanError != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.redAccent),
              const SizedBox(height: 12),
              Text(
                _pesanError!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _muatData,
                icon: const Icon(Icons.refresh),
                label: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      );
    }

    // 3. State Data Kosong
    if (_daftarPeminjaman.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.menu_book_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 12),
            Text('Belum ada pengajuan peminjaman buku.'),
          ],
        ),
      );
    }

    // 4. State Data Berhasil Dimuat
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _daftarPeminjaman.length,
      itemBuilder: (context, index) {
        final item = _daftarPeminjaman[index];
        final warnaBadge = _warnaStatus(item.status);

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.namaPeminjam,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: warnaBadge.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        item.status.toUpperCase(),
                        style: TextStyle(
                          color: warnaBadge,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item.emailPeminjam,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                const Divider(height: 18),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.book, size: 18, color: Color(0xFF1D4ED8)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item.judulBuku,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}