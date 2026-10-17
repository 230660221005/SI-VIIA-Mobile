import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perpustakaan Kampus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const KatalogBukuPage(),
    );
  }
}

class KatalogBukuPage extends StatelessWidget {
  const KatalogBukuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    final List<Map<String, Object>> buku = [
      {'judul': 'Pemrograman Dart Dasar', 'penulis': 'A. Putra', 'stok': 3},
      {'judul': 'Flutter Widget Handbook', 'penulis': 'B. Sari', 'stok': 0},
      {'judul': 'Basis Data untuk SI', 'penulis': 'C. Dewi', 'stok': 5},
      {'judul': 'Rekayasa Perangkat Lunak', 'penulis': 'D. Pratama', 'stok': 1},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Buku'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Ajukan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Perpustakaan Kampus',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Cari buku dan lihat ketersediaan sebelum meminjam.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black54,
                  ),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                hintText: 'Cari judul / penulis...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: buku.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.menu_book, size: 48, color: color.primary),
                          const SizedBox(height: 12),
                          const Text(
                            'Belum ada buku ditampilkan',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Coba muat ulang atau ubah kata kunci.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: buku.length,
                      itemBuilder: (context, i) {
                        final item = buku[i];
                        final judul = item['judul'] as String;
                        final penulis = item['penulis'] as String;
                        final stok = item['stok'] as int;

                        final tersedia = stok > 0;
                        final label = tersedia ? 'Tersedia ($stok)' : 'Habis';
                        final warna = tersedia ? color.primary : Colors.grey;

                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.book),
                            title: Text(judul),
                            subtitle: Text('Penulis: $penulis'),
                            trailing: Chip(
                              label: Text(label),
                              labelStyle: TextStyle(
                                color: warna,
                                fontWeight: FontWeight.w600,
                              ),
                              backgroundColor: warna.withValues(alpha: 0.12),
                              side: BorderSide(color: warna),
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