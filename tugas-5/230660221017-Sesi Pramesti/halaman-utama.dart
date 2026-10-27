import 'package:flutter/material.dart';

void main() {
  runApp(const SiFaskamApp());
}

class SiFaskamApp extends StatelessWidget {
  const SiFaskamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SI-FASKAM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const HalamanUtama(),
    );
  }
}

class Pengaduan {
  final String kategori;
  final String deskripsi;
  final String status;

  const Pengaduan({
    required this.kategori,
    required this.deskripsi,
    required this.status,
  });
}

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  final TextEditingController pencarianController =
      TextEditingController();

  int halamanTerpilih = 0;
  String kataKunci = '';

  final List<Pengaduan> daftarPengaduan = const [
    Pengaduan(
      kategori: 'Proyektor',
      deskripsi: 'Proyektor di ruang 3.1 tidak menyala.',
      status: 'Menunggu',
    ),
    Pengaduan(
      kategori: 'AC',
      deskripsi: 'AC di ruang 2.4 tidak dingin.',
      status: 'Diproses',
    ),
    Pengaduan(
      kategori: 'Lampu',
      deskripsi: 'Lampu di koridor gedung A mati.',
      status: 'Selesai',
    ),
  ];

  @override
  void dispose() {
    pencarianController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;

    final hasilPencarian = daftarPengaduan.where((item) {
      return item.kategori.toLowerCase().contains(
                kataKunci.toLowerCase(),
              ) ||
          item.deskripsi.toLowerCase().contains(
                kataKunci.toLowerCase(),
              ) ||
          item.status.toLowerCase().contains(
                kataKunci.toLowerCase(),
              );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SI-FASKAM',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: warna.surface,
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profil mahasiswa'),
                ),
              );
            },
            icon: const Icon(Icons.person),
            tooltip: 'Profil',
          ),
        ],
      ),

      body: Column(
        children: [
          // Kolom pencarian
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: pencarianController,
              onChanged: (value) {
                setState(() {
                  kataKunci = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Cari pengaduan...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
              ),
            ),
          ),

          // Daftar pengaduan atau keadaan kosong
          Expanded(
            child: hasilPencarian.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 64,
                          color: warna.onSurfaceVariant,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          kataKunci.isEmpty
                              ? 'Belum ada pengaduan'
                              : 'Pengaduan tidak ditemukan',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium,
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Pengaduan kamu akan tampil di sini.',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      16, 8, 16, 100,
                    ),
                    itemCount: hasilPencarian.length,
                    itemBuilder: (context, index) {
                      final item = hasilPencarian[index];

                      // Warna status dari tema dengan ternary
                      final warnaStatus =
                          item.status == 'Selesai'
                              ? warna.tertiary
                              : item.status == 'Diproses'
                                  ? warna.primary
                                  : warna.secondary;

                      final warnaLatarStatus =
                          item.status == 'Selesai'
                              ? warna.tertiaryContainer
                              : item.status == 'Diproses'
                                  ? warna.primaryContainer
                                  : warna.secondaryContainer;

                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: warna.outlineVariant,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: CircleAvatar(
                            backgroundColor: warna.surfaceContainerHighest,
                            child: Icon(
                              Icons.image_outlined,
                              color: warna.onSurfaceVariant,
                            ),
                          ),
                          title: Text(
                            item.kategori,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(item.deskripsi),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: warnaLatarStatus,
                                    borderRadius:
                                        BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    item.status,
                                    style: TextStyle(
                                      color: warnaStatus,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          trailing: const Icon(
                            Icons.chevron_right,
                          ),
                          isThreeLine: true,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),

      // Tombol aksi utama
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Formulir pengaduan dibuat pada layar pendukung.',
              ),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Buat Pengaduan'),
      ),

      // Navigasi bawah sesuai wireframe
      bottomNavigationBar: NavigationBar(
        selectedIndex: halamanTerpilih,
        onDestinationSelected: (index) {
          setState(() {
            halamanTerpilih = index;
          });

          if (index == 1) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Halaman status masih berupa prototipe.',
                ),
              ),
            );
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.article_outlined),
            selectedIcon: Icon(Icons.article),
            label: 'Status',
          ),
        ],
      ),
    );
  }
}