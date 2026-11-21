
import 'package:flutter/material.dart';
import 'models/data_pengajuan.dart';
import 'services/integrasi_service.dart';

void main() {
  runApp(const SiRuangApp());
}

class SiRuangApp extends StatelessWidget {
  const SiRuangApp({super.key});

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
      home: const HalamanIntegrasi(),
    );
  }
}

class HalamanIntegrasi extends StatefulWidget {
  const HalamanIntegrasi({super.key});

  @override
  State<HalamanIntegrasi> createState() =>
      _HalamanIntegrasiState();
}

class _HalamanIntegrasiState extends State<HalamanIntegrasi> {
  final IntegrasiService service = IntegrasiService();

  List<DataPengajuan> daftarPengajuan = [];
  bool isLoading = true;
  String? pesanError;

  @override
  void initState() {
    super.initState();
    ambilData();
  }

  Future<void> ambilData() async {
    setState(() {
      isLoading = true;
      pesanError = null;
    });

    try {
      final hasil = await service.integrasiData(); 

      if (!mounted) return;

      setState(() {
        daftarPengajuan = hasil;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        pesanError = e.toString();
        isLoading = false;
      });
    }
  }

  Widget tampilkanKonten() {
    // Kondisi loading
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // Kondisi error
    if (pesanError != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 55,
              ),
              const SizedBox(height: 12),
              const Text(
                'Gagal Memuat Data',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                pesanError!,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: ambilData,
                icon: const Icon(Icons.refresh),
                label: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      );
    }

    // Kondisi data kosong
    if (daftarPengajuan.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.inbox_outlined,
              size: 55,
              color: Colors.grey,
            ),
            const SizedBox(height: 12),
            const Text(
              'Belum ada pengajuan peminjaman',
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: ambilData,
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      );
    }

    // Kondisi data berhasil
    return RefreshIndicator(
      onRefresh: ambilData,
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: daftarPengajuan.length,
        itemBuilder: (context, index) {
          final pengajuan = daftarPengajuan[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${pengajuan.id}'),
              ),
              title: Text(
                pengajuan.judul,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  Text(
                    'Pemohon: ${pengajuan.namaPengguna}',
                  ),
                  Text(
                    'User ID: ${pengajuan.userId}',
                  ),
                  const SizedBox(height: 4),
                  Text(pengajuan.deskripsi),
                ],
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SiRuang Kampus'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: isLoading ? null : ambilData,
            icon: const Icon(Icons.refresh),
            tooltip: 'Muat ulang data',
          ),
        ],
      ),
      body: tampilkanKonten(),
    );
  }
}
