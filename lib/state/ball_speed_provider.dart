import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BallSpeedNotifier extends ChangeNotifier {
  int _value = 1;
  int get value => _value;

  void updateBallSpeed(int speed) {
    _value = speed;
    notifyListeners();
  }
}

final ballSpeedProvider = ChangeNotifierProvider((ref) => BallSpeedNotifier());
