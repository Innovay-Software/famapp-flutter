import 'dart:collection';

class DebugLogger {
  static final DebugLogger _instance = DebugLogger._internal();
  factory DebugLogger() => _instance;
  DebugLogger._internal();

  final Queue<String> _logs = Queue<String>();
  final int _maxLogs = 100;

  void log(String message) {
    if (_logs.length >= _maxLogs) {
      _logs.removeFirst();
    }
    _logs.add('${DateTime.now()}: $message');
  }

  List<String> getLogs() {
    return _logs.toList();
  }
}
