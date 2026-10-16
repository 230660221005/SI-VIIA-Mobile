import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiWarungApp());
}

class AplikasiWarungApp extends StatelessWidget {
  const AplikasiWarungApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Penjualan Warung',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const DashboardWarungPage(),
    );
  }
}

class DashboardWarungPage extends StatelessWidget {
  const DashboardWarungPage({super.key});

  // Data statis barang warung (4 entri sesuai domain Tugas 1 Warung Amelia)
  final List<Map<String, dynamic>> daftarBarang = const [
    {
      'namaBarang': 'Minyak Goreng 1L',
      'kategori': 'Sembako',
      'harga': 16000,
      'stok': 12,
    },
    {
      'namaBarang': 'Beras Premium 5kg',
      'kategori': 'Sembako',
      'harga': 68000,
      'stok': 3,
    },
    {
      'namaBarang': 'Mie Instan Goreng',
      'kategori': 'Makanan',
      'harga': 3100,
      'stok': 0, // Stok habis
    },
    {
      'namaBarang': 'Kopi Instant Sachet',
      'kategori': 'Minuman',
      'harga': 1500,
      'stok': 25,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Penjualan Warung'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Layout 1: Row (Header)
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Stok Barang Warung',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.storefront, color: Colors.teal),
              ],
            ),
            const SizedBox(height: 12),
            // Layout 2: Column + Layout 3: ListView.builder di dalam Expanded
            Expanded(
              child: ListView.builder(
                itemCount: daftarBarang.length,
                itemBuilder: (context, index) {
                  final barang = daftarBarang[index];
                  final int stok = barang['stok'] as int;
                  final bool stokAman = stok > 0;

                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.tealAccent,
                            child: Icon(Icons.shopping_bag, color: Colors.teal),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  barang['namaBarang'] as String,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Rp ${barang['harga']} | Kategori: ${barang['kategori']}',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Indikator Stok dengan kondisi Ternary
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: stokAman ? Colors.green.shade100 : Colors.red.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              stokAman ? 'Stok: $stok' : 'Habis',
                              style: TextStyle(
                                color: stokAman ? Colors.green.shade800 : Colors.red.shade800,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add_shopping_cart),
        label: const Text('Tambah Transaksi'),
      ),
    );
  }
}