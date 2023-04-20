import 'package:bounce_ball/state/ball_speed_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ball speed provider test suite 💼:', () {
    test('updates ball speed correctly ⏱️', () {
      // Arrange
      final ballSpeed = BallSpeedNotifier();

      // Assert -- initial values
      expect(ballSpeed.value, 1);

      // Act
      ballSpeed.updateBallSpeed(3);
      // Assert
      expect(ballSpeed.value, 3);

      // Act
      ballSpeed.updateBallSpeed(5);
      // Assert
      expect(ballSpeed.value, 5);
    });

    test('notifyListeners triggers listeners ⏱️', () {
      // Arrange
      final notifier = BallSpeedNotifier();
      bool hasListenerBeenCalled = false;

      // Act
      notifier.addListener(() {
        hasListenerBeenCalled = true;
      });
      notifier.updateBallSpeed(5);

      // Assert
      expect(hasListenerBeenCalled, true);
    });
  });
}
