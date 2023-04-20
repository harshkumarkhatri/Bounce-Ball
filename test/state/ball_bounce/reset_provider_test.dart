import 'package:bounce_ball/state/reset_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  group('reset provider test suite 💼:', () {
    testWidgets('initial value of isReset is false ⏱️',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Consumer(
                builder: (context, ref, child) {
                  final reset = ref.watch(resetProvider);
                  return Text(
                    reset.isReset.toString(),
                    key: const Key('resetText'),
                  );
                },
              ),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('false'), findsOneWidget);
    });

    test('updateReset sets isReset ⏱️', () {
      // Arrange
      final notifier = ResetNotifier();

      // Act
      notifier.updateReset(true);

      // Assert
      expect(notifier.isReset, true);
    });

    test('notifyListeners triggers listeners ⏱️', () {
      // Arrange
      final notifier = ResetNotifier();
      bool hasListenerBeenCalled = false;

      // Act
      notifier.addListener(() {
        hasListenerBeenCalled = true;
      });
      notifier.updateReset(true);

      // Assert
      expect(hasListenerBeenCalled, true);
    });
  });
}
