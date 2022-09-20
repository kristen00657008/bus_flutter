import 'dart:async';
import 'package:flutter/cupertino.dart';

class Debounce {
  final int milliseconds;
  late VoidCallback action;
  Timer? timer;

  Debounce({required this.milliseconds});

  run(VoidCallback action) {
    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
