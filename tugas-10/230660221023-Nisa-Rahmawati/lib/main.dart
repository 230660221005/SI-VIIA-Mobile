import 'package:flutter/material.dart';
import 'pages/halaman_peminjaman_perpustakaan.dart';

void main() {
  runApp(const AplikasiIntegrasiPerpustakaan());
}

class AplikasiIntegrasiPerpustakaan extends StatelessWidget {
  const AplikasiIntegrasiPerpustakaan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistem Informasi Perpustakaan — Tugas 10',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade800),
        useMaterial3: true,
      ),
      home: const HalamanPeminjamanPerpustakaan(),
    );
  }
}