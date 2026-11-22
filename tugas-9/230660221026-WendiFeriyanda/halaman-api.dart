import 'package:flutter/material.dart';

import 'service-api.dart';

/// Halaman SI RAKUS untuk latihan konsumsi REST API.
///
/// GET  : mengambil daftar buku dari API simulasi.
/// POST : mengirim data buku contoh ke API simulasi.
///
/// Catatan: halaman ini tidak terhubung ke Libsys dan tidak mengubah
/// katalog resmi perpustakaan.
class HalamanApi extends StatefulWidget {
  const HalamanApi({super.key});

  @override
  State<HalamanApi> createState() => _HalamanApiState();
}

class _HalamanApiState extends State<HalamanApi> {
  final BukuApiService _service = BukuApiService();

  List<DataBuku> _daftarBuku = [];
  bool _sedangMemuat = false;
  bool _sedangMengirim = false;
  String? _pesanError;

  @override
  void initState() {
    super.initState();
    _muatKatalog();
  }

  /// Mengambil data buku dari server menggunakan GET.
  Future<void> _muatKatalog() async {
    setState(() {
      _sedangMemuat = true;
      _pesanError = null;
    });

    try {
      final hasil = await _service.ambilKatalog();
      if (!mounted) return;

      setState(() {
        _daftarBuku = hasil;
        _sedangMemuat = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _pesanError = error.toString().replaceFirst('Exception: ', '');
        _sedangMemuat = false;
      });
    }
  }

  /// Membuka form untuk menyiapkan data yang akan dikirim menggunakan POST.
  Future<void> _bukaFormTambah() async {
    final bukuBaru = await showDialog<DataBuku>(
      context: context,
      builder: (context) => const FormBukuApiDialog(),
    );

    if (!mounted || bukuBaru == null) return;
    await _kirimBuku(bukuBaru);
  }

  /// Mengirim buku ke server menggunakan POST.
  Future<void> _kirimBuku(DataBuku buku) async {
    setState(() {
      _sedangMengirim = true;
    });

    try {
      final bukuDariServer = await _service.kirimBuku(buku);
      if (!mounted) return;

      setState(() {
        // Response POST berisi ID yang dibuat oleh server.
        _daftarBuku = [bukuDariServer, ..._daftarBuku];
        _sedangMengirim = false;
      });

      _tampilkanPesan(
        'Data berhasil dikirim. ID dari server: ${bukuDariServer.id}',
      );
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _sedangMengirim = false;
      });

