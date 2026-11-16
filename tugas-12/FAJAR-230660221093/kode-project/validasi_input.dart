// Validator input untuk form pengajuan/pemesanan (Pertemuan 12).
// Berisi fungsi murni agar mudah diuji dan digunakan ulang di TextFormField.

class ValidasiInput {
  static const int panjangMaksNama = 100;
  static const int panjangMaksCatatan = 200;

  /// Memeriksa nama pemohon: wajib diisi dan memiliki batas panjang.
  static String? namaPemohon(String? value) {
    final nama = value?.trim() ?? '';
    if (nama.isEmpty) {
      return 'Nama pemohon wajib diisi.';
    }
    if (nama.length > panjangMaksNama) {
      return 'Nama maksimal $panjangMaksNama karakter.';
    }
    return null;
  }

  /// Memeriksa email: wajib diisi dan mengikuti format dasar.
  static String? email(String? value) {
    final alamat = value?.trim() ?? '';
    if (alamat.isEmpty) {
      return 'Email wajib diisi.';
    }
    final pola = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!pola.hasMatch(alamat)) {
      return 'Format email tidak valid. Contoh: nama@domain.com';
    }
    return null;
  }

  /// Memeriksa catatan/alamat layanan: wajib diisi dan dibatasi panjangnya.
  static String? catatan(String? value) {
    final teks = value?.trim() ?? '';
    if (teks.isEmpty) {
      return 'Catatan atau alamat layanan wajib diisi.';
    }
    if (teks.length > panjangMaksCatatan) {
      return 'Catatan maksimal $panjangMaksCatatan karakter.';
    }
    return null;
  }

  /// Memeriksa tanggal layanan (format yyyy-mm-dd dari date picker).
  /// Tanggal tidak boleh kosong dan tidak boleh sebelum hari ini.
  static String? tanggalLayanan(String? value, {DateTime? hariIni}) {
    final teks = value?.trim() ?? '';
    if (teks.isEmpty) {
      return 'Tanggal layanan wajib dipilih.';
    }
    final dipilih = DateTime.tryParse(teks);
    if (dipilih == null) {
      return 'Format tanggal tidak valid.';
    }
    final acuan = hariIni ?? DateTime.now();
    final batasHariIni = DateTime(acuan.year, acuan.month, acuan.day);
    final tgl = DateTime(dipilih.year, dipilih.month, dipilih.day);
    if (tgl.isBefore(batasHariIni)) {
      return 'Tanggal layanan tidak boleh sebelum hari ini.';
    }
    return null;
  }

  /// Sanitasi ringan: hapus spasi berlebih di awal/akhir.
  static String sanitasi(String value) => value.trim();
}
