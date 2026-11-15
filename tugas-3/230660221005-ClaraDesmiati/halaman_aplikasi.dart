import 'package:flutter/material.dart';

void main() {
  runApp(const SiAngkutApp());
}

class SiAngkutApp extends StatelessWidget {
  const SiAngkutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SiAngkut',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
        ),
        useMaterial3: true,
      ),
      home: const HalamanUtama(),
    );
  }
}

class HalamanUtama extends StatelessWidget {
  const HalamanUtama({super.key});

  final List<Map<String, String>> jadwal = const [
    {'hari': 'Senin', 'lokasi': 'Dusun Margamulya', 'status': 'Selesai'},
    {'hari': 'Selasa', 'lokasi': 'Dusun Pakemitan', 'status': 'Terjadwal'},
    {'hari': 'Rabu', 'lokasi': 'Dusun Lembur Gedong', 'status': 'Terjadwal'},
    {'hari': 'Kamis', 'lokasi': 'Dusun Cicelot', 'status': 'Terjadwal'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SiAngkut'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Halo, Warga!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text('Informasi layanan angkutan sampah'),
            const SizedBox(height: 16),

            // Informasi biaya menggunakan Row
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.delete_outline,
                    size: 40,
                    color: Colors.teal,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Iuran Angkutan Sampah'),
                        Text(
                          'Rp15.000 / bulan',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              'Jadwal Layanan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Daftar jadwal menggunakan ListView.builder
            Expanded(
              child: ListView.builder(
                itemCount: jadwal.length,
                itemBuilder: (context, index) {
                  final item = jadwal[index];
                  final selesai = item['status'] == 'Selesai';

                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal.shade50,
                        child: const Icon(
                          Icons.local_shipping_outlined,
                          color: Colors.teal,
                        ),
                      ),
                      title: Text(item['hari']!),
                      subtitle: Text(item['lokasi']!),
                      trailing: Text(
                        item['status']!,
                        style: TextStyle(
                          color: selesai ? Colors.green : Colors.orange,
                          fontWeight: FontWeight.bold,
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
    );
  }
}
