// Tugas 11 PAB: Integrasi Fitur Perangkat (antarmuka)
// Nama: Galih Permana Sidik | NIM 230660221002 | SI-VIIA
//
// Form Buat Laporan dengan lampiran foto kerusakan (F-01). Widget tidak
// mengimpor package perangkat. Semua lewat FotoService. Kondisi bagian foto:
// loading, berhasil (preview), dibatalkan (state sebelumnya dipertahankan),
// izin ditolak, tidak valid, dan error, masing-masing dengan tombol Coba Lagi.
//
// Bantuan: Claude, menyusun pola state bagian foto dan pengecekan `mounted`
// setelah await.

import 'package:flutter/material.dart';

import 'services/foto_service.dart';

void main() => runApp(const SiLaporApp());

class SiLaporApp extends StatelessWidget {
  const SiLaporApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SiLapor Kampus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HalamanBuatLaporan(),
    );
  }
}

class HalamanBuatLaporan extends StatefulWidget {
  const HalamanBuatLaporan({super.key});

  @override
  State<HalamanBuatLaporan> createState() => _HalamanBuatLaporanState();
}

class _HalamanBuatLaporanState extends State<HalamanBuatLaporan> {
  static const List<String> _daftarKategori = [
    'Proyektor',
    'AC',
    'Keran',
    'Kursi',
  ];

  final _formKey = GlobalKey<FormState>();
  final _lokasiController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final FotoService _fotoService = FotoService();

  String? _kategori;

  // State bagian foto.
  LampiranFoto? _lampiran;
  bool _memuat = false;
  FotoException? _kesalahan;
  SumberFoto _sumberTerakhir = SumberFoto.galeri;

  @override
  void dispose() {
    _lokasiController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  Future<void> _pilihFoto(SumberFoto sumber) async {
    setState(() {
      _memuat = true;
      _kesalahan = null;
      _sumberTerakhir = sumber;
    });

    try {
      final hasil = await _fotoService.pilih(sumber);
      if (!mounted) return;

      setState(() {
        _memuat = false;
        // Dibatalkan (hasil null): _lampiran tidak disentuh, jadi foto
        // sebelumnya tetap tampil.
        if (hasil != null) {
          _lampiran = hasil;
        }
      });

      if (hasil == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pemilihan foto dibatalkan.')),
        );
      }
    } on FotoException catch (e) {
      if (!mounted) return;
      setState(() {
        _memuat = false;
        _kesalahan = e;
      });
    }
  }

  void _hapusFoto() {
    setState(() {
      _lampiran = null;
      _kesalahan = null;
    });
  }

  void _kirim() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final foto = _lampiran;
    final ringkasan = '$_kategori di ${_lokasiController.text.trim()}';

    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ringkasan laporan'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(ringkasan,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(_deskripsiController.text.trim()),
              const SizedBox(height: 12),
              if (foto != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(
                    foto.bytes,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
              else
                const Text('Tanpa foto lampiran.'),
              const SizedBox(height: 12),
              const Text(
                'Pengiriman ke server belum dihubungkan pada tugas ini.',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buat Laporan')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _lokasiController,
              decoration: const InputDecoration(
                labelText: 'Lokasi',
                hintText: 'Contoh: Gedung B, R. 204',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Lokasi wajib diisi.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Kategori',
                border: OutlineInputBorder(),
              ),
              hint: const Text('Pilih kategori'),
              items: _daftarKategori
                  .map((k) => DropdownMenuItem(value: k, child: Text(k)))
                  .toList(),
              onChanged: (v) => _kategori = v,
              validator: (value) {
                if (value == null) {
                  return 'Kategori wajib dipilih.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _deskripsiController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Deskripsi',
                hintText: 'Jelaskan kerusakan singkat',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Deskripsi wajib diisi.';
                }
                if (value.trim().length < 10) {
                  return 'Deskripsi minimal 10 karakter.';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            Text(
              'Foto kerusakan (opsional)',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            _bangunBagianFoto(),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _memuat ? null : _kirim,
              child: const Text('Kirim laporan'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bangunBagianFoto() {
    final warna = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Kondisi: loading
        if (_memuat)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 12),
                  Text('Memproses foto...'),
                ],
              ),
            ),
          ),

        // Kondisi: izin ditolak, tidak valid, atau error
        if (!_memuat && _kesalahan != null) _kartuKesalahan(_kesalahan!),

        // Kondisi: berhasil. Juga menjadi state sebelumnya yang dipertahankan
        // saat pemilihan dibatalkan atau gagal.
        if (!_memuat && _lampiran != null) _kartuPreview(_lampiran!),

        // Kondisi: belum ada foto dan tidak ada masalah
        if (!_memuat && _lampiran == null && _kesalahan == null)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24),
            decoration: BoxDecoration(
              border: Border.all(color: warna.outlineVariant),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Icon(Icons.photo_camera_outlined,
                    size: 40, color: warna.outline),
                const SizedBox(height: 8),
                const Text('Belum ada foto. Foto membantu petugas menilai kerusakan.',
                    textAlign: TextAlign.center),
              ],
            ),
          ),

        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _memuat ? null : () => _pilihFoto(SumberFoto.kamera),
                icon: const Icon(Icons.photo_camera),
                label: const Text('Kamera'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _memuat ? null : () => _pilihFoto(SumberFoto.galeri),
                icon: const Icon(Icons.photo_library),
                label: const Text('Galeri'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _kartuPreview(LampiranFoto foto) {
    return Card(
      margin: const EdgeInsets.only(bottom: 4),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.memory(foto.bytes, height: 180, fit: BoxFit.cover),
          ListTile(
            dense: true,
            title: Text(foto.nama, maxLines: 1, overflow: TextOverflow.ellipsis),
            subtitle: Text(foto.ukuranTeks),
            trailing: IconButton(
              tooltip: 'Hapus foto',
              icon: const Icon(Icons.delete_outline),
              onPressed: _hapusFoto,
            ),
          ),
        ],
      ),
    );
  }

  Widget _kartuKesalahan(FotoException e) {
    final warna = Theme.of(context).colorScheme;

    String judul;
    IconData ikon;
    switch (e.jenis) {
      case JenisKesalahanFoto.izinDitolak:
        judul = 'Izin ditolak';
        ikon = Icons.no_photography_outlined;
        break;
      case JenisKesalahanFoto.tidakValid:
        judul = 'Foto tidak dapat dipakai';
        ikon = Icons.image_not_supported_outlined;
        break;
      case JenisKesalahanFoto.gagal:
        judul = 'Foto gagal diambil';
        ikon = Icons.error_outline;
        break;
    }

    return Card(
      color: warna.errorContainer,
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(ikon, color: warna.onErrorContainer),
                const SizedBox(width: 8),
                Text(
                  judul,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: warna.onErrorContainer,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(e.pesan, style: TextStyle(color: warna.onErrorContainer)),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () => _pilihFoto(_sumberTerakhir),
                icon: const Icon(Icons.refresh),
                label: const Text('Coba Lagi'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
