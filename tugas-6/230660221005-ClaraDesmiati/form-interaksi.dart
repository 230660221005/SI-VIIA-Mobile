import 'package:flutter/material.dart';

void main() {
  runApp(const SiAngkutApp());
}

const String routeUtama = '/';
const String routeDetail = '/detail-jadwal';
const String routeForm = '/form-laporan';

class JadwalPengangkutan {
  final String hari;
  final String wilayah;
  final String status;
  final String keterangan;

  const JadwalPengangkutan({
    required this.hari,
    required this.wilayah,
    required this.status,
    required this.keterangan,
  });
}

const List<JadwalPengangkutan> daftarJadwal = [
  JadwalPengangkutan(
    hari: 'Senin',
    wilayah: 'Wilayah Tanggulun',
    status: 'Selesai',
    keterangan: 'Pengangkutan sampah telah selesai.',
  ),
  JadwalPengangkutan(
    hari: 'Selasa',
    wilayah: 'Wilayah Cimalaka',
    status: 'Terjadwal',
    keterangan: 'Pengangkutan sampah menunggu jadwal.',
  ),
  JadwalPengangkutan(
    hari: 'Rabu',
    wilayah: 'Wilayah Tanggulun',
    status: 'Terjadwal',
    keterangan: 'Pengangkutan sampah menunggu jadwal.',
  ),
  JadwalPengangkutan(
    hari: 'Kamis',
    wilayah: 'Wilayah Cimalaka',
    status: 'Terjadwal',
    keterangan: 'Pengangkutan sampah menunggu jadwal.',
  ),
];

class SiAngkutApp extends StatelessWidget {
  const SiAngkutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SiAngkut',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF14877C),
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F8F7),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF5F8F7),
          foregroundColor: Color(0xFF203B37),
          centerTitle: false,
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFFE4ECE8)),
          ),
        ),
      ),
      initialRoute: routeUtama,
      routes: {
        routeUtama: (context) => const HalamanUtama(),
        routeDetail: (context) => const HalamanDetailJadwal(),
        routeForm: (context) => const FormLaporan(),
      },
    );
  }
}

// HALAMAN UTAMA
class HalamanUtama extends StatelessWidget {
  const HalamanUtama({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.recycling, color: Color(0xFF14877C)),
            SizedBox(width: 8),
            Text(
              'SiAngkut',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: tema.colorScheme.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Layanan Angkutan Sampah',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Iuran bulanan Rp15.000',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 5),
                Text(
                  'Pilih jadwal untuk melihat detail layanan.',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Jadwal Pengangkutan',
            style: tema.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          if (daftarJadwal.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(28),
                child: Column(
                  children: [
                    Icon(Icons.event_busy, size: 48),
                    SizedBox(height: 10),
                    Text('Belum ada jadwal pengangkutan.'),
                  ],
                ),
              ),
            )
          else
            ...daftarJadwal.map((jadwal) {
              final sudahSelesai = jadwal.status == 'Selesai';
              final warnaStatus = sudahSelesai
                  ? tema.colorScheme.primary
                  : tema.colorScheme.tertiary;

              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: CircleAvatar(
                    backgroundColor: tema.colorScheme.primaryContainer,
                    child: Icon(
                      Icons.local_shipping_outlined,
                      color: tema.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  title: Text(
                    jadwal.hari,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(jadwal.wilayah),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.circle, size: 11, color: warnaStatus),
                      const SizedBox(height: 4),
                      Text(
                        jadwal.status,
                        style: TextStyle(
                          color: warnaStatus,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      routeDetail,
                      arguments: jadwal,
                    );
                  },
                ),
              );
            }),
          const SizedBox(height: 10),
          FilledButton.icon(
            onPressed: () {
              // Jadwal kedua menjadi contoh jadwal untuk laporan.
              Navigator.pushNamed(
                context,
                routeForm,
                arguments: daftarJadwal.length > 1 ? daftarJadwal[1] : null,
              );
            },
            icon: const Icon(Icons.edit_note),
            label: const Text('Buat Laporan Pengangkutan'),
          ),
        ],
      ),
    );
  }
}

