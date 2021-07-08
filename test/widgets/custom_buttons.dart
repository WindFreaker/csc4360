import 'package:csc4360/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget oneButtonTest() {
  return MaterialApp(
    home: Scaffold(
      body: ButtonRow(
        buttons: [
          ElevatedButton(
            child: Text('Okay!'),
            onPressed: () {},
          ),
        ],
      ),
    ),
  );
}

Widget multiButtonTest() {
  return MaterialApp(
    home: Scaffold(
      body: ButtonRow(
        buttons: [
          TextButton(
            child: Text('TextButton'),
            onPressed: () {},
          ),
          ElevatedButton(
            child: Text('ElevatedButton'),
            onPressed: () {},
          ),
          OutlinedButton(
            child: Text('OutlinedButton'),
            onPressed: () {},
          ),
        ],
      ),
    ),
  );
}

void main() {
  group('Custom Button Widgets Tests', () {
    
    testWidgets('One Button ButtonRow', (test) async {

      // creates ButtonRow with one button
      await test.pumpWidget(oneButtonTest());

      // this should result in a row with only one button
      // there will be no SizedBox spacers as there is only one button

      expect(find.byType(Row), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(SizedBox), findsNothing);

    });
    
    testWidgets('Multiple Button ButtonRow', (test) async {
      // creates ButtonRow with one button
      await test.pumpWidget(multiButtonTest());

      // this should result in a row with three different style buttons
      // there will be two SizedBox spacers used to separate the buttons

      expect(find.byType(Row), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(OutlinedButton), findsOneWidget);
      expect(find.byType(SizedBox), findsNWidgets(2));
      
    });
    
  });
}