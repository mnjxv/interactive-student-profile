import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:interactive_student_profile/main.dart';

Future<void> _pumpApp(WidgetTester tester) async {
  await tester.pumpWidget(const StudentProfileApp());
  await tester.pumpAndSettle();
}

Future<void> _openTab(WidgetTester tester, IconData icon) async {
  await tester.tap(find.byIcon(icon));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('dashboard shows the sample data on launch', (tester) async {
    await _pumpApp(tester);

    expect(find.text('Student Dashboard'), findsOneWidget);
    expect(find.text('Juan Dela Cruz'), findsWidgets);
    expect(find.text('2 of 3 completed'), findsOneWidget);
    expect(find.text('Assignments'), findsOneWidget);
    expect(find.text('Schedule'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('Announcements'), 300);
    expect(find.text('Announcements'), findsOneWidget);
  });

  testWidgets('can add and complete an assignment', (tester) async {
    await _pumpApp(tester);

    await tester.tap(find.byTooltip('Add assignment'));
    await tester.pumpAndSettle();

    expect(find.text('New assignment'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'Lab report');
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    expect(find.text('Lab report'), findsOneWidget);
    expect(find.text('2 of 4 completed'), findsOneWidget);

    await tester.tap(find.widgetWithText(CheckboxListTile, 'Lab report'));
    await tester.pumpAndSettle();

    expect(find.text('3 of 4 completed'), findsOneWidget);
  });

  testWidgets('rejects an empty assignment title', (tester) async {
    await _pumpApp(tester);

    await tester.tap(find.byTooltip('Add assignment'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    expect(find.text('Please enter something'), findsOneWidget);
    expect(find.text('New assignment'), findsOneWidget);
  });

  testWidgets('can edit the student profile', (tester) async {
    await _pumpApp(tester);
    await _openTab(tester, Icons.person_outline);

    expect(find.text('Details'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('Edit profile'), 300);
    await tester.tap(find.text('Edit profile'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).first, 'Maria Santos');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Maria Santos'), findsWidgets);
    expect(find.text('Profile updated'), findsOneWidget);
  });

  testWidgets('settings toggles dark mode and resets assignments', (
    tester,
  ) async {
    await _pumpApp(tester);
    await _openTab(tester, Icons.settings_outlined);

    expect(find.text('Appearance'), findsOneWidget);
    expect(find.text('Accent color'), findsOneWidget);

    await tester.tap(find.byType(SwitchListTile));
    await tester.pumpAndSettle();

    final switchTile = tester.widget<SwitchListTile>(
      find.byType(SwitchListTile),
    );
    expect(switchTile.value, isTrue);

    await tester.tap(find.text('Reset assignments'));
    await tester.pumpAndSettle();
    expect(find.text('Reset assignments?'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Reset'));
    await tester.pumpAndSettle();

    expect(find.text('Assignments reset'), findsOneWidget);

    await _openTab(tester, Icons.home_outlined);
    expect(find.text('2 of 3 completed'), findsOneWidget);
  });
}
