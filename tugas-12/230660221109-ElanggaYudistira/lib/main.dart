import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'services/validation_service.dart';

void main() {
  runApp(const Tugas12App());
}

class Tugas12App extends StatelessWidget {
  const Tugas12App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MoneyTrack Validasi',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF176B57)),
        scaffoldBackgroundColor: const Color(0xFFF5F8F7),
      ),
      home: const ValidasiTransaksiPage(),
    );
  }
}

class ValidasiTransaksiPage extends StatefulWidget {
  const ValidasiTransaksiPage({super.key});

  @override
  State<ValidasiTransaksiPage> createState() => _ValidasiTransaksiPageState();
}

class _ValidasiTransaksiPageState extends State<ValidasiTransaksiPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _jumlahController = TextEditingController();
  final _picker = ImagePicker();

  XFile? _bukti;
  DateTime? _tanggal;
  bool _loading = false;
  String? _statusMessage;
  bool _statusError = false;

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _jumlahController.dispose();
    super.dispose();
  }

  String _tanggalText() {
    final value = _tanggal;
    if (value == null) return 'Pilih tanggal';
    return value.day.toString() +
        '/' +
        value.month.toString() +
        '/' +
        value.year.toString();
  }

  Future<void> _pilihBukti() async {
    setState(() {
      _loading = true;
      _statusMessage = null;
    });

    try {
      final file = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1600,
        imageQuality: 85,
      );

      if (!mounted) return;
      if (file == null) {
        setState(() {
          _loading = false;
          _statusError = false;
          _statusMessage =
              'Pemilihan dibatalkan. Bukti sebelumnya tetap dipertahankan.';
        });
        return;
      }

      final error = await InputValidators.image(file);
      if (!mounted) return;
      setState(() {
        _loading = false;
        _statusError = error != null;
        _statusMessage = error ?? 'Bukti valid: ' + file.name;
        if (error == null) _bukti = file;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _statusError = true;
        _statusMessage =
            'Fitur file tidak tersedia atau permission belum diberikan.';
      });
    }
  }

  Future<void> _pilihTanggal() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDate: _tanggal ?? DateTime.now(),
    );
    if (picked != null) setState(() => _tanggal = picked);
  }

  Future<void> _simpan() async {
    final validForm = _formKey.currentState?.validate() ?? false;
    final dateError = InputValidators.date(_tanggal);
    final fileError = await InputValidators.image(_bukti);

    if (!validForm || dateError != null || fileError != null) {
      setState(() {
        _statusError = true;
        _statusMessage = dateError ?? fileError;
      });
      return;
    }

    setState(() {
      _statusError = false;
      _statusMessage =
          'Validasi berhasil. Data siap dikirim ke service transaksi.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Validasi Transaksi'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Text(
                  'Validasi dilakukan sebelum data transaksi diproses. '
                  'Aturan yang sama harus diperiksa kembali oleh server.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _namaController,
              maxLength: 60,
              decoration: const InputDecoration(
                labelText: 'Nama transaksi',
                prefixIcon: Icon(Icons.receipt_long),
                border: OutlineInputBorder(),
              ),
              validator: (value) => InputValidators.requiredText(
                value,
                label: 'Nama transaksi',
                maxLength: 60,
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email pemilik',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
              validator: InputValidators.email,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _jumlahController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Jumlah transaksi',
                prefixText: 'Rp ',
                prefixIcon: Icon(Icons.payments_outlined),
                border: OutlineInputBorder(),
              ),
              validator: InputValidators.amount,
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: _loading ? null : _pilihTanggal,
              borderRadius: BorderRadius.circular(4),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Tanggal transaksi',
                  prefixIcon: Icon(Icons.calendar_month_outlined),
                  border: OutlineInputBorder(),
                ),
                child: Text(_tanggalText()),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _loading ? null : _pilihBukti,
              icon: _loading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.attach_file),
              label: Text(
                _bukti == null ? 'Pilih Bukti Transaksi' : _bukti!.name,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 18),
            if (_statusMessage != null)
              Card(
                color: _statusError
                    ? Theme.of(context).colorScheme.errorContainer
                    : Theme.of(context).colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Text(_statusMessage!),
                ),
              ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _loading ? null : _simpan,
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Validasi Transaksi'),
            ),
          ],
        ),
      ),
    );
  }
}
