
import 'package:flutter/material.dart';

void main() {
  runApp(const SiRuangKampusApp());
}

class SiRuangKampusApp extends StatelessWidget {
  const SiRuangKampusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SiRuang Kampus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const HalamanDaftarRuangan(),
    );
  }
}

class Ruangan {
  final String nama;
  final String kategori;
  final bool tersedia;

  const Ruangan({
    required this.nama,
    required this.kategori,
    required this.tersedia,
  });
}

class HalamanDaftarRuangan extends StatelessWidget {
  const HalamanDaftarRuangan({super.key});

  // Data ruangan dapat dikosongkan untuk menguji empty state.
  static const List<Ruangan> daftarRuangan = [
    Ruangan(
      nama: 'Ruang 1',
      kategori: 'Ruang Kelas',
      tersedia: true,
    ),
    Ruangan(
      nama: 'Ruang 2',
      kategori: 'Laboratorium',
      tersedia: false,
    ),
    Ruangan(
      nama: 'Ruang 3',
      kategori: 'Ruang Kelas',
      tersedia: true,
    ),
    Ruangan(
      nama: 'Ruang 4',
      kategori: 'Laboratorium',
      tersedia: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final warna = tema.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SiRuang Kampus'),
        backgroundColor: warna.primaryContainer,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daftar Ruangan',
              style: tema.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Pilih ruangan sesuai kebutuhanmu.',
              style: tema.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: daftarRuangan.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.meeting_room_outlined,
                            size: 64,
                            color: warna.onSurfaceVariant,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Belum ada ruangan tersedia',
                            style: tema.textTheme.titleMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Data ruangan akan ditampilkan di sini.',
                            textAlign: TextAlign.center,
                            style: tema.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: daftarRuangan.length,
                      itemBuilder: (context, index) {
                        final ruangan = daftarRuangan[index];

                        final warnaStatus = ruangan.tersedia
                            ? warna.tertiaryContainer
                            : warna.errorContainer;

                        final warnaTeksStatus = ruangan.tersedia
                            ? warna.onTertiaryContainer
                            : warna.onErrorContainer;

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),
                            leading: CircleAvatar(
                              backgroundColor: warna.primaryContainer,
                              child: Icon(
                                Icons.meeting_room_outlined,
                                color: warna.onPrimaryContainer,
                              ),
                            ),
                            title: Text(
                              ruangan.nama,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(ruangan.kategori),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: warnaStatus,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      ruangan.tersedia
                                          ? 'Tersedia'
                                          : 'Dipakai',
                                      style: tema.textTheme.labelMedium
                                          ?.copyWith(
                                        color: warnaTeksStatus,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            trailing: const Icon(Icons.chevron_right),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Fitur pengajuan peminjaman dikembangkan pada tahap berikutnya.',
              ),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Ajukan Peminjaman'),
      ),
    );
  }
}
