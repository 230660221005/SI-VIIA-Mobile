abstract class TokenStorage {
  Future<void> simpan(String token);
  Future<String?> baca();
  Future<void> hapus();
}

/// Implementasi penyimpanan sementara untuk simulasi tanpa hardcode kredensial
class MemoryTokenStorage implements TokenStorage {
  String? _tokenAktif;

  @override
  Future<void> simpan(String token) async {
    _tokenAktif = token;
  }

  @override
  Future<String?> baca() async => _tokenAktif;

  @override
  Future<void> hapus() async {
    _tokenAktif = null;
  }
}

class KeamananPerpustakaanService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  final TokenStorage _tokenStorage;

  KeamananPerpustakaanService(this._tokenStorage);

  /// Memastikan seluruh endpoint menggunakan HTTPS sebelum request dikirim
  bool isEndpointAman(String url) {
    final uri = Uri.tryParse(url);
    return uri != null && uri.scheme == 'https';
  }

  /// Simulasi sesi login mahasiswa tanpa menulis token di source code atau log
  Future<void> mulaiSesiSimulasi(String nim) async {
    final tokenSesi = 'session_${nim}_${DateTime.now().millisecondsSinceEpoch}';
    await _tokenStorage.simpan(tokenSesi);
  }

  Future<bool> punyaSesiAktif() async {
    final token = await _tokenStorage.baca();
    return token != null && token.isNotEmpty;
  }

  /// Menghapus token secara bersih saat pengguna keluar (logout)
  Future<void> logout() async {
    await _tokenStorage.hapus();
  }

  /// Mengirim data pengajuan yang sudah lolos validasi client melalui endpoint HTTPS
  Future> kirimPengajuanAman({
    required String nama,
    required String nim,
    required String email,
    required String judulBuku,
    required int durasiHari,
    required double ukuranLampiranMb,
  }) async {
    final endpoint = '$baseUrl/posts';
    if (!isEndpointAman(endpoint)) {
      throw Exception('Koneksi ditolak: endpoint wajib menggunakan protokol HTTPS.');
    }

    final token = await _tokenStorage.baca();
    if (token == null || token.isEmpty) {
      throw Exception('Sesi akses tidak ditemukan (HTTP 401). Silakan aktifkan sesi terlebih dahulu.');
    }

    // Simulasi pemrosesan aman tanpa mencetak token ke console/log
    await Future<void>.delayed(const Duration(milliseconds: 500));

    return {
      'status': 'berhasil',
      'endpoint': endpoint,
      'nama': nama.trim(),
      'nim': nim.trim(),
      'email': email.trim(),
      'judulBuku': judulBuku.trim(),
      'durasiHari': durasiHari,
      'ukuranLampiranMb': ukuranLampiranMb,
    };
  }
}