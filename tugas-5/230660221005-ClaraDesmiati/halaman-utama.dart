import 'package:flutter/material.dart';

void main() {
  runApp(const SiAngkutPrototype());
}

class SiAngkutPrototype extends StatelessWidget {
  const SiAngkutPrototype({super.key});

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
      ),
      home: const HalamanUtama(),
    );
  }
}

class HalamanUtama extends StatelessWidget {
  const HalamanUtama({super.key});

  // Data contoh untuk prototipe. Sesuaikan dengan jadwal layanan yang sebenarnya.
  // Untuk menguji keadaan kosong, ganti isi list ini menjadi const [].
  static const List<Map<String, String>> jadwal = [
    {
      'judul': 'Jadwal pengangkutan mingguan',
      'wilayah': 'Wilayah Tanggulun',
      'status': 'Terjadwal',
    },
    {
      'judul': 'Pengangkutan sebelumnya',
      'wilayah': 'Wilayah Tanggulun',
      'status': 'Selesai',
    },
    {
      'judul': 'Jadwal berikutnya',
      'wilayah': 'Wilayah Cimalaka',
      'status': 'Menunggu',
    },
    {
      'judul': 'Jadwal pengangkutan',
      'wilayah': 'Wilayah Cimalaka',
      'status': 'Terjadwal',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.recycling_rounded),
            SizedBox(width: 10),
            Text('SiAngkut'),
          ],
        ),
        backgroundColor: colors.surface,
        foregroundColor: colors.primary,
      ),
      body: jadwal.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.event_busy_outlined,
                      size: 64,
                      color: colors.outline,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Belum ada jadwal pengangkutan',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Jadwal layanan akan ditampilkan di sini saat tersedia.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
              itemCount: jadwal.length + 2,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Informasi layanan warga',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colors.onSurface,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Informasi iuran dan jadwal angkutan sampah.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Card(
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: CircleAvatar(
                            backgroundColor: colors.primaryContainer,
                            foregroundColor: colors.onPrimaryContainer,
                            child: const Icon(Icons.payments_outlined),
                          ),
                          title: const Text('Iuran bulanan'),
                          subtitle: const Text('Pembayaran layanan angkutan sampah'),
                          trailing: Text(
                            'Rp15.000',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colors.primary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Jadwal pengangkutan',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colors.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Periksa status setiap jadwal layanan.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  );
                }

                if (index == 1) {
                  return const SizedBox.shrink();
                }

                final item = jadwal[index - 2];
                final selesai = item['status'] == 'Selesai';
                final menunggu = item['status'] == 'Menunggu';
                final statusColor = selesai
                    ? colors.primary
                    : menunggu
                        ? colors.tertiary
                        : colors.secondary;

                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: colors.surfaceContainerHighest,
                      foregroundColor: colors.primary,
                      child: const Icon(Icons.local_shipping_outlined),
                    ),
                    title: Text(
                      item['judul']!,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(item['wilayah']!),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        item['status']!,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Tombol laporan masih berupa prototipe UI. Form laporan dirancang sebagai layar pendukung.',
              ),
            ),
          );
        },
        icon: const Icon(Icons.campaign_outlined),
        label: const Text('Laporkan Belum Diangkut'),
      ),
    );
  }
}
