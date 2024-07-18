import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';

class Logger {
  static final Logger _logger = Logger._internal();

  Logger._internal();

  factory Logger() {
    return _logger;
  }

  static log({required String mes}) {
    if (kDebugMode) {
      dev.log(mes, name: "::[APP-LOG]::", time: DateTime.now());
    }
  }
}
