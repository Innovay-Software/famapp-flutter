import 'dart:math';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;

import '../../../core/abstracts/inno_viewmodel.dart';
import '../../../core/config.dart';
import '../../../core/global_data.dart';
import '../../../core/services/inno_secure_storage_service.dart';
import '../../../core/utils/debug_utils.dart';
import '../../../core/utils/snack_bar_manager.dart';
import '../../../enums/enums.dart';
import '../../settings/viewmodel/user_viewmodel.dart';

class InitializationViewmodel extends InnoViewmodel {
  static final InitializationViewmodel _instance = InitializationViewmodel._();
  factory InitializationViewmodel() => _instance;
  InitializationViewmodel._();

  Future<void> appInitialization({
    required Function() onLoginRequired,
    required Function() onTokenExpired,
    required Function() onLoggedIn,
  }) async {
    InnoGlobalData.switchLoadingOverlay(true);

    ///
    /// Step 1: load from local cache:
    ///
    DebugManager.info("AppInitialization Step1: load user info from local cache");

    final userViewmodel = await UserViewmodel.asyncConstructor();
    final isUserDataLoadedFromCache = userViewmodel.currentUser.isLoggedIn;
    final accessToken = userViewmodel.currentUser.getAccessToken();

    DebugManager.info("isUserDataLoadedFromCache: $isUserDataLoadedFromCache");
    if (isUserDataLoadedFromCache) {
      DebugManager.info(userViewmodel.currentUser);
      DebugManager.info("Loaded accessToken = $accessToken ");
      DebugManager.info("Avatar = ${userViewmodel.currentUser.avatarUrl}");
    }

    if (accessToken.isEmpty) {
      InnoGlobalData.switchLoadingOverlay(false);
      if (!isUserDataLoadedFromCache) {
        DebugManager.warning("Did not load user from cache, and did not find user accessToken, needs login action");
        onLoginRequired();
        return;
      } else {
        DebugManager.warning(
            "Did load user from cache, but did not find user accessToken, continue to token expired action");
        onTokenExpired();
        return;
      }
    }
    if (isUserDataLoadedFromCache) {
      DebugManager.info("User data loaded from cache successfully");
      onLoggedIn();
    }

    ///
    /// Step2: Check for internet access
    ///
    DebugManager.info("AppInitialization Step2: Check for backend availability");
    while (true) {
      if (await InnoGlobalData.internetService.connected()) {
        // if is connected to internet, break and continue to next step
        InnoGlobalData.isConnectedToInternet = true;
        break;
      }
      if (isUserDataLoadedFromCache) {
        // if not connected to internet, but found local user model cache, continue
        break;
      }

      // If not connected to internet and didn't find a use model cache
      // This is likely due to opening the app for the first time and haven't given internet access permissions yet
      // Display a snack bar message and keep trying after 1 second
      DebugManager.error('Initialization Service: has no internet connection, stop initialization');
      SnackBarManager.displayMessage(
        AppLocalizations.of(InnoGlobalData.materialAppKey.currentContext!)!.networkUnavailableRetryIn10Seconds,
      );
      await Future.delayed(const Duration(seconds: 10));
    }

    ///
    /// Step 3: Check server proximity
    ///
    DebugManager.info("AppInitialization Step3: Check for backend server proximity");
    await _serverProximityInitialization();

    ///
    /// Step 4: Do server specific initializations
    ///
    DebugManager.info("AppInitialization Step4: Other additional initializations");
    if (!InnoGlobalData.useRegionRemote) {
      DebugManager.info("AppInitialization Step4a: Firebase for non-remote region");
      // await FirebaseService.init();
    }

    ///
    /// Step5: Refresh token
    ///
    DebugManager.info("AppInitialization Step5: Refresh Token");
    var tokenRefreshStatus = await userViewmodel.loginWithAccessToken(accessToken);
    if (!tokenRefreshStatus) {
      onTokenExpired();
      return;
    }
    if (!isUserDataLoadedFromCache) {
      // if token refresh succeeded but didn't call onLoggedIn before, call it now
      onLoggedIn();
    }

    ///
    /// Step6: Initialize websockets
    ///
    DebugManager.info("AppInitialization Step6: Placeholder, gRPC in the future maybe?");
    InnoGlobalData.switchLoadingOverlay(false);
  }

