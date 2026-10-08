// ============================================================================
// Bantuan AI: ChatGPT — membantu menyusun struktur widget Flutter
// (MaterialApp, Scaffold, Column, Row, Padding, Expanded, dan
// ListView.builder), serta menyesuaikan contoh dengan domain
// Peminjaman Ruang Kelas pada aplikasi SiRuang Kampus.
// ============================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const SiRuangKampusApp());
}

final List<Map<String, String>> daftarRuangan = [
  {
    'nama': 'Ruang 1',
    'kategori': 'Ruang Kelas',
    'status': 'Tersedia',
  },
  {
    'nama': 'Ruang 2',
    'kategori': 'Ruang Kelas',
    'status': 'Dipakai',
  },
  {
    'nama': 'Ruang 3',
    'kategori': 'Laboratorium',
    'status': 'Tersedia',
  },
  {
    'nama': 'Ruang 4',
    'kategori': 'Ruang Kelas',
    'status': 'Dipakai',
  },
];

class SiRuangKampusApp extends StatelessWidget {
  const SiRuangKampusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SiRuang Kampus',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SiRuang Kampus'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Daftar Ruang Kampus',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Lihat ketersediaan ruangan untuk kebutuhan perkuliahan.',
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  _infoCard(
                    'Total Ruang',
                    '${daftarRuangan.length}',
                  ),
                  const SizedBox(width: 12),
                  _infoCard(
                    'Tersedia',
                    '${daftarRuangan.where((r) => r['status'] == 'Tersedia').length}',
                  ),
                ],
              ),

              const SizedBox(height: 16),

              const Text(
                'Daftar Ruangan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Expanded(
                child: ListView.builder(
                  itemCount: daftarRuangan.length,
                  itemBuilder: (context, index) {
                    final ruangan = daftarRuangan[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        leading: const Icon(Icons.meeting_room),
                        title: Text(ruangan['nama']!),
                        subtitle: Text(ruangan['kategori']!),
                        trailing: Text(
                          ruangan['status']!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ruangan['status'] == 'Tersedia'
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _infoCard(String judul, String nilai) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(
                nilai,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(judul),
            ],
          ),
        ),
      ),
    );
  }
}