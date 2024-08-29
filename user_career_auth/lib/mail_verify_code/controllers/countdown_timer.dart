import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CountdownTimer extends StateNotifier<int> {
  Timer? _timer;
  DateTime? _endTime;

  CountdownTimer(super.initialValue);

  void startTimer() {
    _endTime = DateTime.now().add(Duration(seconds: state));
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final remaining = _endTime!.difference(DateTime.now()).inSeconds;
      if (remaining <= 0) {
        _timer?.cancel();
        _timer = null;
        state = 0;
      } else {
        state = remaining;
      }
    });
  }

  bool get isTimerComplete => state == 0;

  void setInitialValue(int initialValue) {
    state = initialValue;
    _endTime = null;
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final countdownTimerProvider = StateNotifierProvider<CountdownTimer, int>((ref) {
  return CountdownTimer(0);
});