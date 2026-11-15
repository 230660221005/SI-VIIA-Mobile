import 'package:flutter/material.dart';
import 'service-api.dart';

class HalamanApi extends StatefulWidget {
  const HalamanApi({super.key});

  @override
  State<HalamanApi> createState() => _HalamanApiState();
}

class _HalamanApiState extends State<HalamanApi> {
  final ServiceApi serviceApi = ServiceApi();

  final TextEditingController judulController = TextEditingController();
  final TextEditingController keteranganController = TextEditingController();

  List<LaporanApi> daftarLaporan = [];

  bool sedangMemuat = false;
  bool sedangMengirim = false;
  String? pesanError;

  @override
  void initState() {
    super.initState();
    muatData();
  }

  // Mengambil data dari API menggunakan GET
  Future<void> muatData() async {
    setState(() {
      sedangMemuat = true;
      pesanError = null;
    });

    try {
      await Future.delayed(const Duration(seconds: 3));

      final hasil = await serviceApi.getLaporan();

      if (!mounted) return;

      setState(() {
        daftarLaporan = hasil;
        sedangMemuat = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        pesanError = e.toString();
        sedangMemuat = false;
      });
    }
  }

  // Mengirim laporan ke API menggunakan POST
  Future<void> kirimData() async {
    if (judulController.text.trim().isEmpty ||
        keteranganController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Judul dan keterangan harus diisi!'),
        ),
      );
      return;
    }

    setState(() {
      sedangMengirim = true;
    });

    try {
      final hasil = await serviceApi.kirimLaporan(
        judul: judulController.text.trim(),
        keterangan: keteranganController.text.trim(),
        userId: 1,
      );

      if (!mounted) return;

      setState(() {
        daftarLaporan.insert(0, hasil);
        sedangMengirim = false;
      });

      judulController.clear();
      keteranganController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Laporan berhasil dikirim ke API!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        sedangMengirim = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal mengirim laporan: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    judulController.dispose();
    keteranganController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F8F6),
      appBar: AppBar(
        title: const Text(
          'SIAngkut - Integrasi API',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF14877C),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: RefreshIndicator(
        onRefresh: muatData,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Judul halaman
            const Text(
              'Data Laporan Pengangkutan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF203B37),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Data diambil dari REST API menggunakan metode GET.',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 16),

            // Tampilan loading
            if (sedangMemuat)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    children: [
                      CircularProgressIndicator(
                        color: Color(0xFF14877C),
                      ),
                      SizedBox(height: 12),
                      Text('Sedang mengambil data...'),
                    ],
                  ),
                ),
              )

            // Tampilan error dan tombol retry
            else if (pesanError != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 45,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Gagal Memuat Data',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        pesanError!,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 14),
                      ElevatedButton.icon(
                        onPressed: muatData,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Coba Lagi'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF14877C),
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              )

            // Tampilan data berhasil dimuat
            else if (daftarLaporan.isNotEmpty)
              ...daftarLaporan.map(
                (laporan) => Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFFD9F0EA),
                      child: Text(
                        laporan.id.toString(),
                        style: const TextStyle(
                          color: Color(0xFF14877C),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      laporan.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(laporan.body),
                  ),
                ),
              ),

            const SizedBox(height: 24),
            const Divider(),

            // Form untuk mengirim data menggunakan POST
            const Text(
              'Form Laporan Sampah',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF203B37),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Isi formulir berikut untuk mengirim laporan melalui API.',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: judulController,
              decoration: const InputDecoration(
                labelText: 'Judul Laporan',
                hintText: 'Contoh: Sampah belum diangkut',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.edit),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: keteranganController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Keterangan Laporan',
                hintText: 'Jelaskan kondisi sampah...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),

            SizedBox(
              height: 48,
              child: ElevatedButton.icon(
                onPressed: sedangMengirim ? null : kirimData,
                icon: sedangMengirim
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.send),
                label: Text(
                  sedangMengirim ? 'Mengirim Laporan...' : 'Kirim Laporan',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF14877C),
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
