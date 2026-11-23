abstract class TokenStorage {
  Future simpan(String token);
  Future baca();
  Future hapus();
}

class MemoryTokenStorage implements TokenStorage {
  String? _tokenAktif;

  @override
  Future simpan(String token) async {
    _tokenAktif = token;
  }

  @override
  Future baca() async => _tokenAktif;

  @override
  Future hapus() async {
    _tokenAktif = null;
  }
}

class KeamananPerpustakaanService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  final TokenStorage _tokenStorage;

  KeamananPerpustakaanService(this._tokenStorage);

  bool isEndpointAman(String url) {
    final uri = Uri.tryParse(url);
    return uri != null && uri.scheme == 'https';
  }

  Future mulaiSesiSimulasi(String nim) async {
    final tokenSesi = 'session_${nim}_${DateTime.now().millisecondsSinceEpoch}';
    await _tokenStorage.simpan(tokenSesi);
  }

  Future punyaSesiAktif() async {
    final token = await _tokenStorage.baca();
    return token != null && token.toString().isNotEmpty;
  }

  Future logout() async {
    await _tokenStorage.hapus();
  }

  Future kirimPengajuanAman({
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
    if (token == null || token.toString().isEmpty) {
      throw Exception('Sesi akses tidak ditemukan (HTTP 401). Silakan aktifkan sesi terlebih dahulu.');
    }

    await Future.delayed(const Duration(milliseconds: 400));

    return {
      'id': DateTime.now().microsecondsSinceEpoch.toString(),
      'status': 'menunggu',
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