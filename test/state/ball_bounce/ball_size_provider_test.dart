import 'package:bounce_ball/state/ball_size_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("ball size provider test suite 💼:", () {
    test('ballSizeNotifier increments and decrements ball size correctly ⏱️',
        () {
      // Arrange
      final ballSizeNotifier = BallSizeNotifier();

      // Assert -- initial value
      expect(ballSizeNotifier.value, 50);

      // Act
      ballSizeNotifier.decBallSize();
      // Assert
      expect(ballSizeNotifier.value, 49);

      // Act
      ballSizeNotifier.incBallSize();
      // Assert
      expect(ballSizeNotifier.value, 50);
    });

    test('ballSizeNotifier updates resize flag and increment flag correctly ⏱️',
        () {
      // Arrange
      final ballSizeNotifier = BallSizeNotifier();

      // Assert -- initial values
      expect(ballSizeNotifier.resizeBall, false);
      expect(ballSizeNotifier.isValueInc, true);

      // Act
      ballSizeNotifier.updateBallResize(true);
      // Assert
      expect(ballSizeNotifier.resizeBall, true);

      // Act
      ballSizeNotifier.updateValueInc(false);
      // Assert
      expect(ballSizeNotifier.isValueInc, false);
    });
  });
}
