import 'package:flutter/material.dart';

class Produk {
  final String nama;
  final String harga;
  final String status;

  const Produk({
    required this.nama,
    required this.harga,
    required this.status,
  });
}

void main() {
  runApp(const AplikasiWarung());
}

class AplikasiWarung extends StatelessWidget {
  const AplikasiWarung({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PAB - Penjualan Warung',
      initialRoute: '/',
      routes: {
        '/': (context) => const DaftarProdukPage(),
        '/detail': (context) => const DetailProdukPage(),
        '/transaksi': (context) => const TransaksiPage(),
      },
    );
  }
}

class DaftarProdukPage extends StatelessWidget {
  const DaftarProdukPage({super.key});

  static const List<Produk> produk = [
    Produk(
      nama: 'Nasi Goreng',
      harga: 'Rp15.000',
      status: 'Tersedia',
    ),
    Produk(
      nama: 'Mie Instan',
      harga: 'Rp8.000',
      status: 'Tersedia',
    ),
    Produk(
      nama: 'Kopi',
      harga: 'Rp5.000',
      status: 'Tersedia',
    ),
    Produk(
      nama: 'Teh Manis',
      harga: 'Rp4.000',
      status: 'Tersedia',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Produk'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: produk.length,
        itemBuilder: (context, index) {
          final item = produk[index];

          return Card(
            child: ListTile(
              title: Text(item.nama),
              subtitle: Text('${item.harga} • ${item.status}'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/detail',
                  arguments: item,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DetailProdukPage extends StatelessWidget {
  const DetailProdukPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final produk = args is Produk ? args : null;

    if (produk == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Produk'),
        ),
        body: Center(
          child: FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Kembali'),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              produk.nama,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Text('Harga: ${produk.harga}'),
            const SizedBox(height: 8),
            Text('Status: ${produk.status}'),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/transaksi',
                  arguments: produk,
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Buat Transaksi'),
            ),
          ],
        ),
      ),
    );
  }
}

class TransaksiPage extends StatefulWidget {
  const TransaksiPage({super.key});

  @override
  State<TransaksiPage> createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  final _formKey = GlobalKey<FormState>();

  final _namaPembeliController = TextEditingController();
  final _jumlahController = TextEditingController();

  @override
  void dispose() {
    _namaPembeliController.dispose();
    _jumlahController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final produk = args is Produk ? args : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Transaksi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                produk?.nama ?? 'Produk tidak tersedia',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(produk?.harga ?? '-'),
              const SizedBox(height: 24),
              TextFormField(
                controller: _namaPembeliController,
                decoration: const InputDecoration(
                  labelText: 'Nama Pembeli',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama pembeli wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _jumlahController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Jumlah',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Jumlah wajib diisi';
                  }

                  final jumlah = int.tryParse(value);

                  if (jumlah == null || jumlah <= 0) {
                    return 'Jumlah harus berupa angka lebih dari 0';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Transaksi berhasil disimpan'),
                      ),
                    );

                    Navigator.popUntil(
                      context,
                      (route) => route.settings.name == '/',
                    );
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text('Simpan Transaksi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}