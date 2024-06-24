import 'dart:async';
import 'dart:ui';

class Debouncer {
  Debouncer({required this.milliseconds, this.action, this.timer});

  final int milliseconds;
  VoidCallback? action;
  Timer? timer;

  void run(VoidCallback action) {
    if (null != timer) {
      timer?.cancel();
    }
    timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
