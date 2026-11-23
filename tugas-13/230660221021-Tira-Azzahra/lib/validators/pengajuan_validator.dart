class PengajuanValidator {
  static String? validasiNama(String? value) {
    final teks = value?.trim() ?? '';
    if (teks.isEmpty) {
      return 'Nama lengkap mahasiswa wajib diisi.';
    }
    if (teks.length < 3) {
      return 'Nama lengkap minimal terdiri dari 3 karakter.';
    }
    if (teks.length > 100) {
      return 'Nama lengkap maksimal 100 karakter.';
    }
    return null;
  }

  static String? validasiNim(String? value) {
    final nim = value?.trim() ?? '';
    if (nim.isEmpty) {
      return 'NIM mahasiswa wajib diisi.';
    }
    final polaNim = RegExp(r'^\d{12}$');
    if (!polaNim.hasMatch(nim)) {
      return 'Format NIM tidak valid (harus 12 digit angka, contoh: 230660221021).';
    }
    return null;
  }

  static String? validasiEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) {
      return 'Email kontak wajib diisi.';
    }
    final polaEmail = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,}$');
    if (!polaEmail.hasMatch(email)) {
      return 'Format email tidak valid (contoh: nama@student.unsap.ac.id).';
    }
    return null;
  }

  static String? validasiJudulBuku(String? value) {
    final judul = value?.trim() ?? '';
    if (judul.isEmpty) {
      return 'Judul buku yang dipinjam wajib diisi.';
    }
    if (judul.length < 5) {
      return 'Judul buku terlalu pendek (minimal 5 karakter).';
    }
    if (judul.length > 150) {
      return 'Judul buku maksimal 150 karakter.';
    }
    return null;
  }

  static String? validasiDurasiHari(String? value) {
    final teks = value?.trim() ?? '';
    if (teks.isEmpty) {
      return 'Lama peminjaman wajib diisi.';
    }
    final hari = int.tryParse(teks);
    if (hari == null) {
      return 'Lama peminjaman harus berupa angka bulat.';
    }
    if (hari < 1 || hari > 14) {
      return 'Durasi peminjaman buku hanya diizinkan antara 1 hingga 14 hari.';
    }
    return null;
  }

  static String? validasiUkuranLampiran(double ukuranMb) {
    if (ukuranMb <= 0) {
      return 'File lampiran tidak valid atau kosong.';
    }
    if (ukuranMb > 5.0) {
      return 'Ukuran file lampiran maksimal 5 MB.';
    }
    return null;
  }
}