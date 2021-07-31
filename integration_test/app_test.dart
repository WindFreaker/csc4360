import 'package:csc4360/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  group('Performance Tests Group', () {

    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized() as IntegrationTestWidgetsFlutterBinding;

    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

    testWidgets('Consecutive performance Tests', (tester) async {

      // proper app startup?
      await Firebase.initializeApp();
      await tester.pumpWidget(FinalProject(ThemeMode.system));
      await tester.idle();

      final list = find.byType(ListView);

      await binding.watchPerformance(() async {

        await tester.fling(list, Offset(0, -500), 10000);
        await tester.pumpAndSettle();

        await tester.fling(list, Offset(0, 500), 10000);
        await tester.pumpAndSettle();

      }, reportKey: 'scrolling_boards');

    });

  });

}