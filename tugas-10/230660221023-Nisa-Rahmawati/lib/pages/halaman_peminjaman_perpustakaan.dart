import 'package:flutter/material.dart';

import '../models/detail_peminjaman_model.dart';
import '../services/perpustakaan_integrasi_service.dart';

class HalamanPeminjamanPerpustakaan extends StatefulWidget {
  const HalamanPeminjamanPerpustakaan({super.key});

  @override
  State<HalamanPeminjamanPerpustakaan> createState() =>
      _HalamanPeminjamanPerpustakaanState();
}

class _HalamanPeminjamanPerpustakaanState
    extends State<HalamanPeminjamanPerpustakaan> {
  final PerpustakaanIntegrasiService _service = PerpustakaanIntegrasiService();

  bool _sedangMemuat = true;
  String? _pesanError;
  List<DetailPeminjamanModel> _daftarTerintegrasi = [];

  bool _modeSimulasiError = false;
  bool _modeSimulasiKosong = false;
  String _filterStatus = 'Semua';

  @override
  void initState() {
    super.initState();
    _muatDataTerintegrasi();
  }

  Future<void> _muatDataTerintegrasi() async {
    setState(() {
      _sedangMemuat = true;
      _pesanError = null;
    });

    try {
      final hasil = await _service.ambilDataPeminjamanTerintegrasi(
        simulasiError: _modeSimulasiError,
        simulasiKosong: _modeSimulasiKosong,
      );
      if (!mounted) return;
      setState(() {
        _daftarTerintegrasi = hasil;
        _sedangMemuat = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _pesanError = e.toString().replaceAll('Exception: ', '');
        _sedangMemuat = false;
      });
    }
  }

  List<DetailPeminjamanModel> get _dataTersaring {
    if (_filterStatus == 'Dipinjam') {
      return _daftarTerintegrasi.where((d) => !d.sudahKembali).toList();
    } else if (_filterStatus == 'Dikembalikan') {
      return _daftarTerintegrasi.where((d) => d.sudahKembali).toList();
    }
    return _daftarTerintegrasi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Integrasi Peminjaman Perpustakaan',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: _modeSimulasiKosong
                ? 'Matikan Simulasi Kosong'
                : 'Simulasikan Data Kosong',
            icon: Icon(
              _modeSimulasiKosong ? Icons.inbox : Icons.inbox_outlined,
            ),
            onPressed: () {
              setState(() {
                _modeSimulasiKosong = !_modeSimulasiKosong;
                if (_modeSimulasiKosong) _modeSimulasiError = false;
              });
              _muatDataTerintegrasi();
            },
          ),
          IconButton(
            tooltip: _modeSimulasiError
                ? 'Kembalikan Endpoint Normal'
                : 'Simulasikan Error Request',
            icon: Icon(_modeSimulasiError ? Icons.link_off : Icons.link),
            onPressed: () {
              setState(() {
                _modeSimulasiError = !_modeSimulasiError;
                if (_modeSimulasiError) _modeSimulasiKosong = false;
              });
              _muatDataTerintegrasi();
            },
          ),
          IconButton(
            tooltip: 'Muat Ulang Data',
            icon: const Icon(Icons.refresh),
            onPressed: _muatDataTerintegrasi,
          ),
        ],
      ),
      body: Column(
        children: [
          _bangunHeaderIdentitas(),
          Expanded(child: _bangunKontenState()),
        ],
      ),
    );
  }

  Widget _bangunHeaderIdentitas() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.blue.shade50,
      child: Row(
        children: [
          Icon(Icons.hub_rounded, size: 32, color: Colors.blue.shade800),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nisa Rahmawati (230660221023) — SI-VIIA',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                SizedBox(height: 2),
                Text(
                  'Integrasi: /users + /todos (Join via userId dengan Future.wait)',
                  style: TextStyle(fontSize: 11.5, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bangunKontenState() {
    // 1. STATE LOADING
    if (_sedangMemuat) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.blue.shade800),
            const SizedBox(height: 16),
            const Text(
              'Menggabungkan data anggota & peminjaman buku...',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      );
    }

    // 2. STATE ERROR REQUEST + TOMBOL COBA LAGI
    if (_pesanError != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.cloud_off_rounded,
                  size: 64, color: Colors.redAccent),
              const SizedBox(height: 16),
              const Text(
                'Gagal Memuat Integrasi Data',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                _pesanError!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red.shade700, fontSize: 13),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                    backgroundColor: Colors.blue.shade800),
                onPressed: _muatDataTerintegrasi,
                icon: const Icon(Icons.refresh),
                label: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      );
    }

    // 3. STATE DATA KOSONG
    if (_daftarTerintegrasi.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.menu_book_outlined,
                  size: 64, color: Colors.grey.shade500),
              const SizedBox(height: 16),
              const Text(
                'Data Peminjaman Kosong',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Belum ada transaksi peminjaman buku yang ditemukan dari server.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54, fontSize: 13),
              ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: () {
                  setState(() => _modeSimulasiKosong = false);
                  _muatDataTerintegrasi();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Muat Ulang Data'),
              ),
            ],
          ),
        ),
      );
    }

    // 4. STATE DATA BERHASIL DIMUAT
    final listTampil = _dataTersaring;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
          child: Row(
            children: [
              const Text('Filter: ',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              const SizedBox(width: 6),
              ...['Semua', 'Dipinjam', 'Dikembalikan'].map((label) {
                final bool terpilih = _filterStatus == label;
                return Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: ChoiceChip(
                    label: Text(label, style: const TextStyle(fontSize: 12)),
                    selected: terpilih,
                    onSelected: (_) => setState(() => _filterStatus = label),
                  ),
                );
              }),
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _muatDataTerintegrasi,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: listTampil.length,
              itemBuilder: (context, index) {
                final item = listTampil[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 1.5,
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: item.sudahKembali
                                  ? Colors.green.shade100
                                  : Colors.orange.shade100,
                              child: Icon(
                                item.sudahKembali
                                    ? Icons.check_circle
                                    : Icons.book_outlined,
                                color: item.sudahKembali
                                    ? Colors.green.shade800
                                    : Colors.orange.shade800,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.judulBuku,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.5,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Peminjam: ${item.namaPeminjam} (${item.nimPeminjam})',
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                  Text(
                                    'Unit/Prodi: ${item.prodiPeminjam}',
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Transaksi #${item.idPeminjaman} • User ID: ${item.userId}',
                              style: const TextStyle(
                                  fontSize: 11.5, color: Colors.black54),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: item.sudahKembali
                                    ? Colors.green.shade50
                                    : Colors.orange.shade50,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: item.sudahKembali
                                      ? Colors.green.shade300
                                      : Colors.orange.shade300,
                                ),
                              ),
                              child: Text(
                                item.statusPeminjaman,
                                style: TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                  color: item.sudahKembali
                                      ? Colors.green.shade800
                                      : Colors.orange.shade800,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}