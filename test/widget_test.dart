import 'package:flutter_test/flutter_test.dart';

import 'package:nesadate/main.dart';

void main() {
  testWidgets('smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const NesaDateApp());
    expect(find.byType(NesaDateApp), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 1600));
    await tester.pumpAndSettle();
  });
}
