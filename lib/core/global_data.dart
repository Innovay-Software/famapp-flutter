import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../enums/enums.dart';
import 'services/inno_secure_storage_service.dart';
import 'services/internet_service.dart';
import 'services/media_file_download_service.dart';
import 'services/media_file_upload_background_service.dart';
import 'services/user_notification_service.dart';
import 'utils/debug_utils.dart';

class InnoGlobalData {
  InnoGlobalData._();

  static GlobalKey<NavigatorState> materialAppKey = GlobalKey<NavigatorState>();
  static bool isDarkMode = false;

  static String googleCloudStorageAccessId = '';
  static String googleCloudStorageAccessSecretKey = '';
  static String googleCloudStorageDomain = '';
  static String googleCloudStorageBucketName = '';

  static String hwObsAccessId = '';
  static String hwObsAccessSecretKey = '';
  static String hwObsDomain = '';
  static String hwObsBucketName = '';

  static late IosDeviceInfo iosInfo;
  static late AndroidDeviceInfo androidInfo;
  static late PackageInfo packageInfo;

  static String deviceToken = '';
  static Language currentLanguage = Language.chinese;

  static EdgeInsets appViewPadding = EdgeInsets.zero;
  static BuildContext? bottomNavigatorContext;
  static BuildContext? slideshowNavigatorContext;

  // static late VoiceCallOverlayState voiceCallOverlay;
  // static late VoiceCallInvitationOverlayState voiceCallInvitationOverlay;

  // Overlays
  static late Function(bool) switchLoadingOverlay;

  // MediaFile Download and Uploads

  // ImCenterModel
  static Function(dynamic) wsInitialization = (data) {};

  // currentNavigationInstance: null,
  static BackendServerType proximityBackendServer = BackendServerType.regionClosest;
  static bool isWebsocketConnected = false;
  static bool isConnectedToInternet = false;
  static bool useRegionRemote = false;
  static bool isHighQualityMediaFileModeOn = false;

  // Websockets
  // static List<Function> onWsSyncStartedCallbacks = [];
  // static List<Function> onWsSyncCompletedCallbacks = [];

  // Services
  static MediaFileDownloadService mediaFileDownloader = MediaFileDownloadService();
  static MediaFileUploadBackgroundService mediaFileBackgroundUploader = MediaFileUploadBackgroundService();
  static UserNotificationService notificationService = UserNotificationService();
  static InternetService internetService = InternetService();

  static void updateUseRemoteServerValue() {
    DebugManager.log("proximityBackendServer = ${proximityBackendServer.toShortString()}");
    if (proximityBackendServer == BackendServerType.regionClosest) {
      proximityBackendServer = BackendServerType.regionCA;
    }
    var backendServerType = BackendServerType.regionCA;
    var preferredBackendServer = InnoSecureStorageService().getStaticStorageValue(
      InnoSecureStorageKeys.preferredBackendServer,
    );
    backendServerType = BackendServerType.values.firstWhere(
        (element) => element.toShortString() == preferredBackendServer,
        orElse: () => proximityBackendServer);
    useRegionRemote = backendServerType == BackendServerType.regionRemote;
  }
}
