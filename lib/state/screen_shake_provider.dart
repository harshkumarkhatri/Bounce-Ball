import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScreenShakeNotifier extends ChangeNotifier {
  bool _isScreenShaked = false;
  bool get isScreenShaked => _isScreenShaked;

  void updateScreenShake(bool isShaked) {
    _isScreenShaked = isShaked;
    notifyListeners();
  }
}

final screenShakeProvider =
    ChangeNotifierProvider((ref) => ScreenShakeNotifier());
