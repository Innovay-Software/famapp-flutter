import 'dart:math';

import '../utils/debug_utils.dart';

abstract class InnoUserNotificationService {
  static late InnoUserNotificationService instance;
  final Random randomSeeder = Random();
  final Map<String, Function()> listeners = {};
  Map rawData = {};

  int totalNotificationCount();

  int getNotificationCount(String notificationKey);

  void clearNotifications(String notificationKey);

  void syncCloudNotifications();

  void syncNotifications(dynamic notifications);

  void updateWidgets() {
    // DebugManager.Log('updateWidgets');
    listeners.forEach((key, value) {
      // DebugManager.Log('updateWidgets. $key');
      value();
    });
  }

  String registerListener(Function() callback) {
    var key = 'listener${randomSeeder.nextInt(10000)}';
    listeners[key] = callback;
    // DebugManager.log('add Listener $key');
    // DebugManager.log(listeners.keys.toString());
    return key;
  }

  void unregisterListener(String key) {
    DebugManager.log("remove listener: $key");
    if (!listeners.containsKey(key)) return;
    listeners.remove(key);
  }
}
