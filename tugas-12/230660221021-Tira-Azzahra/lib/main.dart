import 'package:flutter/material.dart';
import 'services/keamanan_perpustakaan_service.dart';
import 'validators/pengajuan_validator.dart';

void main() {
  runApp(const PerpustakaanKeamananApp());
}

class PerpustakaanKeamananApp extends StatelessWidget {
  const PerpustakaanKeamananApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SI Perpustakaan Kampus — Validasi & Keamanan',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1D4ED8)),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      ),
      home: const HalamanValidasiPengajuan(),
    );
  }
}

class HalamanValidasiPengajuan extends StatefulWidget {
  const HalamanValidasiPengajuan({super.key});

  @override
  State<HalamanValidasiPengajuan> createState() =>
      _HalamanValidasiPengajuanState();
}

class _HalamanValidasiPengajuanState extends State<HalamanValidasiPengajuan> {
  final _formKey = GlobalKey<FormState>();
  final _keamananService = KeamananPerpustakaanService(MemoryTokenStorage());

  final _namaController = TextEditingController();
  final _nimController = TextEditingController();
  final _emailController = TextEditingController();
  final _judulBukuController = TextEditingController();
  final _durasiController = TextEditingController(text: '7');

  double _ukuranLampiranMb = 1.8;
  bool _sesiAktif = false;
  bool _sedangMengirim = false;
  String? _pesanHasil;
  bool _isError = false;

  @override
  void dispose() {
    _namaController.dispose();
    _nimController.dispose();
    _emailController.dispose();
    _judulBukuController.dispose();
    _durasiController.dispose();
    super.dispose();
  }

  Future<void> _toggleSesi() async {
    if (_sesiAktif) {
      await _keamananService.logout();
      if (!mounted) return;
      setState(() {
        _sesiAktif = false;
        _pesanHasil = 'Token sesi berhasil dihapus (Logout).';
        _isError = false;
      });
    } else {
      final nimInput = _nimController.text.trim().isEmpty
          ? '230660221021'
          : _nimController.text.trim();
      await _keamananService.mulaiSesiSimulasi(nimInput);
      if (!mounted) return;
      setState(() {
        _sesiAktif = true;
        _pesanHasil = 'Sesi token aktif tersimpan di memory storage.';
        _isError = false;
      });
    }
  }

  Future<void> _submitForm() async {
    setState(() {
      _pesanHasil = null;
      _isError = false;
    });

    // 1. Jalankan seluruh validator TextFormField
    final formValid = _formKey.currentState?.validate() ?? false;

    // 2. Jalankan validator ukuran lampiran file
    final errorLampiran =
        PengajuanValidator.validasiUkuranLampiran(_ukuranLampiranMb);

    if (!formValid || errorLampiran != null) {
      setState(() {
        _isError = true;
        _pesanHasil = errorLampiran ??
            'Periksa kembali kolom yang bertanda merah sebelum mengirim.';
      });
      return;
    }

    setState(() => _sedangMengirim = true);

    try {
      final hasil = await _keamananService.kirimPengajuanAman(
        nama: _namaController.text,
        nim: _nimController.text,
        email: _emailController.text,
        judulBuku: _judulBukuController.text,
        durasiHari: int.parse(_durasiController.text.trim()),
        ukuranLampiranMb: _ukuranLampiranMb,
      );

      if (!mounted) return;
      setState(() {
        _sedangMengirim = false;
        _isError = false;
        _pesanHasil =
            'Pengajuan buku "${hasil['judulBuku']}" oleh ${hasil['nama']} '
            '(${hasil['nim']}) selama${hasil['durasiHari']} hari tervalidasi '
            'dan siap dikirim melalui HTTPS.';
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _sedangMengirim = false;
        _isError = true;
        _pesanHasil = e.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Validasi Pengajuan Peminjaman'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Kartu Status Sesi & Keamanan Token
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Icon(
                        _sesiAktif ? Icons.verified_user : Icons.lock_outline,
                        color: _sesiAktif ? Colors.green : Colors.orange,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _sesiAktif
                              ? 'Status Sesi: Terautentikasi (HTTPS Ready)'
                              : 'Status Sesi: Belum Login (Token Kosong)',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      FilledButton.tonal(
                        onPressed: _toggleSesi,
                        child: Text(_sesiAktif ? 'Logout' : 'Aktifkan Sesi'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Kartu Input Form Bervalidator
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
                        'Data Peminjam & Buku',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextFormField(
                        controller: _namaController,
                        decoration: const InputDecoration(
                          labelText: 'Nama Lengkap Mahasiswa',
                          border: OutlineInputBorder(),
                        ),
                        validator: PengajuanValidator.validasiNama,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _nimController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'NIM (12 Digit)',
                          hintText: '230660221021',
                          border: OutlineInputBorder(),
                        ),
                        validator: PengajuanValidator.validasiNim,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email Mahasiswa',
                          hintText: '230660221021@student.unsap.ac.id',
                          border: OutlineInputBorder(),
                        ),
                        validator: PengajuanValidator.validasiEmail,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _judulBukuController,
                        decoration: const InputDecoration(
                          labelText: 'Judul Buku yang Dipinjam',
                          border: OutlineInputBorder(),
                        ),
                        validator: PengajuanValidator.validasiJudulBuku,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _durasiController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Durasi Peminjaman (1–14 Hari)',
                          border: OutlineInputBorder(),
                        ),
                        validator: PengajuanValidator.validasiDurasiHari,
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Simulasi Ukuran Lampiran Foto Kondisi Buku: '
                        '${_ukuranLampiranMb.toStringAsFixed(1)} MB (Maks. 5.0 MB)',
                        style: const TextStyle(fontSize: 13),
                      ),
                      Slider(
                        value: _ukuranLampiranMb,
                        min: 0.5,
                        max: 8.0,
                        divisions: 15,
                        label: '${_ukuranLampiranMb.toStringAsFixed(1)} MB',
                        onChanged: (val) {
                          setState(() => _ukuranLampiranMb = val);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              if (_pesanHasil != null) ...[
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: _isError
                        ? Colors.red.withValues(alpha: 0.08)
                        : Colors.green.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _isError ? Colors.redAccent : Colors.green,
                    ),
                  ),
                  child: Text(
                    _pesanHasil!,
                    style: TextStyle(
                      color: _isError ? Colors.red[800] : Colors.green[900],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              FilledButton.icon(
                onPressed: _sedangMengirim ? null : _submitForm,
                icon: _sedangMengirim
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.verified),
                label: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    _sedangMengirim
                        ? 'Memvalidasi Data...'
                        : 'Validasi & Kirim Pengajuan',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}