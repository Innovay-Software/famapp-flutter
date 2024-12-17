import 'package:flutter_app_badge_control/flutter_app_badge_control.dart';

import '../abstracts/inno_notification_service.dart';
import '../utils/debug_utils.dart';

class UserNotificationService extends InnoUserNotificationService {
  final Map<String, int> _notificationMap = {};
  UserNotificationService() {
    InnoUserNotificationService.instance = this;
  }

  void syncRawData(Map rawData) {
    DebugManager.log("UserNotificationService.syncRawData");
    DebugManager.log(rawData.toString());

    this.rawData = rawData;
    rawData.forEach((key, value) {
      if (key == 'im') {
        (value as Map).forEach((key2, value2) {
          if (key2 == 'total') {
            _notificationMap['imTotal'] = int.tryParse('$value2') ?? 0;
          } else {
            _notificationMap[key2] = int.tryParse('$value2') ?? 0;
          }
        });
      } else {
        _notificationMap[key] = int.tryParse('$value') ?? 0;
      }
    });
    DebugManager.log("UserNotificationService.syncRawData update badge number to ${_notificationMap['total'] ?? 0}");
    FlutterAppBadgeControl.updateBadgeCount(_notificationMap['total'] ?? 0);
    updateWidgets();
  }

  @override
  int totalNotificationCount() {
    return _notificationMap['total'] ?? 0;
  }

  @override
  int getNotificationCount(String notificationKey) {
    return _notificationMap[notificationKey] ?? 0;
  }

  @override
  void clearNotifications(String notificationKey) {
    DebugManager.error("Needs Implementation");
  }

  @override
  void syncCloudNotifications() {
    // if (!UserModel.instance.isLoggedIn) return;
    // NetworkManager.getRequest(InnovayConfig.userNotificationNetworkConfig.getNotifications(), (res) {
    //   syncNotifications(res['data']['notifications']);
    // }, (p0) => null);
  }

  @override
  void syncNotifications(dynamic notifications) {
    DebugManager.error("Should not be called");
  }
}
