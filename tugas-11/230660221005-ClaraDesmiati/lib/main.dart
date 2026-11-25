import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'services/foto_service.dart';
const warnaUtama = Color(0xFF14877C);
const warnaLatar = Color(0xFFF3F8F6);
const warnaTeks = Color(0xFF203B37);

void main() {
  runApp(const SiAngkutApp());
}

class SiAngkutApp extends StatelessWidget {
  const SiAngkutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SiAngkut',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: warnaLatar,
        colorScheme: ColorScheme.fromSeed(seedColor: warnaUtama),
        fontFamily: 'Arial',
      ),
      home: const HalamanUtama(),
    );
  }
}

class HalamanUtama extends StatelessWidget {
  const HalamanUtama({super.key});

  static const List<Map<String, String>> jadwal = [
    {
      'hari': 'Senin',
      'tanggal': 'Jadwal pengangkutan',
      'wilayah': 'Wilayah Tanggulun',
      'status': 'Selesai',
    },
    {
      'hari': 'Selasa',
      'tanggal': 'Jadwal pengangkutan',
      'wilayah': 'Wilayah Cimalaka',
      'status': 'Terjadwal',
    },
    {
      'hari': 'Rabu',
      'tanggal': 'Jadwal pengangkutan',
      'wilayah': 'Wilayah Tanggulun',
      'status': 'Terjadwal',
    },
    {
      'hari': 'Kamis',
      'tanggal': 'Jadwal pengangkutan',
      'wilayah': 'Wilayah Cimalaka',
      'status': 'Terjadwal',
    },
  ];

