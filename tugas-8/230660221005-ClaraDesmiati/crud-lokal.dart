import 'package:flutter/material.dart';

void main() {
  runApp(const SiAngkutCrudApp());
}

// Model data jadwal pengangkutan sampah.
class JadwalPengangkutan {
  final int id;
  final String hari;
  final String wilayah;
  final String status;
  final String keterangan;

  const JadwalPengangkutan({
    required this.id,
    required this.hari,
    required this.wilayah,
    required this.status,
    required this.keterangan,
  });

  @override
  String toString() {
    return 'JadwalPengangkutan('
        'id: $id, hari: $hari, wilayah: $wilayah, '
        'status: $status, keterangan: $keterangan)';
  }
}

class SiAngkutCrudApp extends StatelessWidget {
  const SiAngkutCrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SiAngkut CRUD',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF14877C),
        ),
        useMaterial3: true,
      ),
      home: const HalamanCrudJadwal(),
    );
  }
}

// HALAMAN DAFTAR: data dikelola di State.
class HalamanCrudJadwal extends StatefulWidget {
  const HalamanCrudJadwal({super.key});

  @override
  State<HalamanCrudJadwal> createState() => _HalamanCrudJadwalState();
}

class _HalamanCrudJadwalState extends State<HalamanCrudJadwal> {
  final List<JadwalPengangkutan> _jadwal = [
    const JadwalPengangkutan(
      id: 1,
      hari: 'Senin',
      wilayah: 'Wilayah Tanggulun',
      status: 'Selesai',
      keterangan: 'Pengangkutan telah selesai.',
    ),
    const JadwalPengangkutan(
      id: 2,
      hari: 'Selasa',
      wilayah: 'Wilayah Cimalaka',
      status: 'Terjadwal',
      keterangan: 'Menunggu jadwal pengangkutan.',
    ),
    const JadwalPengangkutan(
      id: 3,
      hari: 'Rabu',
      wilayah: 'Wilayah Tanggulun',
      status: 'Terjadwal',
      keterangan: 'Menunggu jadwal pengangkutan.',
    ),
  ];

  int _idBerikutnya = 4;

  Color _warnaStatus(String status, ColorScheme tema) {
    if (status == 'Selesai') {
      return tema.primary;
    } else if (status == 'Dalam proses') {
      return tema.tertiary;
    }
    return tema.secondary;
  }

