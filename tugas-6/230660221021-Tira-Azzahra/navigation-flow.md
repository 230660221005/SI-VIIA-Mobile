# Navigation Flow — Tugas 6 (Perpustakaan Kampus)

## Daftar Route

| Route | Layar | Dibuka dari | Data dikirim | Kebutuhan (sesuaikan ID) |
|---|---|---|---|---|
| `/` | Katalog Buku (Daftar) | initialRoute | — | F-02 Melihat katalog buku |
| `/detail` | Detail Buku | Ketuk item buku di katalog | `Buku` (arguments) | F-03 Melihat detail buku |
| `/form` | Form Peminjaman | Tombol **Ajukan/Pinjam** | — | F-01 Ajukan peminjaman |

**Alasan initialRoute = `/`**: layar katalog adalah titik masuk utama yang memenuhi kebutuhan *Must have* “melihat katalog buku”, dan menjadi sumber navigasi ke detail serta form.

## Diagram Navigation Flow (Mermaid)

```mermaid
flowchart TD
  A["Katalog Buku<br/>(/ — F-02)"] -->|"Ketuk item + arguments (Buku)"| B["Detail Buku<br/>(/detail — F-03)"]
  B -->|"pop (Kembali)"| A

  A -->|"Tombol Ajukan/Pinjam"| C["Form Peminjaman<br/>(/form — F-01)"]
  C -->|"Valid → SnackBar → pop"| A

  
---

## C. Isi `form-interaksi.dart` (kode Flutter lengkap: routes + arguments + form + SnackBar)

Isi file ini: `tugas-6/230660221021-Tira-Azzahra/form-interaksi.dart`

> Kode ini 1 file dan aman untuk **DartPad template=app** (tanpa package tambahan).  
> Nanti screenshot: (1) buka detail (2) submit form valid sampai SnackBar muncul.

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const AppTugas6());
}

class AppTugas6 extends StatelessWidget {
  const AppTugas6({super.key});

  static const routeKatalog = '/';
  static const routeDetail = '/detail';
  static const routeForm = '/form';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perpustakaan Kampus — Tugas 6',
      debugShowCheckedModeBanner: false,
      initialRoute: routeKatalog,
      routes: {
        routeKatalog: (context) => const HalamanKatalog(),
        routeDetail: (context) => const HalamanDetailBuku(),
        routeForm: (context) => const HalamanFormPeminjaman(),
      },
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
    );
  }
}

class Buku {
  final String judul;
  final String penulis;
  final bool tersedia;

  const Buku({
    required this.judul,
    required this.penulis,
    required this.tersedia,
  });
}

class HalamanKatalog extends StatelessWidget {
  const HalamanKatalog({super.key});

  static const _data = <Buku>[
    Buku(judul: 'Algoritma dan Pemrograman', penulis: 'R. Siregar', tersedia: true),
    Buku(judul: 'Basis Data Lanjut', penulis: 'A. Wibowo', tersedia: false),
    Buku(judul: 'Rekayasa Perangkat Lunak', penulis: 'I. Pratama', tersedia: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Buku'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, AppTugas6.routeForm),
        label: const Text('Ajukan Pinjam'),
        icon: const Icon(Icons.assignment_outlined),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _data.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final buku = _data[index];
          return Card(
            child: ListTile(
              onTap: () {
                // Kirim data antarlayar (arguments)
                Navigator.pushNamed(
                  context,
                  AppTugas6.routeDetail,
                  arguments: buku,
                );
              },
              title: Text(buku.judul),
              subtitle: Text('Penulis: ${buku.penulis}'),
              trailing: Chip(
                label: Text(buku.tersedia ? 'Tersedia' : 'Habis'),
                backgroundColor: buku.tersedia
                    ? Colors.green.withValues(alpha: 0.15)
                    : Colors.red.withValues(alpha: 0.15),
              ),
            ),
          );
        },
      ),
    );
  }
}

class HalamanDetailBuku extends StatelessWidget {
  const HalamanDetailBuku({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final buku = args is Buku ? args : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Buku'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: buku == null
            ? const Text(
                'Data buku tidak tersedia.\n\n'
                'Buka halaman ini melalui ketukan item di katalog.',
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    buku.judul,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text('Penulis: ${buku.penulis}'),
                  const SizedBox(height: 8),
                  Text('Status: ${buku.tersedia ? "Tersedia" : "Habis"}'),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Kembali'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}

class HalamanFormPeminjaman extends StatefulWidget {
  const HalamanFormPeminjaman({super.key});

  @override
  State<HalamanFormPeminjaman> createState() => _HalamanFormPeminjamanState();
}

class _HalamanFormPeminjamanState extends State<HalamanFormPeminjaman> {
  final _formKey = GlobalKey<FormState>();

  final _nimController = TextEditingController();
  final _namaController = TextEditingController();
  final _durasiController = TextEditingController();

  @override
  void dispose() {
    _nimController.dispose();
    _namaController.dispose();
    _durasiController.dispose();
    super.dispose();
  }

  void _kirim(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final nama = _namaController.text.trim();

    // Feedback interaksi
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Pengajuan peminjaman oleh "$nama" dikirim (simulasi).')),
    );

    // Kembali ke layar sebelumnya setelah feedback tampil sesaat
    Future.delayed(const Duration(milliseconds: 800), () {
      if (context.mounted) Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Peminjaman'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nimController,
              decoration: const InputDecoration(
                labelText: 'NIM',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                final v = value?.trim() ?? '';
                if (v.isEmpty) return 'NIM wajib diisi.';
                if (v.length < 8) return 'NIM minimal 8 digit.';
                if (int.tryParse(v) == null) return 'NIM harus berupa angka.';
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _namaController,
              decoration: const InputDecoration(
                labelText: 'Nama Mahasiswa',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama wajib diisi.';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _durasiController,
              decoration: const InputDecoration(
                labelText: 'Durasi pinjam (hari)',
                hintText: 'Contoh: 7',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                final v = value?.trim() ?? '';
                if (v.isEmpty) return 'Durasi wajib diisi.';
                final n = int.tryParse(v);
                if (n == null) return 'Durasi harus berupa angka.';
                if (n < 1 || n > 14) return 'Durasi harus 1–14 hari.';
                return null;
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Batal'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () => _kirim(context),
                    child: const Text('Kirim'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}