  void bukaForm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const FormLaporan()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: warnaLatar,
        titleSpacing: 24,
        title: const Row(
          children: [
            Icon(Icons.recycling_rounded, color: warnaUtama, size: 30),
            SizedBox(width: 10),
            Text(
              'SiAngkut',
              style: TextStyle(
                color: warnaTeks,
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 24),
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFE0F2EC),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Row(
              children: [
                Icon(Icons.eco_outlined, color: warnaUtama, size: 18),
                SizedBox(width: 6),
                Text(
                  'Lingkungan Bersih',
                  style: TextStyle(
                    color: warnaUtama,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1050),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF147D70),
                        Color(0xFF35A991),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Stack(
                    children: [
                      const Positioned(
                        right: 0,
                        top: 0,
                        child: Icon(
                          Icons.eco_rounded,
                          size: 110,
                          color: Color(0x44FFFFFF),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0x33FFFFFF),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'LAYANAN WARGA',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),
                          const Text(
                            'Halo, Warga! ðŸ‘‹',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Sampah terangkut, lingkungan\nlebih sehat dan nyaman.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 18),
                          const Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Tanggulun, Cimalaka',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 22),
                          FilledButton.icon(
                            onPressed: () => bukaForm(context),
                            icon: const Icon(Icons.add_circle_outline),
                            label: const Text('Buat Laporan Pengangkutan'),
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: warnaUtama,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 26),
                const SizedBox(height: 26),
                const Text(
                  'Ringkasan Layanan',
                  style: TextStyle(
                    color: warnaTeks,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 14),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final jumlahKolom = constraints.maxWidth < 480 ? 1 : 2;

                    return GridView.count(
                      crossAxisCount: jumlahKolom,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: jumlahKolom == 1 ? 4.0 : 2.5,
                      children: [
                        _kartuRingkasan(
                          Icons.payments_outlined,
                          'Iuran Bulanan',
                          'Rp15.000',
                          'Pembayaran per bulan',
                          const Color(0xFFE2F3ED),
                        ),
                        _kartuRingkasan(
                          Icons.calendar_month_outlined,
                          'Jadwal Layanan',
                          'Terjadwal',
                          'Lihat daftar pengangkutan',
                          const Color(0xFFFFF0D9),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Jadwal Pengangkutan',
                      style: TextStyle(
                        color: warnaTeks,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0F2EC),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${jadwal.length} jadwal',
                        style: const TextStyle(
                          color: warnaUtama,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  'Pilih jadwal untuk melihat detail layanan.',
                  style: TextStyle(color: Colors.black54, fontSize: 13),
                ),
                const SizedBox(height: 14),
                ListView.builder(
                  itemCount: jadwal.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = jadwal[index];
                    final selesai = item['status'] == 'Selesai';

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: const Color(0xFFE8EFEC),
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(18),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(18),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => HalamanDetailJadwal(
                                  data: item,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Container(
                                  width: 52,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE5F4EF),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: const Icon(
                                    Icons.local_shipping_outlined,
                                    color: warnaUtama,
                                    size: 27,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['hari']!,
                                        style: const TextStyle(
                                          color: warnaTeks,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        item['wilayah']!,
                                        style: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 13,
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        item['tanggal']!,
                                        style: const TextStyle(
                                          color: Colors.black38,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 7,
                                      ),
                                      decoration: BoxDecoration(
                                        color: selesai
                                            ? const Color(0xFFE2F5E8)
                                            : const Color(0xFFFFF0D9),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        item['status']!,
                                        style: TextStyle(
                                          color: selesai
                                              ? const Color(0xFF24834A)
                                              : const Color(0xFFB77717),
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    const Icon(
                                      Icons.chevron_right,
                                      color: Colors.black45,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE4F2EE),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline_rounded,
                        color: warnaUtama,
                        size: 28,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Yuk, pilah sampah dari rumah dan jaga '
                          'lingkungan tetap bersih!',
                          style: TextStyle(
                            color: warnaTeks,
                            height: 1.5,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _kartuRingkasan(
    IconData ikon,
    String judul,
    String nilai,
    String keterangan,
    Color warnaIkon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8EFEC)),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: warnaIkon,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(ikon, color: warnaUtama, size: 25),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  judul,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  nilai,
                  style: const TextStyle(
                    color: warnaTeks,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  keterangan,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black45,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// HALAMAN DETAIL JADWAL

class HalamanDetailJadwal extends StatelessWidget {
  final Map<String, String> data;

  const HalamanDetailJadwal({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Jadwal'),
        backgroundColor: warnaLatar,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 550),
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.local_shipping_outlined,
                      color: warnaUtama,
                      size: 55,
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Informasi Pengangkutan',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: warnaTeks,
                      ),
                    ),
                    const SizedBox(height: 22),
                    _detail('Hari', data['hari']!),
                    _detail('Wilayah', data['wilayah']!),
                    _detail('Keterangan', data['tanggal']!),
                    _detail('Status', data['status']!),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const FormLaporan(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit_note),
                        label: const Text('Laporkan Pengangkutan'),
                        style: FilledButton.styleFrom(
                          backgroundColor: warnaUtama,
                          padding: const EdgeInsets.all(16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _detail(String judul, String isi) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            judul,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            isi,
            style: const TextStyle(
              color: warnaTeks,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}

// HALAMAN FORM LAPORAN

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

  final FotoService _fotoService = FotoService();
  XFile? _fotoLaporan;
  Uint8List? _fotoBytes;
  bool _memilihFoto = false;
  String? _pesanFoto;

  @override
  void dispose() {
    _namaController.dispose();
    _alamatController.dispose();
    _keteranganController.dispose();
    super.dispose();
  }

  Future<void> pilihFoto() async {
    setState(() {
      _memilihFoto = true;
      _pesanFoto = null;
    });

    try {
      final foto = await _fotoService.pilihFoto();

      if (!mounted) return;

      if (foto == null) {
        setState(() {
          _pesanFoto = _fotoLaporan == null
              ? 'Pemilihan foto dibatalkan.'
              : 'Dibatalkan. Foto sebelumnya tetap digunakan.';
        });
        return;
      }

      final bytes = await foto.readAsBytes();
      if (!mounted) return;

      setState(() {
        _fotoLaporan = foto;
        _fotoBytes = bytes;
        _pesanFoto = 'Foto berhasil dipilih: ${foto.name}';
      });
    } on FotoPermissionException catch (e) {
      if (!mounted) return;
      setState(() => _pesanFoto = e.pesan);
    } on FotoPickerException catch (e) {
      if (!mounted) return;
      setState(() => _pesanFoto = e.pesan);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _pesanFoto = 'Gagal memilih foto. Silakan coba kembali.';
      });
    } finally {
      if (mounted) {
        setState(() => _memilihFoto = false);
      }
    }
  }

  void kirimLaporan() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Laporan berhasil dikirim!'),
          backgroundColor: warnaUtama,
        ),
      );

      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Laporan'),
        backgroundColor: warnaLatar,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 550),
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.assignment_outlined,
                        color: warnaUtama,
                        size: 48,
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'Buat Laporan Pengangkutan',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: warnaTeks,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Silakan isi informasi berikut untuk menyampaikan laporan pengangkutan sampah.',
                        style: TextStyle(color: Colors.black54, height: 1.5),
                      ),
                      const SizedBox(height: 24),
                      const Text('Nama Pelapor',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _namaController,
                        decoration: InputDecoration(
                          hintText: 'Masukkan nama lengkap',
                          prefixIcon: const Icon(Icons.person_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) =>
                            value == null || value.trim().isEmpty
                                ? 'Nama pelapor harus diisi'
                                : null,
                      ),
                      const SizedBox(height: 18),
                      const Text('Alamat',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _alamatController,
                        decoration: InputDecoration(
                          hintText: 'Masukkan alamat lengkap',
                          prefixIcon: const Icon(Icons.location_on_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) =>
                            value == null || value.trim().isEmpty
                                ? 'Alamat harus diisi'
                                : null,
                      ),
                      const SizedBox(height: 18),
                      const Text('Keterangan Laporan',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _keteranganController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Jelaskan laporan pengangkutan sampah',
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) =>
                            value == null || value.trim().isEmpty
                                ? 'Keterangan laporan harus diisi'
                                : null,
                      ),
                      const SizedBox(height: 18),
                      const Text('Foto Bukti Laporan',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: _memilihFoto ? null : pilihFoto,
                          icon: _memilihFoto
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2),
                                )
                              : const Icon(Icons.photo_library_outlined),
                          label: Text(_memilihFoto
                              ? 'Memilih foto...'
                              : 'Pilih Foto dari Galeri'),
                        ),
                      ),
                      if (_fotoBytes != null) ...[
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.memory(
                            _fotoBytes!,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _fotoLaporan!.name,
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ],
                      if (_pesanFoto != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          _pesanFoto!,
                          style: const TextStyle(
                              color: warnaUtama, fontSize: 13),
                        ),
                      ],
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: kirimLaporan,
                          icon: const Icon(Icons.send),
                          label: const Text('Kirim Laporan'),
                          style: FilledButton.styleFrom(
                            backgroundColor: warnaUtama,
                            padding: const EdgeInsets.all(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

