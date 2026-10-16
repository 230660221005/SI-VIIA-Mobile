import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiSuratUKM());
}

class AplikasiSuratUKM extends StatelessWidget {
  const AplikasiSuratUKM({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pengelolaan Surat Masuk UKM',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Surat Masuk UKM'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Surat Masuk',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: const [
                            Icon(Icons.mail),
                            SizedBox(height: 8),
                            Text('Total Surat'),
                            Text(
                              '4',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: const [
                            Icon(Icons.mark_email_unread),
                            SizedBox(height: 8),
                            Text('Belum Dicek'),
                            Text(
                              '2',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
              child: Text(
                'Daftar Surat Masuk',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: const [
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.mail_outline),
                      title: Text('Surat Undangan Rapat'),
                      subtitle: Text('Dari: Ketua UKM'),
                      trailing: Text('Baru'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.mail_outline),
                      title: Text('Surat Permohonan Kerja Sama'),
                      subtitle: Text('Dari: Organisasi Mahasiswa'),
                      trailing: Text('Baru'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.mail_outline),
                      title: Text('Surat Pemberitahuan Kegiatan'),
                      subtitle: Text('Dari: Fakultas'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.mail_outline),
                      title: Text('Surat Undangan Seminar'),
                      subtitle: Text('Dari: Universitas'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}