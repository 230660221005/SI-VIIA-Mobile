
import 'package:flutter/material.dart';

void main() {
  runApp(const PerpustakaanApp());
}

class PerpustakaanApp extends StatelessWidget {
  const PerpustakaanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perpustakaan Kampus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HalamanUtama(),
    );
  }
}

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  final TextEditingController pencarianController =
      TextEditingController();

  final List<Map<String, String>> daftarBuku = [
    {
      'judul': 'Struktur Data & Algoritma',
      'penulis': 'Robert Lafore',
      'kategori': 'Ilmu Komputer',
      'status': 'Tersedia',
    },
    {
      'judul': 'Pengantar Psikologi Umum',
      'penulis': 'S. S. S. Santoso',
      'kategori': 'Psikologi',
      'status': 'Tersedia',
    },
    {
      'judul': 'Metode Penelitian Kualitatif',
      'penulis': 'Lexy J. Moleong',
      'kategori': 'Penelitian',
      'status': 'Sedang Dipinjam',
    },
    {
      'judul': 'Basis Data',
      'penulis': 'Dewi Lestari',
      'kategori': 'Ilmu Komputer',
      'status': 'Tersedia',
    },
  ];

  String kataKunci = '';

  List<Map<String, String>> get bukuTampil {
    return daftarBuku.where((buku) {
      final judul = buku['judul']!.toLowerCase();
      final penulis = buku['penulis']!.toLowerCase();

      return judul.contains(kataKunci.toLowerCase()) ||
          penulis.contains(kataKunci.toLowerCase());
    }).toList();
  }

  @override
  void dispose() {
    pencarianController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perpustakaan Kampus',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Halo, Mahasiswa!',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Temukan buku yang Anda butuhkan '
                  'untuk menunjang kegiatan belajar dan penelitian.',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: pencarianController,
                  onChanged: (value) {
                    setState(() {
                      kataKunci = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Cari judul buku atau penulis...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Daftar Buku',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: bukuTampil.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.menu_book_outlined,
                          size: 48,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 12),
                        Text('Buku tidak ditemukan'),
                        Text(
                          'Coba kata kunci lainnya.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    itemCount: bukuTampil.length,
                    itemBuilder: (context, index) {
                      final buku = bukuTampil[index];
                      final tersedia =
                          buku['status'] == 'Tersedia';

                      return Card(
                        margin: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: ListTile(
                          contentPadding:
                              const EdgeInsets.all(12),
                          leading: const CircleAvatar(
                            child: Icon(Icons.menu_book),
                          ),
                          title: Text(
                            buku['judul']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(buku['penulis']!),
                              Text(
                                buku['kategori']!,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Chip(
                                label: Text(buku['status']!),
                                backgroundColor: tersedia
                                    ? Colors.green.shade100
                                    : Colors.orange.shade100,
                                visualDensity:
                                    VisualDensity.compact,
                              ),
                            ],
                          ),
                          isThreeLine: true,
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Pilih buku yang tersedia untuk '
                        'melanjutkan peminjaman.',
                      ),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text('Pinjam Buku'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
