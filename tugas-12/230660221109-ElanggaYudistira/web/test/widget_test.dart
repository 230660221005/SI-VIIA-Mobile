import 'package:flutter_test/flutter_test.dart';

import 'package:tugas_12_web/services/validation_service.dart';

void main() {
  test('validator menolak jumlah tidak valid', () {
    expect(InputValidators.amount('0'), isNotNull);
    expect(InputValidators.amount('abc'), isNotNull);
    expect(InputValidators.amount('75000'), isNull);
  });

  test('validator memeriksa email', () {
    expect(InputValidators.email('email-salah'), isNotNull);
    expect(InputValidators.email('user@example.com'), isNull);
  });
}
