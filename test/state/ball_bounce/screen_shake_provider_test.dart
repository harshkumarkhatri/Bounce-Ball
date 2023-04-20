import 'package:bounce_ball/state/screen_shake_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('screen shake provider test suite 💼:', () {
    test('updateScreenShake sets isScreenShaked ⏱️', () {
      // Arrange
      final notifier = ScreenShakeNotifier();

      // Act
      notifier.updateScreenShake(true);

      // Assert
      expect(notifier.isScreenShaked, true);
    });

    test('notifyListeners triggers listeners ⏱️', () {
      // Arrange
      final notifier = ScreenShakeNotifier();
      bool hasListenerBeenCalled = false;

      // Act
      notifier.addListener(() {
        hasListenerBeenCalled = true;
      });
      notifier.updateScreenShake(true);

      // Assert
      expect(hasListenerBeenCalled, true);
    });
  });
}