      final detailError = error.toString().replaceFirst('Exception: ', '');
      _tampilkanPesan('Pengiriman gagal: $detailError');
    }
  }

  void _tampilkanPesan(String pesan) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(pesan)));
  }

  Widget _kontenHalaman() {
    if (_sedangMemuat) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 12),
            Text('Sedang mengambil katalog dari server...'),
          ],
        ),
      );
    }

    if (_pesanError != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cloud_off, size: 56),
              const SizedBox(height: 12),
              Text(
                'Katalog gagal dimuat',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                _pesanError!,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _muatKatalog,
                icon: const Icon(Icons.refresh),
                label: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      );
    }

    if (_daftarBuku.isEmpty) {
      return RefreshIndicator(
        onRefresh: _muatKatalog,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: const [
            SizedBox(height: 90),
            Icon(Icons.menu_book_outlined, size: 64),
            SizedBox(height: 12),
            Center(
              child: Text(
                'Belum ada data buku simulasi.',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 6),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28),
              child: Text(
                'Gunakan tombol "Kirim Buku (POST)" untuk menambahkan '
                'data latihan ke API, lalu tarik layar ke bawah untuk memuat ulang.',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _muatKatalog,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 100),
        itemCount: _daftarBuku.length,
        itemBuilder: (context, index) {
          final buku = _daftarBuku[index];
          final tersedia = buku.stok > 0;

          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: CircleAvatar(
                child: Icon(
                  tersedia ? Icons.menu_book : Icons.book_outlined,
                ),
              ),
              title: Text(
                buku.judul,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Penulis: ${buku.penulis}'),
                    Text('Penerbit: ${buku.penerbit}'),
                    Text('Tahun: ${buku.tahunTerbit}'),
                    Text('Kategori: ${buku.kategori}'),
                    Text('Stok: ${buku.stok}'),
                    const SizedBox(height: 6),
                    Chip(
                      label: Text(buku.status),
                      visualDensity: VisualDensity.compact,
                    ),
                    Text(
                      'ID server: ${buku.id}',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
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
        title: const Text('SI RAKUS — REST API'),
        actions: [
          IconButton(
            tooltip: 'Muat ulang katalog (GET)',
            onPressed: _sedangMemuat ? null : _muatKatalog,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(12, 12, 12, 4),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Mode latihan REST API. Data di halaman ini berasal dari API '
              'simulasi, bukan katalog resmi Libsys.',
            ),
          ),
          Expanded(child: _kontenHalaman()),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _sedangMengirim ? null : _bukaFormTambah,
        icon: _sedangMengirim
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.send),
        label: Text(
          _sedangMengirim ? 'Mengirim...' : 'Kirim Buku (POST)',
        ),
      ),
    );
  }
}

/// Form sederhana untuk menyiapkan payload POST.
/// ID tidak diminta karena ID dibuat oleh server API.
class FormBukuApiDialog extends StatefulWidget {
  const FormBukuApiDialog({super.key});

  @override
  State<FormBukuApiDialog> createState() => _FormBukuApiDialogState();
}

class _FormBukuApiDialogState extends State<FormBukuApiDialog> {
  final _formKey = GlobalKey<FormState>();

  final _judulController = TextEditingController();
  final _penulisController = TextEditingController();
  final _penerbitController = TextEditingController();
  final _tahunController = TextEditingController(text: '2024');
  final _kategoriController = TextEditingController(text: 'Informatika');
  final _ringkasanController = TextEditingController();
  final _stokController = TextEditingController(text: '1');

  @override
  void dispose() {
    _judulController.dispose();
    _penulisController.dispose();
    _penerbitController.dispose();
    _tahunController.dispose();
    _kategoriController.dispose();
    _ringkasanController.dispose();
    _stokController.dispose();
    super.dispose();
  }

  String? _wajibDiisi(String? nilai, String namaField) {
    if (nilai == null || nilai.trim().isEmpty) {
      return '$namaField wajib diisi.';
    }
    return null;
  }

  void _kirimForm() {
    if (!_formKey.currentState!.validate()) return;

    final buku = DataBuku(
      // ID sementara tidak dikirim; server akan memberikan ID sesungguhnya.
      id: '',
      judul: _judulController.text.trim(),
      penulis: _penulisController.text.trim(),
      penerbit: _penerbitController.text.trim(),
      tahunTerbit: int.parse(_tahunController.text.trim()),
      kategori: _kategoriController.text.trim(),
      ringkasan: _ringkasanController.text.trim(),
      stok: int.parse(_stokController.text.trim()),
    );

    Navigator.pop(context, buku);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Simulasi Kirim Data Buku'),
      content: SizedBox(
        width: 440,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _field(_judulController, 'Judul buku'),
                _field(_penulisController, 'Penulis'),
                _field(_penerbitController, 'Penerbit'),
                _field(
                  _tahunController,
                  'Tahun terbit',
                  keyboardType: TextInputType.number,
                  validator: (nilai) {
                    if (nilai == null || nilai.trim().isEmpty) {
                      return 'Tahun terbit wajib diisi.';
                    }
                    final angka = int.tryParse(nilai.trim());
                    if (angka == null || angka < 1000 || angka > 2100) {
                      return 'Masukkan tahun antara 1000–2100.';
                    }
                    return null;
                  },
                ),
                _field(_kategoriController, 'Kategori'),
                _field(
                  _ringkasanController,
                  'Ringkasan',
                  maxLines: 3,
                ),
                _field(
                  _stokController,
                  'Jumlah stok',
                  keyboardType: TextInputType.number,
                  validator: (nilai) {
                    if (nilai == null || nilai.trim().isEmpty) {
                      return 'Jumlah stok wajib diisi.';
                    }
                    final angka = int.tryParse(nilai.trim());
                    if (angka == null || angka < 0) {
                      return 'Stok harus bilangan bulat minimal 0.';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        FilledButton.icon(
          onPressed: _kirimForm,
          icon: const Icon(Icons.send),
          label: const Text('Kirim'),
        ),
      ],
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: validator ?? (nilai) => _wajibDiisi(nilai, label),
      ),
    );
  }
}
