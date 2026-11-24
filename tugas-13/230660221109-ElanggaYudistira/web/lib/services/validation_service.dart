import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class InputValidators {
  static String? requiredText(
    String? value, {
    required String label,
    int maxLength = 80,
  }) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return label + ' wajib diisi.';
    if (text.length > maxLength) {
      return label + ' maksimal ' + maxLength.toString() + ' karakter.';
    }
    return null;
  }

  static String? email(String? value) {
    final required = requiredText(value, label: 'Email', maxLength: 120);
    if (required != null) return required;
    final pattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!pattern.hasMatch(value!.trim())) {
      return 'Format email belum benar.';
    }
    return null;
  }

  static String? amount(String? value) {
    final required = requiredText(value, label: 'Jumlah', maxLength: 15);
    if (required != null) return required;
    final number = int.tryParse(
      value!.replaceAll('.', '').replaceAll(',', '').trim(),
    );
    if (number == null) return 'Jumlah harus berupa angka.';
    if (number <= 0) return 'Jumlah harus lebih besar dari nol.';
    if (number > 100000000) return 'Jumlah melebihi batas transaksi.';
    return null;
  }

  static String? date(DateTime? value) {
    if (value == null) return 'Tanggal transaksi wajib dipilih.';
    final today = DateTime.now();
    final selected = DateTime(value.year, value.month, value.day);
    final current = DateTime(today.year, today.month, today.day);
    if (selected.isAfter(current)) {
      return 'Tanggal transaksi tidak boleh di masa depan.';
    }
    return null;
  }

  static String summary({
    required bool validForm,
    String? dateError,
    String? fileError,
  }) {
    if (!validForm) return 'Periksa kembali input yang ditandai.';
    return dateError ?? fileError ?? 'Periksa kembali input yang ditandai.';
  }

  static Future<String?> image(XFile? file) async {
    if (file == null) return 'Bukti transaksi wajib dipilih.';
    final extension = file.name.toLowerCase().split('.').last;
    const allowed = {'jpg', 'jpeg', 'png', 'webp'};
    if (!allowed.contains(extension)) {
      return 'Format bukti harus JPG, JPEG, PNG, atau WEBP.';
    }

    final Uint8List bytes = await file.readAsBytes();
    if (bytes.length > 5 * 1024 * 1024) {
      return 'Ukuran bukti maksimal 5 MB.';
    }
    return null;
  }
}
