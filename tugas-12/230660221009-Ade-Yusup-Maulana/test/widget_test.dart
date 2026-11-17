
import 'package:flutter_test/flutter_test.dart';
import 'package:tugas_11/main.dart';

void main() {
  testWidgets(
    'Aplikasi Tugas 12 berhasil ditampilkan',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      expect(find.byType(MyApp), findsOneWidget);
    },
  );
}
