// Tugas 13 PAB: Test Case dan Bug Fixes (dibawa dari Tugas 12, email diperbaiki)
// Nama: Galih Permana Sidik | NIM 230660221002 | SI-VIIA
//
// Semua aturan validasi form laporan ada di sini sebagai fungsi murni (tanpa
// widget dan tanpa package perangkat), sehingga dapat diuji langsung pada
// test/validator_laporan_test.dart. Setiap validator mengembalikan pesan error
// bila tidak valid dan null bila valid, sesuai kontrak `validator` pada
// TextFormField.
//
// Validasi ini hanya pemeriksaan client untuk umpan balik cepat. Aturan yang
// sama wajib diperiksa ulang oleh server (lihat validasi-input.md).
//
// Bantuan: Claude, menyusun daftar kasus uji validator dan menyarankan
// pemisahan aturan ke fungsi murni.

class ValidatorLaporan {
  ValidatorLaporan._();

  static const int maxLokasi = 100;
  static const int minDeskripsi = 10;
  static const int maxDeskripsi = 500;
  static const int maxEmail = 254;
  static const int batasHariKebelakang = 30;
  static const int batasFotoByte = 5 * 1024 * 1024; // 5 MB

  static const List<String> kategoriValid = ['Proyektor', 'AC', 'Keran', 'Kursi'];
  static const List<String> ekstensiFoto = ['jpg', 'jpeg', 'png'];

  // Perbaikan BUG-01 (Tugas 13): pola lama `^[^\s@]+@[^\s@]+\.[^\s@]+$` menerima
  // titik beruntun, titik di awal atau akhir, label domain berawalan strip, dan
  // TLD satu huruf. Pola ini memisahkan bagian lokal dan domain per label.
  // Batasan: hanya karakter ASCII, jadi email beralamat Unicode ditolak.
  static final RegExp _polaEmail = RegExp(
    r'^[A-Za-z0-9_%+\-]+(?:\.[A-Za-z0-9_%+\-]+)*'
    r'@(?:[A-Za-z0-9](?:[A-Za-z0-9\-]*[A-Za-z0-9])?\.)+[A-Za-z]{2,}$',
  );

  /// Lokasi: wajib dan maksimal 100 karakter setelah trim.
  static String? lokasi(String? value) {
    final teks = value?.trim() ?? '';
    if (teks.isEmpty) {
      return 'Lokasi wajib diisi.';
    }
    if (teks.length > maxLokasi) {
      return 'Lokasi maksimal $maxLokasi karakter.';
    }
    return null;
  }

  /// Kategori: wajib dipilih dan harus termasuk daftar yang dikenal.
  static String? kategori(String? value) {
    if (value == null || value.isEmpty) {
      return 'Kategori wajib dipilih.';
    }
    if (!kategoriValid.contains(value)) {
      return 'Kategori tidak dikenal.';
    }
    return null;
  }

  /// Deskripsi: wajib, 10 sampai 500 karakter setelah trim.
  static String? deskripsi(String? value) {
    final teks = value?.trim() ?? '';
    if (teks.isEmpty) {
      return 'Deskripsi wajib diisi.';
    }
    if (teks.length < minDeskripsi) {
      return 'Deskripsi minimal $minDeskripsi karakter.';
    }
    if (teks.length > maxDeskripsi) {
      return 'Deskripsi maksimal $maxDeskripsi karakter.';
    }
    return null;
  }

  /// Email kontak: opsional. Bila diisi harus berformat email dan maksimal 254
  /// karakter. Format dasar saja, keunikan dan status akun urusan server.
  static String? email(String? value) {
    final teks = value?.trim() ?? '';
    if (teks.isEmpty) {
      return null;
    }
    if (teks.length > maxEmail) {
      return 'Email maksimal $maxEmail karakter.';
    }
    if (!_polaEmail.hasMatch(teks)) {
      return 'Format email tidak valid.';
    }
    return null;
  }

  /// Tanggal kejadian: wajib, tidak boleh di masa depan, dan paling lama 30
  /// hari ke belakang. Parameter [sekarang] ada agar mudah diuji.
  static String? tanggalKejadian(DateTime? value, {DateTime? sekarang}) {
    if (value == null) {
      return 'Tanggal kejadian wajib dipilih.';
    }
    final acuan = sekarang ?? DateTime.now();
    final hariIni = DateTime(acuan.year, acuan.month, acuan.day);
    final tanggal = DateTime(value.year, value.month, value.day);

    if (tanggal.isAfter(hariIni)) {
      return 'Tanggal kejadian tidak boleh di masa depan.';
    }
    final batasAwal = hariIni.subtract(const Duration(days: batasHariKebelakang));
    if (tanggal.isBefore(batasAwal)) {
      return 'Tanggal kejadian maksimal $batasHariKebelakang hari ke belakang.';
    }
    return null;
  }

  /// Berkas foto: format JPG atau PNG dan ukuran maksimal 5 MB. Bila nama tidak
  /// memiliki ekstensi (terjadi pada beberapa pemilih berkas web), tipe MIME
  /// gambar dipakai sebagai pengganti.
  static String? fotoBerkas({
    required String nama,
    required int ukuranByte,
    String? mimeType,
  }) {
    final ekstensi = nama.contains('.') ? nama.split('.').last.toLowerCase() : '';
    final ekstensiValid = ekstensiFoto.contains(ekstensi);
    final mimeGambar = (mimeType ?? '').startsWith('image/');

    if (!ekstensiValid && !(ekstensi.isEmpty && mimeGambar)) {
      return 'Format foto tidak didukung. Gunakan JPG atau PNG.';
    }
    if (ukuranByte > batasFotoByte) {
      return 'Ukuran foto melebihi 5 MB. Pilih foto yang lebih kecil.';
    }
    return null;
  }
}
