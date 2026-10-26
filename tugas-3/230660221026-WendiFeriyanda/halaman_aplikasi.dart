// Bantuan: ChatGPT — membantu memahami instruksi Tugas 3,
// menjelaskan penggunaan widget Flutter, dan membantu
// menyusun struktur awal halaman SI RAKUS.

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Aplikasi utama.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SI RAKUS — Sistem Rak Kampus',
      debugShowCheckedModeBanner: false,
      home: const HalamanPerpustakaan(),
    );
  }
}

/// Halaman utama SI RAKUS.
class HalamanPerpustakaan extends StatelessWidget {
  const HalamanPerpustakaan({super.key});

  @override
  Widget build(BuildContext context) {
    // Data buku
    final daftarBuku = [
      {
        'judul': 'Dasar Pemrograman Dart',
        'penulis': 'Tim PAB',
        'stok': '12',
      },
      {
        'judul': 'Sistem Informasi',
        'penulis': 'Andi Kristanto',
        'stok': '4',
      },
      {
        'judul': 'Flutter untuk Pemula',
        'penulis': 'Rina Kurnia',
        'stok': '0',
      },
      {
        'judul': 'Basis Data',
        'penulis': 'Budi Raharjo',
        'stok': '7',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('SI RAKUS'),
        centerTitle: true,
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Selamat Datang di SI RAKUS',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 16),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: daftarBuku.length,
            itemBuilder: (context, index) {
              final buku = daftarBuku[index];

              return BukuListTile(
                judul: buku['judul']!,
                penulis: buku['penulis']!,
                stok: buku['stok']!,
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Satu baris buku.
class BukuListTile extends StatelessWidget {
  const BukuListTile({
    super.key,
    required this.judul,
    required this.penulis,
    required this.stok,
  });

  final String judul;
  final String penulis;
  final String stok;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        children: [
          const Icon(Icons.menu_book),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  judul,
                  style: const TextStyle(fontSize: 15),
                ),
                Text(
                  penulis,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          Text(
            'Stok: $stok',
            style: TextStyle(
              color: stok == '0'
                  ? Colors.grey
                  : Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}