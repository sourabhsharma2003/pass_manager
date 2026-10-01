import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:password_manager/src/core/appshell/appshell.dart';
import 'package:password_manager/src/core/constants/widget_Keys.dart';

void main() {
  testWidgets('Widgets Test: is Appshell return right screen ', (tester) async {
    await tester.pumpWidget(
      ProviderScope(child: MaterialApp(home: Appshell())),
    );

    expect(find.byKey(WidgetKeys.authScreen), findsOneWidget);
  });
}
