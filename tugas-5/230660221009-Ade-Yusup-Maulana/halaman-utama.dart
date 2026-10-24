import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiPenjualanWarung());
}

class AplikasiPenjualanWarung extends StatelessWidget {
  const AplikasiPenjualanWarung({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PAB - Penjualan Warung',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const HalamanUtama(),
    );
  }
}

class HalamanUtama extends StatelessWidget {
  const HalamanUtama({super.key});

  final List<Map<String, String>> daftarProduk = const [
    {
      'nama': 'Nasi Goreng',
      'harga': 'Rp15.000',
      'status': 'Tersedia',
    },
    {
      'nama': 'Mie Instan',
      'harga': 'Rp8.000',
      'status': 'Tersedia',
    },
    {
      'nama': 'Kopi',
      'harga': 'Rp5.000',
      'status': 'Tersedia',
    },
    {
      'nama': 'Teh Manis',
      'harga': 'Rp4.000',
      'status': 'Habis',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final warnaTema = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Produk'),
      ),

      body: daftarProduk.isEmpty
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 64,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Belum ada produk tersedia',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: daftarProduk.length,
              itemBuilder: (context, index) {
                final produk = daftarProduk[index];
                final tersedia = produk['status'] == 'Tersedia';

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Icon(
                      Icons.fastfood,
                      color: warnaTema.primary,
                    ),
                    title: Text(
                      produk['nama']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      produk['harga']!,
                    ),
                    trailing: Text(
                      produk['status']!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: tersedia
                            ? warnaTema.primary
                            : warnaTema.error,
                      ),
                    ),
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Tambah Produk'),
      ),
    );
  }
}