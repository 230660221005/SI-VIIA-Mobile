// Halaman form pengajuan/pemesanan dengan validasi input dan catatan keamanan.
// Pertemuan 12: validasi client, HTTPS, token (konseptual), dan permission.

import 'package:flutter/material.dart';

import 'services/validasi_input.dart';

/// Contoh endpoint API production yang harus menggunakan HTTPS.
/// Token tidak disimpan di source code dan tidak dicetak ke log.
const String _endpointPengajuan = 'https://api.glazent.pro/pengajuan';

/// Abstraksi penyimpanan token (konseptual). Implementasi nyata dapat memakai
/// flutter_secure_storage pada perangkat yang mendukung. Token dihapus saat logout.
abstract class TokenStorage {
  Future<void> simpan(String token);
  Future<String?> baca();
  Future<void> hapus();
}

class HalamanValidasiPesanan extends StatefulWidget {
  const HalamanValidasiPesanan({super.key});

  @override
  State<HalamanValidasiPesanan> createState() => _HalamanValidasiPesananState();
}

class _HalamanValidasiPesananState extends State<HalamanValidasiPesanan> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _catatanController = TextEditingController();
  final _tanggalController = TextEditingController();

  bool _sedangKirim = false;

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _catatanController.dispose();
    _tanggalController.dispose();
    super.dispose();
  }

  Future<void> _pilihTanggal() async {
    final sekarang = DateTime.now();
    final terpilih = await showDatePicker(
      context: context,
      initialDate: sekarang,
      firstDate: sekarang,
      lastDate: DateTime(sekarang.year + 2),
      helpText: 'Pilih tanggal layanan',
    );
    if (terpilih == null) return;
    final teks =
        '${terpilih.year.toString().padLeft(4, '0')}-${terpilih.month.toString().padLeft(2, '0')}-${terpilih.day.toString().padLeft(2, '0')}';
    setState(() {
      _tanggalController.text = teks;
    });
  }

  Future<void> _kirim() async {
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid) return;

    // Sanitasi sebelum data dipakai/dibentuk ke request.
    final nama = ValidasiInput.sanitasi(_namaController.text);
    final email = ValidasiInput.sanitasi(_emailController.text);
    final catatan = ValidasiInput.sanitasi(_catatanController.text);
    final tanggal = ValidasiInput.sanitasi(_tanggalController.text);

    setState(() => _sedangKirim = true);
    try {
      // Simulasi pengiriman melalui HTTPS. Tidak ada token/password dicetak.
      await Future<void>.delayed(const Duration(milliseconds: 600));

      // Contoh payload aman (tanpa data sensitif di log/UI debug).
      final payload = <String, String>{
        'nama': nama,
        'email': email,
        'catatan': catatan,
        'tanggal': tanggal,
      };
      // Payload hanya dibentuk setelah valid; endpoint harus https://
      assert(_endpointPengajuan.startsWith('https://'));
      assert(payload.isNotEmpty);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Data valid. Pengajuan siap dikirim melalui HTTPS (simulasi).',
          ),
        ),
      );
      _formKey.currentState?.reset();
      _namaController.clear();
      _emailController.clear();
      _catatanController.clear();
      _tanggalController.clear();
    } catch (_) {
      if (!mounted) return;
      // Pesan error aman: tidak menampilkan detail internal.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pengajuan gagal diproses. Silakan coba lagi.'),
        ),
      );
    } finally {
      if (mounted) setState(() => _sedangKirim = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Form Pengajuan Aman')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  'Validasi Input & Keamanan Praktis',
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Contoh form dengan validator client, sanitasi, dan prinsip '
                  'HTTPS/token/permission. Server tetap melakukan pemeriksaan ulang.',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
                _InfoKeamanan(colorScheme: colorScheme),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _namaController,
                  decoration: const InputDecoration(
                    labelText: 'Nama pemohon',
                    hintText: 'Masukkan nama lengkap',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: ValidasiInput.namaPemohon,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'nama@domain.com',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: ValidasiInput.email,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _tanggalController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Tanggal layanan',
                    hintText: 'Pilih tanggal',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.event_outlined),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: _pilihTanggal,
                  validator: ValidasiInput.tanggalLayanan,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _catatanController,
                  decoration: const InputDecoration(
                    labelText: 'Catatan / alamat layanan',
                    hintText: 'Jelaskan kebutuhan (maks. 200 karakter)',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  maxLines: 4,
                  maxLength: ValidasiInput.panjangMaksCatatan,
                  validator: ValidasiInput.catatan,
                ),
                const SizedBox(height: 8),
                FilledButton.icon(
                  onPressed: _sedangKirim ? null : _kirim,
                  icon: _sedangKirim
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.verified_user_outlined),
                  label: Text(_sedangKirim ? 'Memproses...' : 'Kirim Pengajuan'),
                ),
                const SizedBox(height: 12),
                Text(
                  'Catatan: lampiran foto (kamera/galeri) hanya diminta saat '
                  'fitur dibutuhkan dan ditangani di halaman bukti pekerjaan. '
                  'Token akses, jika digunakan, harus disimpan di penyimpanan '
                  'aman dan dihapus saat logout — bukan di shared_preferences.',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoKeamanan extends StatelessWidget {
  const _InfoKeamanan({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.primary.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Prinsip yang diterapkan:',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 6),
          Text('• Validasi client + sanitasi (trim) sebelum request.'),
          Text('• Endpoint data sensitif menggunakan HTTPS.'),
          Text('• Token tidak ditulis di source code/log; simpan di secure storage.'),
          Text('• Permission diminta sesuai fitur (least privilege).'),
          Text('• Pesan error tidak membocorkan data sensitif/detail internal.'),
        ],
      ),
    );
  }
}
