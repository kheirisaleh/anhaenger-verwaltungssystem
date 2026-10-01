import 'package:anhaenger_verwaltungssystem/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App startet und zeigt die Navigation', (WidgetTester tester) async {
    await tester.pumpWidget(const AnhaengerApp());
    expect(find.text('Dashboard'), findsWidgets);
  });
}
