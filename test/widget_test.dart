import 'package:flutter_test/flutter_test.dart';
import 'package:ripple/main.dart';

void main() {
  testWidgets('RippleApp smoke test - verifies HomeScreen loads', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const RippleApp());

    // Verify that the app title 'Ripple' is rendered
    expect(find.text('Ripple'), findsOneWidget);

    // Verify that Daily Reflection section exists
    expect(find.text('DAILY REFLECTION'), findsOneWidget);
  });
}
