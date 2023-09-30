
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:twp_case_king/main.dart';

void main() {

  testWidgets('isLoading behavior test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    var findButton = find.byType(ElevatedButton);
    expect(findButton, findsOneWidget);
    await tester.tap(findButton);
    await tester.pump();

    await tester.tap(findButton);
    await tester.pump();


  });
}
