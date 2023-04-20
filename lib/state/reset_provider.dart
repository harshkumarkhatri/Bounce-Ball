import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResetNotifier extends ChangeNotifier {
  bool _isReset = false;
  bool get isReset => _isReset;

  void updateReset(bool reset) {
    _isReset = reset;
    notifyListeners();
  }
}

final resetProvider = ChangeNotifierProvider((ref) => ResetNotifier());
