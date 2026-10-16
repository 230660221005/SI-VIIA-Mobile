
import 'package:flutter/material.dart';

void main() {
  runApp(const SiFaskamApp());
}

class SiFaskamApp extends StatelessWidget {
  const SiFaskamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SI-FASKAM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
        ),
        useMaterial3: true,
      ),
      home: const HalamanPengaduan(),
    );
  }
}

class HalamanPengaduan extends StatelessWidget {
  const HalamanPengaduan({super.key});

  final List<Map<String, String>> pengaduan = const [
    {
      'nama': 'Proyektor Kelas',
      'lokasi': 'Ruang A201',
      'status': 'Diproses',
    },
    {
      'nama': 'AC Ruangan',
      'lokasi': 'Ruang B102',
      'status': 'Menunggu',
    },
    {
      'nama': 'Lampu Kelas',
      'lokasi': 'Ruang A103',
      'status': 'Selesai',
    },
    {
      'nama': 'Jaringan Wi-Fi',
      'lokasi': 'Perpustakaan',
      'status': 'Diproses',
    },
  ];

  Color warnaStatus(String status) {
    switch (status) {
      case 'Selesai':
        return Colors.green;
      case 'Diproses':
        return Colors.blue;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SI-FASKAM',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pengaduan Fasilitas Kampus',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Laporkan dan pantau kondisi fasilitas kampus.',
            ),
            const SizedBox(height: 16),

            // Layout Row
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.assignment_outlined,
                    color: Colors.teal,
                    size: 32,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '${pengaduan.length} Laporan Fasilitas',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Daftar Pengaduan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Layout ListView.builder
            Expanded(
              child: ListView.builder(
                itemCount: pengaduan.length,
                itemBuilder: (context, index) {
                  final item = pengaduan[index];
                  final status = item['status']!;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal.shade50,
                        child: const Icon(
                          Icons.build_outlined,
                          color: Colors.teal,
                        ),
                      ),
                      title: Text(
                        item['nama']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Lokasi: ${item['lokasi']}'),
                            const SizedBox(height: 5),
                            Text(
                              'Status: $status',
                              style: TextStyle(
                                color: warnaStatus(status),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      isThreeLine: true,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Fitur tambah laporan belum tersedia.'),
            ),
          );
        },
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        tooltip: 'Tambah laporan',
        child: const Icon(Icons.add),
      ),
    );
  }
}