  Future<void> _tambahJadwal() async {
    final hasil = await showDialog<JadwalPengangkutan>(
      context: context,
      builder: (context) => FormJadwalDialog(
        id: _idBerikutnya,
        judul: 'Tambah Jadwal',
      ),
    );

    if (hasil == null) return;

    setState(() {
      _jadwal.add(hasil);
      _idBerikutnya++;
    });

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Jadwal berhasil ditambahkan.')),
    );
  }

  Future<void> _editJadwal(JadwalPengangkutan data) async {
    final hasil = await showDialog<JadwalPengangkutan>(
      context: context,
      builder: (context) => FormJadwalDialog(
        id: data.id,
        judul: 'Edit Jadwal',
        dataAwal: data,
      ),
    );

    if (hasil == null) return;

    // Mencari objek dengan ID yang sama, bukan berdasarkan posisi daftar.
    final index = _jadwal.indexWhere(
      (item) => item.id == hasil.id,
    );

    if (index == -1) return;

    setState(() {
      _jadwal[index] = hasil;
    });

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Jadwal berhasil diperbarui.')),
    );
  }

  Future<void> _hapusJadwal(int id) async {
    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(Icons.delete_outline),
        title: const Text('Hapus Jadwal?'),
        content: const Text(
          'Jadwal yang dipilih akan dihapus dari daftar. '
          'Apakah kamu yakin ingin melanjutkan?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (konfirmasi != true) return;

    setState(() {
      _jadwal.removeWhere((item) => item.id == id);
    });

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Jadwal berhasil dihapus.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final warna = tema.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.recycling_rounded),
            SizedBox(width: 10),
            Text(
              'SiAngkut',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _tambahJadwal,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Jadwal'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 850),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: warna.primaryContainer,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kelola Jadwal Pengangkutan',
                        style: tema.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: warna.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Tambah, ubah, dan hapus data jadwal SiAngkut.',
                        style: TextStyle(
                          color: warna.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Daftar Jadwal',
                        style: tema.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Chip(label: Text('${_jadwal.length} jadwal')),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: _jadwal.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.event_busy_outlined,
                                size: 60,
                                color: warna.primary,
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'Belum ada jadwal pengangkutan.',
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                'Tekan Tambah Jadwal untuk memulai.',
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: _jadwal.length,
                          itemBuilder: (context, index) {
                            final item = _jadwal[index];
                            final warnaStatus =
                                _warnaStatus(item.status, warna);

                            return Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: warna.primaryContainer,
                                    child: Icon(
                                      Icons.local_shipping_outlined,
                                      color: warna.onPrimaryContainer,
                                    ),
                                  ),
                                  title: Text(
                                    item.hari,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(item.wilayah),
                                        const SizedBox(height: 5),
                                        Text(
                                          item.status,
                                          style: TextStyle(
                                            color: warnaStatus,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          item.keterangan,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          'ID: ${item.id}',
                                          style: tema.textTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                  isThreeLine: true,
                                  trailing: Wrap(
                                    spacing: 0,
                                    children: [
                                      IconButton(
                                        tooltip: 'Edit jadwal',
                                        onPressed: () => _editJadwal(item),
                                        icon: const Icon(Icons.edit_outlined),
                                      ),
                                      IconButton(
                                        tooltip: 'Hapus jadwal',
                                        onPressed: () => _hapusJadwal(item.id),
                                        icon: Icon(
                                          Icons.delete_outline,
                                          color: warna.error,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Data hanya disimpan sementara selama aplikasi berjalan.',
                  style: tema.textTheme.bodySmall,
                ),
                const SizedBox(height: 65),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Form yang digunakan untuk menambah dan mengedit jadwal.
class FormJadwalDialog extends StatefulWidget {
  final int id;
  final String judul;
  final JadwalPengangkutan? dataAwal;

  const FormJadwalDialog({
    super.key,
    required this.id,
    required this.judul,
    this.dataAwal,
  });

  @override
  State<FormJadwalDialog> createState() => _FormJadwalDialogState();
}

class _FormJadwalDialogState extends State<FormJadwalDialog> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _hariController;
  late final TextEditingController _wilayahController;
  late final TextEditingController _keteranganController;

  late String _status;

  @override
  void initState() {
    super.initState();

    final data = widget.dataAwal;

    _hariController = TextEditingController(text: data?.hari ?? '');
    _wilayahController = TextEditingController(text: data?.wilayah ?? '');
    _keteranganController = TextEditingController(text: data?.keterangan ?? '');
    _status = data?.status ?? 'Terjadwal';
  }

  @override
  void dispose() {
    _hariController.dispose();
    _wilayahController.dispose();
    _keteranganController.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;

    final hasil = JadwalPengangkutan(
      id: widget.id,
      hari: _hariController.text.trim(),
      wilayah: _wilayahController.text.trim(),
      status: _status,
      keterangan: _keteranganController.text.trim(),
    );

    Navigator.pop(context, hasil);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.judul),
      content: SizedBox(
        width: 450,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _hariController,
                  decoration: const InputDecoration(
                    labelText: 'Hari Pengangkutan',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Hari wajib diisi.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _wilayahController,
                  decoration: const InputDecoration(
                    labelText: 'Wilayah',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Wilayah wajib diisi.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                DropdownButtonFormField<String>(
                  value: _status,
                  decoration: const InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Terjadwal',
                      child: Text('Terjadwal'),
                    ),
                    DropdownMenuItem(
                      value: 'Dalam proses',
                      child: Text('Dalam proses'),
                    ),
                    DropdownMenuItem(
                      value: 'Selesai',
                      child: Text('Selesai'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _status = value);
                    }
                  },
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _keteranganController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Keterangan',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Keterangan wajib diisi.';
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
        FilledButton(
          onPressed: _simpan,
          child: const Text('Simpan'),
        ),
      ],
    );
  }
}
