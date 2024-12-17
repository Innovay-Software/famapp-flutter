import 'package:flutter/foundation.dart';

class DebugManager {
  static void log(Object text, {int repeatTime = 1}) {
    if (kDebugMode) {
      for (var i = 0; i < repeatTime; i++) {
        debugPrint('***DEBUG*** $i $text');
      }
    }
  }

  static void error(Object text, {int repeatTime = 1}) {
    if (kDebugMode) {
      for (var i = 0; i < repeatTime; i++) {
        debugPrint('***ERROR*** $i $text');
      }
    }
  }

  static void warning(Object text, {int repeatTime = 1}) {
    if (kDebugMode) {
      for (var i = 0; i < repeatTime; i++) {
        debugPrint('~~~WARNING~~~ $i $text');
      }
    }
  }

  static void info(Object text, {int repeatTime = 1}) {
    if (kDebugMode) {
      for (var i = 0; i < repeatTime; i++) {
        debugPrint('~~~INFO~~~ $i $text');
      }
    }
  }

  static void rest(Object text, {int repeatTime = 1}) {
    if (kDebugMode) {
      for (var i = 0; i < repeatTime; i++) {
        debugPrint('~~~REST~~~ $i $text');
      }
    }
  }

  static void grpc(Object text, {int repeatTime = 1}) {
    if (kDebugMode) {
      for (var i = 0; i < repeatTime; i++) {
        debugPrint('~~~GRPC~~~ $i $text');
      }
    }
  }

  static void unimplemented({String message = "", int repeatTime = 1}) {
    error("Unimplemented $message", repeatTime: repeatTime);
  }
}
