import 'package:bounce_ball/screens/bounce_ball_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("bounce ball screen test suite 💼:", () {
    testWidgets('bouncing ball screen is laid out correctly ⏱️',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: BouncingBallScreen(),
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(BouncingBallScreen), findsOneWidget);
      expect(find.byType(ProviderScope), findsOneWidget);
    });

    testWidgets('ball does not changes x position ⏱️',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: BouncingBallScreen(),
            ),
          ),
        ),
      );
      final ballFinder = find.byType(BouncingBallScreen);
      final initialPosition = tester.getCenter(ballFinder);

      // Act
      await tester.tap(find.byType(GestureDetector).first);
      await tester.pump();

      // Arrange
      final newPosition = tester.getCenter(ballFinder);

      // Assert
      expect(newPosition.dx, equals(initialPosition.dx));
    });
  });
}
