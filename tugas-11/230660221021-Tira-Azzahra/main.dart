import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'services/lampiran_foto_service.dart';

void main() {
  runApp(const PerpustakaanFiturPerangkatApp());
}

class PerpustakaanFiturPerangkatApp extends StatelessWidget {
  const PerpustakaanFiturPerangkatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SI Perpustakaan Kampus — Lampiran Pengajuan',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1D4ED8)),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      ),
      home: const HalamanFormPengajuanBuku(),
    );
  }
}

class HalamanFormPengajuanBuku extends StatefulWidget {
  const HalamanFormPengajuanBuku({super.key});

  @override
  State<HalamanFormPengajuanBuku> createState() =>
      _HalamanFormPengajuanBukuState();
}

class _HalamanFormPengajuanBukuState extends State<HalamanFormPengajuanBuku> {
  final LampiranFotoService _fotoService = LampiranFotoService();
  final TextEditingController _judulBukuController = TextEditingController(
    text: 'Rekayasa Perangkat Lunak Edisi 4',
  );

  bool _sedangMemprosesFoto = false;
  HasilLampiranFoto? _fotoLampiran;
  String? _pesanError;
  bool _isPermissionDitolak = false;
  String? _infoStatusAksi;
  ImageSource _sumberTerakhir = ImageSource.gallery;

  @override
  void dispose() {
    _judulBukuController.dispose();
    super.dispose();
  }

  Future<void> _prosesPilihFoto(ImageSource sumber) async {
    setState(() {
      _sedangMemprosesFoto = true;
      _pesanError = null;
      _isPermissionDitolak = false;
      _infoStatusAksi = null;
      _sumberTerakhir = sumber;
    });

    try {
      final hasil = await _fotoService.pilihFotoLampiran(sumber);
      if (!mounted) return;

      if (hasil == null) {
        // Pengguna membatalkan aksi: pertahankan state _fotoLampiran sebelumnya
        setState(() {
          _sedangMemprosesFoto = false;
          _infoStatusAksi =
              'Pemilihan foto dibatalkan. Lampiran sebelumnya tetap dipertahankan.';
        });
        return;
      }

      setState(() {
        _fotoLampiran = hasil;
        _sedangMemprosesFoto = false;
        _infoStatusAksi = 'Lampiran foto berhasil ditambahkan.';
      });
    } on LampiranFotoException catch (e) {
      if (!mounted) return;
      setState(() {
        _sedangMemprosesFoto = false;
        _pesanError = e.pesan;
        _isPermissionDitolak = e.isPermissionDitolak;
      });
    }
  }

  void _kirimPengajuan() {
    if (_judulBukuController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Judul buku wajib diisi terlebih dahulu.')),
      );
      return;
    }
    if (_fotoLampiran == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap lampirkan foto kondisi buku atau KTM.'),
        ),
      );
      return;
    }

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pengajuan Terkirim'),
        content: Text(
          'Pengajuan peminjaman "${_judulBukuController.text.trim()}" '
          'dengan lampiran "${_fotoLampiran!.namaFile}" '
          '(${_fotoLampiran!.ukuranKb.toStringAsFixed(1)} KB) berhasil dicatat.',
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Selesai'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengajuan Peminjaman Buku'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Informasi Buku yang Dipinjam',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _judulBukuController,
                      decoration: const InputDecoration(
                        labelText: 'Judul Buku',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.menu_book),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Lampiran Foto Kondisi Buku / KTM',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Digunakan sebagai bukti fisik kondisi awal buku sebelum dipinjam (maks. 5 MB).',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _sedangMemprosesFoto
                                ? null
                                : () => _prosesPilihFoto(ImageSource.camera),
                            icon: const Icon(Icons.camera_alt_outlined),
                            label: const Text('Ambil Kamera'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _sedangMemprosesFoto
                                ? null
                                : () => _prosesPilihFoto(ImageSource.gallery),
                            icon: const Icon(Icons.photo_library_outlined),
                            label: const Text('Pilih Galeri'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _bangunAreaStatusLampiran(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: _sedangMemprosesFoto ? null : _kirimPengajuan,
              icon: const Icon(Icons.send),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('Kirim Pengajuan Peminjaman'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bangunAreaStatusLampiran() {
    // 1. State Loading
    if (_sedangMemprosesFoto) {
      return Container(
        height: 180,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blue.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text('Memproses pengambilan foto dari perangkat...'),
          ],
        ),
      );
    }

    // 2. State Permission Ditolak atau Error Perangkat
    if (_pesanError != null) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.redAccent.withValues(alpha: 0.4)),
        ),
        child: Column(
          children: [
            Icon(
              _isPermissionDitolak ? Icons.lock_outline : Icons.error_outline,
              color: Colors.redAccent,
              size: 40,
            ),
            const SizedBox(height: 8),
            Text(
              _isPermissionDitolak ? 'Akses Izin Ditolak' : 'Gagal Memuat Foto',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _pesanError!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 12),
            FilledButton.tonalIcon(
              onPressed: () => _prosesPilihFoto(_sumberTerakhir),
              icon: const Icon(Icons.refresh),
              label: const Text('Coba Lagi'),
            ),
          ],
        ),
      );
    }

    // 3. State Berhasil (Preview Gambar)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_infoStatusAksi != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              _infoStatusAksi!,
              style: TextStyle(
                fontSize: 12,
                color: _fotoLampiran != null
                    ? const Color(0xFF047857)
                    : Colors.amber[900],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        if (_fotoLampiran != null) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.memory(
              _fotoLampiran!.bytes,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.check_circle, color: Color(0xFF10B981), size: 18),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  '${_fotoLampiran!.namaFile} (${_fotoLampiran!.ukuranKb.toStringAsFixed(1)} KB)',
                  style: const TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _fotoLampiran = null;
                    _infoStatusAksi = 'Lampiran foto dihapus.';
                  });
                },
                child: const Text('Hapus'),
              ),
            ],
          ),
        ] else
          Container(
            height: 140,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_a_photo_outlined,
                    size: 36, color: Colors.grey[500]),
                const SizedBox(height: 8),
                Text(
                  'Belum ada foto lampiran yang dipilih',
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
      ],
    );
  }
}