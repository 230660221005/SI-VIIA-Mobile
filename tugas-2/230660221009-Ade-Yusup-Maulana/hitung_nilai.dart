// Tugas 2 - Modul Hitung Nilai
// Nama: Ade Yusup Maulana
// NIM : 230660221009

final List<Map<String, Object>> komponen = [
  {
    'nama': 'Tugas',
    'bobot': 20,
    'skor': 85,
  },
  {
    'nama': 'Praktikum',
    'bobot': 30,
    'skor': 90,
  },
  {
    'nama': 'Kuis',
    'bobot': 15,
    'skor': 80,
  },
  {
    'nama': 'UTS',
    'bobot': 15,
    'skor': 75,
  },
  {
    'nama': 'UAS',
    'bobot': 20,
    'skor': 88,
  },
];

double hitungRataRata(List<Map<String, Object>> komponen) {
  double total = 0;

  for (final item in komponen) {
    final bobot = item['bobot'] as int;
    final skor = item['skor'] as int;

    total += skor * bobot / 100;
  }

  return total;
}

// Aturan predikat:
// Nilai >= 86 = A
// Nilai 76-85 = B
// Nilai 61-75 = C
// Nilai < 61 = Perlu perbaikan

String predikat(double nilai) {
  if (nilai >= 86) {
    return 'A';
  } else if (nilai >= 76) {
    return 'B';
  } else if (nilai >= 61) {
    return 'C';
  } else {
    return 'Perlu perbaikan';
  }
}

void main() {
  const namaMataKuliah = 'Pemrograman Aplikasi Bergerak';

  final rataRata = hitungRataRata(komponen);
  final hasilPredikat = predikat(rataRata);

  print('=== MODUL HITUNG NILAI PAB ===');
  print('');
  print('Mata Kuliah: $namaMataKuliah');
  print('');
  print('Daftar Komponen:');

  for (final item in komponen) {
    print(
      '${item['nama']} '
      '(Bobot: ${item['bobot']}%, '
      'Skor: ${item['skor']})',
    );
  }

  print('');
  print('Rata-rata: ${rataRata.toStringAsFixed(2)}');
  print('Predikat : $hasilPredikat');
}