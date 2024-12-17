import '../global_data.dart';

class UserNotificationNetworkConfig {
  String apiVersion = '';
  String regionCABackend = '';
  String regionRemoteBackend = '';

  UserNotificationNetworkConfig(this.regionCABackend, this.regionRemoteBackend, this.apiVersion);

  String get notificationBackend => InnoGlobalData.useRegionRemote ? regionRemoteBackend : regionCABackend;
  String get notificationBackendApi => '$notificationBackend/api/$apiVersion';

  String getNotifications() {
    return '$notificationBackendApi/user-notifications/get-user-notifications';
  }

  String clearUserSystemNotifications() {
    return '$notificationBackendApi/user-notifications/clear-user-notifications/system';
  }

  String clearUserPersonalChatNotifications(int chatterUserId) {
    return '$notificationBackendApi/user-notifications/clear-user-notifications/personalChat-$chatterUserId';
  }
}
