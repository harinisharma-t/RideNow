
import 'package:flutter_test/flutter_test.dart';
import 'package:ridenow/main.dart';

void main() {
  testWidgets('RideNow app loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const RideNowApp());

    expect(find.text('RideNow'), findsWidgets);
    expect(find.text('Book a Ride'), findsWidgets);
  });
}
