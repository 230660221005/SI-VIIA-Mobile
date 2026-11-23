import 'anggota_model.dart';
import 'peminjaman_model.dart';

class DetailPeminjamanModel {
  final int idPeminjaman;
  final int userId;
  final String namaPeminjam;
  final String nimPeminjam;
  final String prodiPeminjam;
  final String emailPeminjam;
  final String judulBuku;
  final bool sudahKembali;
  final String statusPeminjaman;

  const DetailPeminjamanModel({
    required this.idPeminjaman,
    required this.userId,
    required this.namaPeminjam,
    required this.nimPeminjam,
    required this.prodiPeminjam,
    required this.emailPeminjam,
    required this.judulBuku,
    required this.sudahKembali,
    required this.statusPeminjaman,
  });

  /// Menggabungkan data PeminjamanModel dengan AnggotaModel berdasarkan userId
  factory DetailPeminjamanModel.gabungkan({
    required PeminjamanModel peminjaman,
    AnggotaModel? anggota,
  }) {
    return DetailPeminjamanModel(
      idPeminjaman: peminjaman.id,
      userId: peminjaman.userId,
      namaPeminjam: anggota?.nama ?? 'Anggota Tidak Terdaftar (ID #${peminjaman.userId})',
      nimPeminjam: anggota?.nim ?? '-',
      prodiPeminjam: anggota?.prodi ?? 'Umum',
      emailPeminjam: anggota?.email ?? '-',
      judulBuku: peminjaman.judulBuku,
      sudahKembali: peminjaman.sudahKembali,
      statusPeminjaman: peminjaman.statusPeminjaman,
    );
  }
}