// HALAMAN DETAIL JADWAL
class HalamanDetailJadwal extends StatelessWidget {
  const HalamanDetailJadwal({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final jadwal = args is JadwalPengangkutan ? args : null;
    final tema = Theme.of(context);

    if (jadwal == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detail Jadwal')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.info_outline, size: 48),
                const SizedBox(height: 12),
                const Text('Data jadwal tidak tersedia.'),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Kembali'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final sudahSelesai = jadwal.status == 'Selesai';
    final warnaStatus =
        sudahSelesai ? tema.colorScheme.primary : tema.colorScheme.tertiary;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Jadwal')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Icon(
              Icons.local_shipping_outlined,
              size: 70,
              color: tema.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Detail Pengangkutan',
            textAlign: TextAlign.center,
            style: tema.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Hari Pengangkutan'),
                  const SizedBox(height: 5),
                  Text(
                    jadwal.hari,
                    style: tema.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(height: 28),
                  const Text('Wilayah'),
                  const SizedBox(height: 5),
                  Text(jadwal.wilayah),
                  const Divider(height: 28),
                  const Text('Status Layanan'),
                  const SizedBox(height: 5),
                  Text(
                    jadwal.status,
                    style: TextStyle(
                      color: warnaStatus,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(height: 28),
                  Text(jadwal.keterangan),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () {
              Navigator.pushNamed(
                context,
                routeForm,
                arguments: jadwal,
              );
            },
            icon: const Icon(Icons.edit_note),
            label: const Text('Laporkan Pengangkutan'),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Kembali ke Daftar'),
          ),
        ],
      ),
    );
  }
}

// FORM LAPORAN
class FormLaporan extends StatefulWidget {
  const FormLaporan({super.key});

  @override
  State<FormLaporan> createState() => _FormLaporanState();
}

class _FormLaporanState extends State<FormLaporan> {
  final _formKey = GlobalKey<FormState>();

  final _namaController = TextEditingController();
  final _alamatController = TextEditingController();
  final _keteranganController = TextEditingController();

  bool _sudahMengirim = false;

  @override
  void dispose() {
    _namaController.dispose();
    _alamatController.dispose();
    _keteranganController.dispose();
    super.dispose();
  }

  Future<void> _kirimLaporan() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _sudahMengirim = true);

    final nama = _namaController.text.trim();

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 4),
          content: Text(
            'Laporan dari $nama berhasil dikirim (simulasi).',
          ),
        ),
      );

    // Beri waktu agar SnackBar terlihat sebelum kembali ke detail.
    await Future.delayed(const Duration(seconds: 4));

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final jadwal = args is JadwalPengangkutan ? args : null;
    final tema = Theme.of(context);

    if (jadwal == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Form Laporan')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.info_outline, size: 48),
                const SizedBox(height: 12),
                const Text('Data jadwal tidak tersedia.'),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Kembali'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Laporan'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Laporkan Jadwal Pengangkutan',
              style: tema.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Lengkapi formulir jika pengangkutan belum terlaksana.',
            ),
            const SizedBox(height: 18),
            Card(
              child: ListTile(
                leading: const Icon(Icons.calendar_month),
                title: Text(jadwal.hari),
                subtitle: Text(jadwal.wilayah),
                trailing: Text(
                  jadwal.status,
                  style: TextStyle(
                    color: jadwal.status == 'Selesai'
                        ? tema.colorScheme.primary
                        : tema.colorScheme.tertiary,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _namaController,
              decoration: const InputDecoration(
                labelText: 'Nama Pelapor',
                hintText: 'Masukkan nama lengkap',
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama pelapor wajib diisi.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _alamatController,
              decoration: const InputDecoration(
                labelText: 'Alamat',
                hintText: 'Masukkan alamat penjemputan',
                prefixIcon: Icon(Icons.location_on_outlined),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Alamat wajib diisi.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _keteranganController,
              minLines: 3,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Keterangan Laporan',
                hintText: 'Jelaskan masalah pengangkutan sampah',
                prefixIcon: Icon(Icons.notes),
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Keterangan laporan wajib diisi.';
                }
                return null;
              },
            ),
            const SizedBox(height: 22),
            FilledButton.icon(
              onPressed: _sudahMengirim ? null : _kirimLaporan,
              icon: const Icon(Icons.send),
              label: Text(
                _sudahMengirim ? 'Laporan Terkirim' : 'Kirim Laporan',
              ),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Kembali'),
            ),
            const SizedBox(height: 12),
            Text(
              'Catatan: pengiriman ini masih simulasi. '
              'Laporan belum disimpan secara permanen.',
              style: tema.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
