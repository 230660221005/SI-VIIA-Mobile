
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/foto_service.dart';
import '../validators/validasi_foto.dart';

class HalamanFoto extends StatefulWidget {
  final FotoService? fotoService;

  const HalamanFoto({
    super.key,
    this.fotoService,
  });

  @override
  State<HalamanFoto> createState() => _HalamanFotoState();
}

class _HalamanFotoState extends State<HalamanFoto> {
  late final FotoService _fotoService;

  XFile? _foto;
  Uint8List? _dataFoto;

  bool _loading = false;
  String _pesan = 'Belum ada foto yang dipilih.';

  @override
  void initState() {
    super.initState();
    _fotoService = widget.fotoService ?? FotoService();
  }

  // Menghapus foto lama ketika foto baru tidak valid.
  void _hapusFotoLama(String pesan) {
    setState(() {
      _foto = null;
      _dataFoto = null;
      _pesan = pesan;
    });
  }

  Future<void> _ambilFoto(bool dariKamera) async {
    setState(() {
      _loading = true;
      _pesan = 'Sedang memproses foto...';
    });

    try {
      XFile? hasil;

      if (dariKamera) {
        hasil = await _fotoService.ambilFotoDariKamera();
      } else {
        hasil = await _fotoService.pilihFotoDariGaleri();
      }

      if (!mounted) return;

      // Validasi 1: Foto wajib dipilih.
      final pesanWajib = ValidasiFoto.cekFotoWajib(hasil);

      if (pesanWajib != null) {
        setState(() {
          _pesan = pesanWajib;
        });
        return;
      }

      // Validasi 2: Format nama file.
      final pesanFormat = ValidasiFoto.cekFormatFoto(hasil!);

      if (pesanFormat != null) {
        _hapusFotoLama(pesanFormat);
        return;
      }

      // Validasi 3: Ukuran maksimal 2 MB.
      final pesanUkuran =
          await ValidasiFoto.cekUkuranFoto(hasil);

      if (!mounted) return;

      if (pesanUkuran != null) {
        _hapusFotoLama(pesanUkuran);
        return;
      }

      // Membaca isi file.
      final Uint8List bytes = await hasil.readAsBytes();

      if (!mounted) return;

      // Validasi 4: Data foto tidak boleh kosong.
      final pesanData = ValidasiFoto.cekDataFoto(bytes);

      if (pesanData != null) {
        _hapusFotoLama(pesanData);
        return;
      }

      // Validasi 5: Tanda pengenal isi file JPG atau PNG.
      final pesanIsi = ValidasiFoto.cekIsiFileFoto(bytes);

      if (pesanIsi != null) {
        _hapusFotoLama(pesanIsi);
        return;
      }

      // Foto berhasil melewati seluruh validasi.
      setState(() {
        _foto = hasil;
        _dataFoto = bytes;
        _pesan = 'Foto berhasil dipilih dan lolos 5 validasi.';
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _pesan = 'Terjadi kesalahan saat mengambil foto.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bukti Foto'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.photo_camera,
              size: 65,
              color: Colors.green,
            ),
            const SizedBox(height: 12),
            const Text(
              'Dokumentasi Foto',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ambil foto menggunakan kamera atau pilih gambar dari galeri sebagai bukti dokumentasi.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
              ),
              child: _dataFoto != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.memory(
                        _dataFoto!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    )
                  : const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_outlined,
                          size: 70,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 8),
                        Text('Pratinjau foto akan tampil di sini'),
                      ],
                    ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _loading ? null : () => _ambilFoto(true),
              icon: const Icon(Icons.camera_alt),
              label: const Text('Ambil Foto dengan Kamera'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(14),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _loading ? null : () => _ambilFoto(false),
              icon: const Icon(Icons.photo_library),
              label: const Text('Pilih dari Galeri'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(14),
              ),
            ),
            const SizedBox(height: 20),
            if (_loading)
              const Center(
                child: CircularProgressIndicator(),
              ),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                _pesan,
                textAlign: TextAlign.center,
              ),
            ),
            if (_foto != null) ...[
              const SizedBox(height: 12),
              Text(
                'Nama file: ${_foto!.name}',
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 12),
            const Text(
              'Ketentuan: JPG/JPEG/PNG, maksimal 2 MB.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
