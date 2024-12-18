import 'dart:math';

import 'package:famapp/features/initialization/viewmodel/usercases/check_for_mobile_update.dart';
import 'package:famapp/features/initialization/viewmodel/usercases/ping_backend.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../api_agent.dart';
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
    required Function() onOfflineLoggedIn,
    required Function() onBackendLoggedIn,
    required bool allowOfflineLogin,
  }) async {
    InnoGlobalData.switchLoadingOverlay(true);
    final res = await appInitializationOfflineLogin(onOfflineLoggedIn: onOfflineLoggedIn);
    InnoGlobalData.switchLoadingOverlay(false);
    await appInitializationServerAvailability();

    ///
    /// Step 4: Do server specific initializations
    ///
    DebugManager.info("AppInitialization Step4: Other additional initializations");
    if (!InnoGlobalData.useRegionRemote) {
      DebugManager.info("AppInitialization Step4a: Firebase for non-remote region");
      // await FirebaseService.init();
    }

    ///
    /// Step5: Log in with access token
    ///
    DebugManager.info("AppInitialization Step5: accessTokenLogin");
    final accessToken = UserViewmodel().currentUser.getAccessToken();
    if (!await UserViewmodel().loginWithAccessToken(accessToken)) {
      onTokenExpired();
      return;
    }

    onBackendLoggedIn();

    ///
    /// Step6: Initialize websockets
    ///
    DebugManager.info("AppInitialization Step6: Placeholder, possible future gRPC migration");
    InnoGlobalData.switchLoadingOverlay(false);

    ///
    /// Step7: Check for mobile updates
    ///
    final userCase = CheckForMobileUpdate();
    if (UserViewmodel.mainContext.mounted) {
      userCase.call(UserViewmodel.mainContext);
    }
  }

  Future<bool> appInitializationOfflineLogin({
    required Function() onOfflineLoggedIn,
  }) async {
    DebugManager.info("appInitializationOfflineLogin: load user info from local cache");
    final userViewmodel = await UserViewmodel.asyncConstructor();
    final accessToken = userViewmodel.currentUser.getAccessToken();

    if (accessToken.isNotEmpty) {
      onOfflineLoggedIn();
      return true;
    }
    return false;
  }

  Future<void> appInitializationServerAvailability() async {
    DebugManager.info("appInitializationServerAvailability: Check for backend availability");

    ///
    /// Step 2: Check for internet connection
    /// Once server proximity is determined, it will not change until restarting APP
    ///
    while (true) {
      if (await InnoGlobalData.internetService.connected()) {
        // if is connected to internet, break and continue to next step
        InnoGlobalData.isConnectedToInternet = true;
        break;
      }

      // If not connected to internet and didn't find a use model cache
      // This is likely due to opening the app for the first time and haven't given internet access permissions yet
      // Display a snack bar message and keep trying after 1 second
      DebugManager.error('Initialization Service: has no internet connection, recheck in 10 seconds');
      SnackBarManager.displayMessage(
        AppLocalizations.of(InnoGlobalData.materialAppKey.currentContext!)!.networkUnavailableRetryIn10Seconds,
      );
      await Future.delayed(const Duration(seconds: 10));
    }

    ///
    /// Step 3: Check server proximity and Initialize ApiAgent
    /// Once server proximity is determined, it will not change until restarting APP
    ///
    DebugManager.info("AppInitialization Step3: Check for backend server proximity");
    await _serverProximityInitialization();
    final mainNetworkConfig = InnoConfig.mainNetworkConfig;
    final apiAgent = ApiAgent.init(
      InnoGlobalData.useRegionRemote ? mainNetworkConfig.regionRemoteBackend : mainNetworkConfig.regionCABackend,
      (String refreshToken, String accessToken) {
        if (refreshToken.isNotEmpty) {
          UserViewmodel().currentUser.setRefreshToken(refreshToken);
        }
        if (accessToken.isNotEmpty) {
          UserViewmodel().currentUser.setAccessToken(refreshToken);
        }
      },
    );
    DebugManager.warning("ApiInitialized");
  }

  Future<void> _serverProximityInitialization() async {
    final preferredBackendServer = InnoSecureStorageService().getStaticStorageValue(
      InnoSecureStorageKeys.preferredBackendServer,
    );
    final textCA = AppLocalizations.of(InnoGlobalData.materialAppKey.currentContext!)!.regionCA;
    final textRemote = AppLocalizations.of(InnoGlobalData.materialAppKey.currentContext!)!.regionRemote;

    var waitSeconds = 0;
    while (true) {
      var hostLatencyRemote = -1;
      var hostLatencyCA = -1;
      if (preferredBackendServer == BackendServerType.regionRemote.toShortString()) {
        hostLatencyRemote = await _getHostLatency(false);
        if (hostLatencyRemote < 0) {
          hostLatencyCA = await _getHostLatency(true);
        }
      } else if (preferredBackendServer == BackendServerType.regionCA.toShortString()) {
        hostLatencyCA = await _getHostLatency(true);
        if (hostLatencyCA < 0) {
          hostLatencyRemote = await _getHostLatency(false);
        }
      } else {
        hostLatencyRemote = await _getHostLatency(false);
        hostLatencyCA = await _getHostLatency(true);
      }

      DebugManager.log("CA, Remote latency: $hostLatencyCA, $hostLatencyRemote");

      // // Ping main server and remote server, and see which server has lower ping latency
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

  Future<int> _getHostLatency(bool useCaBackend) async {
    var textCA = AppLocalizations.of(InnoGlobalData.materialAppKey.currentContext!)!.regionCA;
    var textRemote = AppLocalizations.of(InnoGlobalData.materialAppKey.currentContext!)!.regionRemote;

    try {
      SnackBarManager.displayMessage(
        AppLocalizations.of(InnoGlobalData.materialAppKey.currentContext!)!
            .connectingToLocationServer(useCaBackend ? textCA : textRemote),
      );
      final useCase = PingBackend();
      final response = await useCase.call(useCaBackend);
      final latency = response.data['latency'] ?? -1;
      SnackBarManager.displayMessage(
        AppLocalizations.of(InnoGlobalData.materialAppKey.currentContext!)!
            .connectedToLocationServerFailed(useCaBackend ? textCA : textRemote),
      );

      return latency;
    } on Exception catch (e) {
      DebugManager.log(e.toString());
      SnackBarManager.displayMessage(
        AppLocalizations.of(InnoGlobalData.materialAppKey.currentContext!)!
            .connectedToLocationServerFailed(useCaBackend ? textCA : textRemote),
      );
    }
    return -1;
  }
}
