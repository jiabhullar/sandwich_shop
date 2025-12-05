import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:sandwich_shop/screens/profile_screen.dart';

void main() {
  testWidgets('ProfileScreen renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfileScreen()));

    expect(find.text('Profile'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('Save'), findsOneWidget);
  });
}
