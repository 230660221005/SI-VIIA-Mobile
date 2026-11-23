import 'package:flutter/material.dart';
import 'services/keamanan_perpustakaan_service.dart';
import 'validators/pengajuan_validator.dart';

void main() {
  runApp(const PerpustakaanTestingApp());
}

class PerpustakaanTestingApp extends StatelessWidget {
  const PerpustakaanTestingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SI Perpustakaan Kampus — Testing & Bug Fixes',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1D4ED8)),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      ),
      home: const HalamanPengajuanPerpustakaan(),
    );
  }
}

class HalamanPengajuanPerpustakaan extends StatefulWidget {
  const HalamanPengajuanPerpustakaan({super.key});

  @override
  State<HalamanPengajuanPerpustakaan> createState() =>
      _HalamanPengajuanPerpustakaanState();
}

class _HalamanPengajuanPerpustakaanState
    extends State<HalamanPengajuanPerpustakaan> {
  final _formKey = GlobalKey<FormState>();
  final _keamananService = KeamananPerpustakaanService(MemoryTokenStorage());

  final _namaController = TextEditingController();
  final _nimController = TextEditingController();
  final _emailController = TextEditingController();
  final _judulBukuController = TextEditingController();
  final _durasiController = TextEditingController(text: '7');

  final List _daftarPengajuan = [];
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
    if (_sedangMengirim) return;

    setState(() {
      _pesanHasil = null;
      _isError = false;
    });

    final formValid = _formKey.currentState?.validate() ?? false;
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
        _daftarPengajuan.insert(0, hasil);
        _judulBukuController.clear();
        _pesanHasil =
            'Pengajuan buku "${hasil['judulBuku']}" oleh ${hasil['nama']} '
            'berhasil disimpan.';
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

  void _hapusPengajuanById(String id) {
    setState(() {
      _daftarPengajuan.removeWhere((item) => item['id'] == id);
      _pesanHasil = 'Item pengajuan berhasil dihapus dari daftar.';
      _isError = false;
    });
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                              ? 'Status Sesi: Terautentikasi'
                              : 'Status Sesi: Belum Login',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      FilledButton.tonal(
                        key: const Key('btn_toggle_sesi'),
                        onPressed: _toggleSesi,
                        child: Text(_sesiAktif ? 'Logout' : 'Aktifkan Sesi'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
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
                        'Form Pengajuan Peminjaman',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextFormField(
                        key: const Key('field_nama'),
                        controller: _namaController,
                        decoration: const InputDecoration(
                          labelText: 'Nama Lengkap Mahasiswa',
                          border: OutlineInputBorder(),
                        ),
                        validator: PengajuanValidator.validasiNama,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        key: const Key('field_nim'),
                        controller: _nimController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'NIM (12 Digit)',
                          border: OutlineInputBorder(),
                        ),
                        validator: PengajuanValidator.validasiNim,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        key: const Key('field_email'),
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email Mahasiswa',
                          border: OutlineInputBorder(),
                        ),
                        validator: PengajuanValidator.validasiEmail,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        key: const Key('field_judul_buku'),
                        controller: _judulBukuController,
                        decoration: const InputDecoration(
                          labelText: 'Judul Buku yang Dipinjam',
                          border: OutlineInputBorder(),
                        ),
                        validator: PengajuanValidator.validasiJudulBuku,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        key: const Key('field_durasi'),
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
                        'Simulasi Ukuran Lampiran Foto: '
                        '${_ukuranLampiranMb.toStringAsFixed(1)} MB',
                        style: const TextStyle(fontSize: 13),
                      ),
                      Slider(
                        key: const Key('slider_lampiran'),
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
                  key: const Key('box_pesan_status'),
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
                key: const Key('btn_kirim_pengajuan'),
                onPressed: _sedangMengirim ? null : _submitForm,
                icon: _sedangMengirim
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.send),
                label: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    _sedangMengirim ? 'Menyimpan...' : 'Kirim Pengajuan',
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Daftar Pengajuan (${_daftarPengajuan.length})',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              if (_daftarPengajuan.isEmpty)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Belum ada pengajuan peminjaman buku.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              else
                ..._daftarPengajuan.map(
                  (item) => Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      title: Text(item['judulBuku'] as String),
                      subtitle: Text(
                        '${item['nama']} (${item['nim']}) •${item['durasiHari']} hari',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        tooltip: 'Hapus Pengajuan',
                        onPressed: () =>
                            _hapusPengajuanById(item['id'] as String),
                      ),
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