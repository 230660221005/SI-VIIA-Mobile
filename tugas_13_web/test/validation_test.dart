import 'package:flutter_test/flutter_test.dart';

import 'package:tugas_13_web/services/validation_service.dart';

void main() {
  test('validator menolak nilai nominal yang tidak valid', () {
    expect(InputValidators.amount('0'), isNotNull);
    expect(InputValidators.amount('abc'), isNotNull);
    expect(InputValidators.amount('75000'), isNull);
  });

  test('validator memeriksa email dan nama', () {
    expect(InputValidators.email('email-salah'), isNotNull);
    expect(InputValidators.email('user@example.com'), isNull);
    expect(
      InputValidators.requiredText('', label: 'Nama transaksi'),
      isNotNull,
    );
  });
}
