// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:apati_paseo_perro/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('HomeScreen displays title and FAB', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());

    // Verify that the title is displayed.
    expect(find.text('Paseos de Perro'), findsOneWidget);

    // Verify that the FloatingActionButton is present.
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
