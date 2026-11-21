// Tugas 12 PAB: Validasi dan Keamanan Praktis (antarmuka)
// Nama: Galih Permana Sidik | NIM 230660221002 | SI-VIIA
//
// Form Buat Laporan dari Tugas 11 yang diperbarui: semua kolom divalidasi lewat
// ValidatorLaporan (enam validator), ditambah kolom Tanggal kejadian dan Email
// kontak (opsional). Permission kamera atau galeri hanya diminta saat tombolnya
// ditekan, bukan saat aplikasi dibuka.
//
// Bantuan: Claude, menyusun pemasangan validator pada form dan pola kolom
// tanggal. Aturan, pengujian, dan checklist diverifikasi oleh penulis.

import 'package:flutter/material.dart';

import 'services/foto_service.dart';
import 'validators/validator_laporan.dart';

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
  final _formKey = GlobalKey<FormState>();
  final _lokasiController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _tanggalController = TextEditingController();
  final _emailController = TextEditingController();
  final FotoService _fotoService = FotoService();

  String? _kategori;
  DateTime? _tanggal;

  // State bagian foto.
  LampiranFoto? _lampiran;
  bool _memuat = false;
  FotoException? _kesalahan;
  SumberFoto _sumberTerakhir = SumberFoto.galeri;

  @override
  void dispose() {
    _lokasiController.dispose();
    _deskripsiController.dispose();
    _tanggalController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  String _formatTanggal(DateTime d) {
    final hari = d.day.toString().padLeft(2, '0');
    final bulan = d.month.toString().padLeft(2, '0');
    return '$hari/$bulan/${d.year}';
  }

  Future<void> _pilihTanggal() async {
    final sekarang = DateTime.now();
    final hariIni = DateTime(sekarang.year, sekarang.month, sekarang.day);
    final hasil = await showDatePicker(
      context: context,
      initialDate: _tanggal ?? hariIni,
      firstDate: hariIni.subtract(
        const Duration(days: ValidatorLaporan.batasHariKebelakang),
      ),
      lastDate: hariIni,
    );
    if (!mounted || hasil == null) return;
    setState(() {
      _tanggal = hasil;
      _tanggalController.text = _formatTanggal(hasil);
    });
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
    final email = _emailController.text.trim();

    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ringkasan laporan'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$_kategori di ${_lokasiController.text.trim()}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text('Tanggal kejadian: ${_tanggalController.text}'),
              const SizedBox(height: 4),
              Text(_deskripsiController.text.trim()),
              if (email.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text('Email kontak: $email'),
              ],
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
                'Data belum dikirim ke server. Pengiriman memerlukan backend SiLapor.',
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
              validator: ValidatorLaporan.lokasi,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Kategori',
                border: OutlineInputBorder(),
              ),
              hint: const Text('Pilih kategori'),
              items: ValidatorLaporan.kategoriValid
                  .map((k) => DropdownMenuItem(value: k, child: Text(k)))
                  .toList(),
              onChanged: (v) => _kategori = v,
              validator: ValidatorLaporan.kategori,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _tanggalController,
              readOnly: true,
              onTap: _pilihTanggal,
              decoration: const InputDecoration(
                labelText: 'Tanggal kejadian',
                hintText: 'Pilih tanggal',
                suffixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(),
              ),
              validator: (_) => ValidatorLaporan.tanggalKejadian(_tanggal),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _deskripsiController,
              maxLines: 4,
              maxLength: ValidatorLaporan.maxDeskripsi,
              decoration: const InputDecoration(
                labelText: 'Deskripsi',
                hintText: 'Jelaskan kerusakan singkat',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
              validator: ValidatorLaporan.deskripsi,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email kontak (opsional)',
                hintText: 'nama@kampus.ac.id',
                border: OutlineInputBorder(),
              ),
              validator: ValidatorLaporan.email,
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
        if (!_memuat && _kesalahan != null) _kartuKesalahan(_kesalahan!),
        if (!_memuat && _lampiran != null) _kartuPreview(_lampiran!),
        if (!_memuat && _lampiran == null && _kesalahan == null)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24),
            decoration: BoxDecoration(
              border: Border.all(color: warna.outlineVariant),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Icon(Icons.photo_camera_outlined, size: 40, color: warna.outline),
                const SizedBox(height: 8),
                const Text(
                  'Belum ada foto. Foto membantu petugas menilai kerusakan.',
                  textAlign: TextAlign.center,
                ),
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
