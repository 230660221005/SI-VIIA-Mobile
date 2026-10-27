
import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiPerpustakaan());
}

// ==================================================
// APLIKASI UTAMA DAN ROUTES
// ==================================================

class AplikasiPerpustakaan extends StatelessWidget {
  const AplikasiPerpustakaan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perpustakaan Kampus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HalamanKatalog(),
        '/detail': (context) => const HalamanDetailBuku(),
        '/pinjam': (context) => const HalamanFormPeminjaman(),
      },
    );
  }
}

// ==================================================
// MODEL DAN DATA BUKU
// ==================================================

class DataBuku {
  final String judul;
  final String penulis;
  final String status;

  const DataBuku({
    required this.judul,
    required this.penulis,
    required this.status,
  });
}

const List<DataBuku> daftarBuku = [
  DataBuku(
    judul: 'Pemrograman Flutter',
    penulis: 'Andi Pratama',
    status: 'Tersedia',
  ),
  DataBuku(
    judul: 'Analisis dan Desain Sistem Informasi',
    penulis: 'Rosa A.S.',
    status: 'Tersedia',
  ),
  DataBuku(
    judul: 'Basis Data',
    penulis: 'Fathansyah',
    status: 'Dipinjam',
  ),
];

// ==================================================
// HALAMAN KATALOG
// ==================================================

class HalamanKatalog extends StatelessWidget {
  const HalamanKatalog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Buku'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: daftarBuku.length,
        itemBuilder: (context, index) {
          final buku = daftarBuku[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const Icon(
                Icons.menu_book,
                color: Colors.indigo,
                size: 36,
              ),
              title: Text(
                buku.judul,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Penulis: ${buku.penulis}\n'
                'Status: ${buku.status}',
              ),
              isThreeLine: true,
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/detail',
                  arguments: buku,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// ==================================================
// HALAMAN DETAIL BUKU
// ==================================================

class HalamanDetailBuku extends StatelessWidget {
  const HalamanDetailBuku({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments;

    // Periksa tipe data dan tangani argumen kosong.
    final DataBuku? buku =
        arguments is DataBuku ? arguments : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Buku'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: buku == null
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Data buku tidak ditemukan. '
                  'Silakan kembali ke katalog.',
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Icon(
                      Icons.menu_book,
                      size: 100,
                      color: Colors.indigo,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    buku.judul,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('Penulis: ${buku.penulis}'),
                  const SizedBox(height: 8),
                  Text('Status: ${buku.status}'),
                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: buku.status == 'Tersedia'
                          ? () async {
                              // Kirim judul buku ke form.
                              final hasil =
                                  await Navigator.pushNamed<bool>(
                                context,
                                '/pinjam',
                                arguments: buku.judul,
                              );

                              // Tampilkan notifikasi setelah berhasil.
                              if (hasil == true &&
                                  context.mounted) {
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Pengajuan peminjaman berhasil!',
                                      ),
                                    ),
                                  );
                              }
                            }
                          : null,
                      child: const Text('Pinjam Buku'),
                    ),
                  ),

                  if (buku.status != 'Tersedia')
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        'Buku sedang dipinjam dan belum tersedia.',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}

// ==================================================
// HALAMAN FORM PEMINJAMAN
// ==================================================

class HalamanFormPeminjaman extends StatefulWidget {
  const HalamanFormPeminjaman({super.key});

  @override
  State<HalamanFormPeminjaman> createState() =>
      _HalamanFormPeminjamanState();
}

class _HalamanFormPeminjamanState
    extends State<HalamanFormPeminjaman> {
  final _formKey = GlobalKey<FormState>();

  final _namaController = TextEditingController();
  final _nimController = TextEditingController();
  final _judulController = TextEditingController();

  bool _judulSudahDiisi = false;

  // Ambil judul buku yang dikirim dari halaman detail.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_judulSudahDiisi) {
      final arguments =
          ModalRoute.of(context)?.settings.arguments;

      if (arguments is String) {
        _judulController.text = arguments;
      }

      _judulSudahDiisi = true;
    }
  }

  // Bersihkan semua controller.
  @override
  void dispose() {
    _namaController.dispose();
    _nimController.dispose();
    _judulController.dispose();
    super.dispose();
  }

  // Proses pengiriman formulir.
  void _kirimForm() {
    if (_formKey.currentState!.validate()) {
      final nama = _namaController.text.trim();
      final nim = _nimController.text.trim();
      final judul = _judulController.text.trim();

      // Data untuk pengujian di terminal.
      debugPrint('Nama: $nama');
      debugPrint('NIM: $nim');
      debugPrint('Judul Buku: $judul');

      // Kembalikan hasil berhasil ke halaman detail.
      Navigator.pop(context, true);
    } else {
      // Notifikasi jika formulir belum valid.
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text(
              'Periksa kembali isian yang masih belum benar.',
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Peminjaman'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pengajuan Peminjaman Buku',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Lengkapi data berikut untuk mengajukan '
                'peminjaman buku.',
              ),
              const SizedBox(height: 24),

              // INPUT NAMA
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  hintText: 'Masukkan nama lengkap',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Nama lengkap wajib diisi.';
                  }

                  if (value.trim().length < 3) {
                    return 'Nama minimal 3 karakter.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),

              // INPUT NIM
              TextFormField(
                controller: _nimController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'NIM',
                  hintText: 'Masukkan NIM',
                  prefixIcon: Icon(Icons.badge),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'NIM wajib diisi.';
                  }

                  if (!RegExp(r'^[0-9]+$')
                      .hasMatch(value.trim())) {
                    return 'NIM hanya boleh berisi angka.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),

              // INPUT JUDUL BUKU
              TextFormField(
                controller: _judulController,
                decoration: const InputDecoration(
                  labelText: 'Judul Buku',
                  hintText: 'Masukkan judul buku',
                  prefixIcon: Icon(Icons.menu_book),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Judul buku wajib diisi.';
                  }

                  if (value.trim().length < 3) {
                    return 'Judul buku minimal 3 karakter.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 24),

              // TOMBOL KIRIM
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _kirimForm,
                  icon: const Icon(Icons.send),
                  label: const Text('Kirim Pengajuan'),
                ),
              ),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'Pastikan data yang dimasukkan sudah benar.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