  Future<void> _serverProximityInitialization() async {
    var preferredBackendServer = InnoSecureStorageService().getStaticStorageValue(
      InnoSecureStorageKeys.preferredBackendServer,
    );
    var textCA = AppLocalizations.of(InnoGlobalData.materialAppKey.currentContext!)!.regionCA;
    var textRemote = AppLocalizations.of(InnoGlobalData.materialAppKey.currentContext!)!.regionRemote;

    var waitSeconds = 0;
    while (true) {
      var hostCA = InnoConfig.mainNetworkConfig.pingRegionCA();
      var hostRemote = InnoConfig.mainNetworkConfig.pingRegionRemote();
      var hostLatencyRemote = -1;
      var hostLatencyCA = -1;
      if (preferredBackendServer == BackendServerType.regionRemote.toShortString()) {
        hostLatencyRemote = await _getHostLatency(hostRemote, textRemote);
        if (hostLatencyRemote < 0) {
          hostLatencyCA = await _getHostLatency(hostCA, textCA);
        }
      } else if (preferredBackendServer == BackendServerType.regionCA.toShortString()) {
        hostLatencyCA = await _getHostLatency(hostCA, textCA);
        if (hostLatencyCA < 0) {
          hostLatencyRemote = await _getHostLatency(hostRemote, textRemote);
        }
      } else {
        hostLatencyRemote = await _getHostLatency(hostRemote, textRemote);
        hostLatencyCA = await _getHostLatency(hostCA, textCA);
      }

      DebugManager.log("CA, Remote latency: $hostLatencyCA, $hostLatencyRemote");

      // // Ping main server and CN server, and see which server has lower ping latency
      // var hostLatencyRemote = await _pingServer(Uri.parse(InnovayConfig.mainNetworkConfig.regionRemoteBackend).host);
      // var hostLatencyCA = await _pingServer(Uri.parse(InnovayConfig.mainNetworkConfig.regionCABackend).host);

      if (hostLatencyRemote <= 0 && hostLatencyCA <= 0) {
        SnackBarManager.displayMessage(
          AppLocalizations.of(InnoGlobalData.materialAppKey.currentContext!)!.cannotConnectToBackendServer,
        );
        waitSeconds = min(30, waitSeconds + 5);
        await Future.delayed(Duration(seconds: waitSeconds));
        continue;
      }

      InnoGlobalData.proximityBackendServer = hostLatencyCA <= 0 || hostLatencyRemote < hostLatencyCA
          ? BackendServerType.regionRemote
          : BackendServerType.regionCA;
      InnoGlobalData.updateUseRemoteServerValue();
      if (hostLatencyRemote < 0 && InnoGlobalData.useRegionRemote) {
        InnoGlobalData.useRegionRemote = false;
      } else if (hostLatencyCA < 0 && !InnoGlobalData.useRegionRemote) {
        InnoGlobalData.useRegionRemote = true;
      }
      break;
    }
    SnackBarManager.displayMessage(
      AppLocalizations.of(InnoGlobalData.materialAppKey.currentContext!)!.connectedToLocationServer(
        InnoGlobalData.useRegionRemote ? textRemote : textCA,
      ),
    );
  }

  Future<int> _getHostLatency(String url, String location) async {
    try {
      SnackBarManager.displayMessage(
        AppLocalizations.of(InnoGlobalData.materialAppKey.currentContext!)!.connectingToLocationServer(location),
      );
      var startTime = DateTime.now().microsecondsSinceEpoch;
      var res = await http.get(Uri.parse(url), headers: {}).timeout(const Duration(seconds: 5));
      DebugManager.log(res.statusCode.toString());
      var latency = res.statusCode == 200 ? DateTime.now().microsecondsSinceEpoch - startTime : -1;
      DebugManager.log("hostLatencyUrl: $url");
      SnackBarManager.displayMessage(
        AppLocalizations.of(InnoGlobalData.materialAppKey.currentContext!)!.connectedToLocationServerFailed(location),
      );

      return latency;
    } on Exception catch (e) {
      DebugManager.log(e.toString());
      SnackBarManager.displayMessage(
        AppLocalizations.of(InnoGlobalData.materialAppKey.currentContext!)!.connectedToLocationServerFailed(location),
      );
    }
    return -1;
  }
}
