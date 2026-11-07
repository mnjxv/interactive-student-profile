import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:interactive_student_profile/main.dart';

void main() {
  const sizes = <String, Size>{
    'small phone': Size(320, 640),
    'phone': Size(390, 844),
    'tablet': Size(834, 1112),
    'desktop': Size(1280, 800),
  };

  for (final entry in sizes.entries) {
    testWidgets('lays out all tabs at ${entry.key}', (tester) async {
      tester.view.physicalSize = entry.value;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(const StudentProfileApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.person_outline));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.settings_outlined));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.home_outlined));
      await tester.pumpAndSettle();
    });
  }
}
