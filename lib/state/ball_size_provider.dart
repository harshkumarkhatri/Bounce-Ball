import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BallSizeNotifier extends ChangeNotifier {
  double _value = 50;
  double get value => _value;

  bool _resizeBall = false;
  bool get resizeBall => _resizeBall;

  bool _isValueInc = true;
  bool get isValueInc => _isValueInc;

  void decBallSize() {
    _value--;
    notifyListeners();
  }

  void incBallSize() {
    _value++;
    notifyListeners();
  }

  void updateBallResize(bool canResizeBall) {
    _resizeBall = canResizeBall;
    notifyListeners();
  }

  void updateValueInc(bool isInc) {
    _isValueInc = isInc;
    notifyListeners();
  }
}

final ballSizeProvider = ChangeNotifierProvider((ref) => BallSizeNotifier());
