import 'package:famapp/core/utils/debug_utils.dart';
import 'package:famapp/core/utils/dot_env_manager.dart';
import 'package:flutter/material.dart';

import '../../../core/config.dart';
import '../../../core/global_data.dart';
import '../../../core/utils/common_utils.dart';
import '../../../core/widgets/innovay_text.dart';
import '../viewmodel/initialization_viewmodel.dart';
import 'login.dart';

class InitializationPage extends StatefulWidget {
  const InitializationPage({super.key});

  @override
  State<InitializationPage> createState() => _InitializationPageState();
}

class _InitializationPageState extends State<InitializationPage> {
  final InitializationViewmodel _viewmodel = InitializationViewmodel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      InnoConfig.colors.syncThemeColor(context);
      _appInitialization();
    });
  }

  void _appInitialization() async {
    await _viewmodel.appInitialization(
      onLoginRequired: _onLoginRequired,
      onTokenExpired: _onTokenExpired,
      onOfflineLoggedIn: _onUserOfflineLoggedIn,
      onBackendLoggedIn: _onUserBackendLoggedIn,
      allowOfflineLogin: true,
    );
  }

  void _onLoginRequired() {
    Navigator.pushAndRemoveUntil(
      InnoGlobalData.bottomNavigatorContext ?? context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }

  void _onTokenExpired() {
    DebugManager.warning("onTokenExpired");
    InnoGlobalData.switchLoadingOverlay(false);
    // SnackBarManager.displayMessage(AppLocalizations.of(context)!.reloginRequired);
    Navigator.pushAndRemoveUntil(
      InnoGlobalData.bottomNavigatorContext ?? context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }

  void _onUserOfflineLoggedIn() {
    if (mounted) {
      CommonUtils.navigateToHomeTab0AndClearHistory(context);
    }
  }

  void _onUserBackendLoggedIn() {
    if (mounted) {
      CommonUtils.navigateToHomeTab0AndClearHistory(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    InnoGlobalData.appViewPadding = MediaQuery.of(context).padding;
    return Scaffold(
      // appBar: InnovayAppStatusBar(context, false, overrideBackgroundColor: Colors.transparent),
      backgroundColor: InnoConfig.colors.colorF,
      extendBodyBehindAppBar: true,
      body: Stack(children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(36),
            child: Image.asset(
              'assets/icon/icon_512.png',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width * .5,
              height: MediaQuery.of(context).size.width * .5,
            ),
          ),
        ),
        Positioned(
          bottom: MediaQuery.of(context).padding.bottom + 20,
          left: 0,
          right: 0,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (Rect bounds) => InnoConfig.linearGradient.createShader(bounds),
              child: InnoText(
                DotEnvField.APP_NAME.getDotEnvString(''),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}
