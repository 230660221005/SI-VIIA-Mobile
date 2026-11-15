// ============================================================================
// PAB — Tugas 11: Integrasi Fitur Perangkat
// Berkas: validasi_foto.dart — aturan format dan ukuran foto bukti pekerjaan
// Domain project: Glazent.pro (usaha jasa glass cleaning & nanocoating)
// ============================================================================
//
// Bantuan: Claude — menyusun aturan validasi foto (format, ukuran, file kosong)
// mengikuti materi Pertemuan 11, dengan konteks disesuaikan ke domain
// Glazent.pro.
//
// Berisi logika murni (tanpa package perangkat dan tanpa widget) sehingga
// mudah diuji. Aturan:
//   - format yang diterima : JPG, JPEG, dan PNG
//   - ukuran maksimal      : 5 MB
//   - file kosong          : ditolak
// ============================================================================

class ValidasiFoto {
  /// Batas ukuran foto: 5 MB.
  static const int batasByte = 5 * 1024 * 1024;

  /// Format yang diterima.
  static const List<String> formatDiizinkan = ['jpg', 'jpeg', 'png'];

  /// Memeriksa foto. Menghasilkan `null` bila valid, atau pesan alasan bila
  /// tidak valid (siap ditampilkan kepada pengguna).
  ///
  /// Format ditentukan dari ekstensi nama file. Bila nama tidak memiliki
  /// ekstensi yang dikenal, jenis MIME dipakai sebagai cadangan, karena pada
  /// sebagian target (mis. web) nama file dapat tidak memuat ekstensi.
  static String? periksa({
    required String nama,
    String? mimeType,
    required int ukuranByte,
  }) {
    if (ukuranByte <= 0) {
      return 'File foto kosong atau tidak dapat dibaca.';
    }

    if (!_formatValid(nama, mimeType)) {
      return 'Format foto tidak didukung. Gunakan JPG atau PNG.';
    }

    if (ukuranByte > batasByte) {
      final ukuranMb = (ukuranByte / (1024 * 1024)).toStringAsFixed(1);
      return 'Ukuran foto $ukuranMb MB melebihi batas 5 MB.';
    }

    return null;
  }

  static bool _formatValid(String nama, String? mimeType) {
    final titik = nama.lastIndexOf('.');
    if (titik != -1 && titik < nama.length - 1) {
      final ekstensi = nama.substring(titik + 1).toLowerCase();
      return formatDiizinkan.contains(ekstensi);
    }

    // Tanpa ekstensi: gunakan jenis MIME sebagai cadangan.
    if (mimeType != null && mimeType.startsWith('image/')) {
      final jenis = mimeType.substring('image/'.length).toLowerCase();
      return formatDiizinkan.contains(jenis);
    }
    return false;
  }
}
