final List<Map<String, Object>> komponen = [
  {'nama': 'Tugas', 'bobot': 20, 'skor': 18},
  {'nama': 'Praktikum', 'bobot': 25, 'skor': 23},
  {'nama': 'Kuis', 'bobot': 15, 'skor': 13},
  {'nama': 'UTS', 'bobot': 20, 'skor': 17},
  {'nama': 'Proyek', 'bobot': 20, 'skor': 19},
];

// Menghitung rata-rata skor seluruh komponen.
double hitungRataRata(List<Map<String, Object>> komponen) {
  if (komponen.isEmpty) {
    return 0.0;
  }

  int totalSkor = 0;

  for (final item in komponen) {
    totalSkor += item['skor'] as int;
  }

  return totalSkor / komponen.length;
}

// Aturan predikat berdasarkan rata-rata skor (skala 0–20):
// >= 18 -> A
// >= 16 -> B
// >= 14 -> C
// < 14  -> Perlu perbaikan
String predikat(double nilai) {
  if (nilai >= 18) {
    return 'A';
  } else if (nilai >= 16) {
    return 'B';
  } else if (nilai >= 14) {
    return 'C';
  } else {
    return 'Perlu perbaikan';
  }
}

void main() {
  print('Mata Kuliah: Pemrograman Aplikasi Bergerak');
  print('==========================================');
  print('Daftar Komponen Penilaian:');

  for (final item in komponen) {
    print(
      '${item['nama']} | '
      'Bobot: ${item['bobot']} | '
      'Skor: ${item['skor']}',
    );
  }

  final double rataRata = hitungRataRata(komponen);

  print('==========================================');
  print('Rata-rata skor: ${rataRata.toStringAsFixed(2)}');
  print('Predikat akhir: ${predikat(rataRata)}');
}

