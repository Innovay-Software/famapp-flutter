import 'dart:math';

import 'package:famapp/core/utils/dot_env_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:local_auth/local_auth.dart';

import '../../../core/config.dart';
import '../../../core/global_data.dart';
import '../../../core/services/inno_secure_storage_service.dart';
import '../../../core/utils/common_utils.dart';
import '../../../core/utils/debug_utils.dart';
import '../../../core/utils/snack_bar_manager.dart';
import '../../../core/views/app_status_bar.dart';
import '../../../core/widgets/buttons/background_button.dart';
import '../../../core/widgets/buttons/bottom_picker_action_button_row.dart';
import '../../../core/widgets/custom_ui_text_fields.dart';
import '../../../core/widgets/innovay_text.dart';
import '../../../enums/enums.dart';
import '../../settings/viewmodel/user_viewmodel.dart';
import 'widgets/login_background_section.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final bool _useLocalAuthentication = false;
  final LocalAuthentication _localAuth = LocalAuthentication();
  final TextEditingController _passwordController = TextEditingController();
  String _mobile = '';
  bool _obscurePassword = true;
  BackendServerType _backendServerType = BackendServerType.regionClosest;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getBackendServerType();
    });
  }

  void _getBackendServerType() async {
    _backendServerType = BackendServerType.values.firstWhere(
      (e) =>
          e.toShortString() ==
          InnoSecureStorageService().getStaticStorageValue(
            InnoSecureStorageKeys.preferredBackendServer,
          ),
      orElse: () => BackendServerType.regionClosest,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    InnoGlobalData.appViewPadding = MediaQuery.of(context).padding;
    final iconSize = min(MediaQuery.of(context).size.width * 0.06, MediaQuery.of(context).size.height * 0.06);

    return Scaffold(
      appBar: InnoAppStatusBar(context, false, overrideBackgroundColor: Colors.transparent),
      backgroundColor: InnoConfig.colors.backgroundColor,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              Image.asset(
                'assets/aurora/aurora_g3.png',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.33,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
                child: CustomPaint(
                  painter: LoginBackgroundSectionPainter(),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.13 + 1,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2 + 60, bottom: 10, left: 30),
                child: Column(children: [
                  ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) => InnoConfig.linearGradient.createShader(bounds),
                    child: InnoText(
                      DotEnvField.APP_NAME.getDotEnvString(''),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      gradient: InnoConfig.linearGradient,
                    ),
                    width: 50,
                    height: 3,
                  ),
                ]),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              InnovayBackgroundButton(
                '',
                InnoConfig.colors.textColor,
                _onServerButtonTap,
                fontSize: 14,
                prefixWidget: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: _backendServerType == BackendServerType.regionRemote
                      ? Image.asset("assets/ui/CNIcon1.jpg", width: 40, height: 40)
                      : (_backendServerType == BackendServerType.regionCA
                          ? Image.asset("assets/ui/CAIcon1.jpg", width: 40, height: 40)
                          : const Icon(Icons.location_on_rounded, color: Color(0xFF4158D0), size: 40)),
                ),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: CustomTextFieldWidget(
                initialValue: _mobile,
                onChange: (text) {
                  _mobile = text;
                },
                hintText: AppLocalizations.of(context)!.mobile,
                fontSize: 18,
                textInputType: TextInputType.number,
                backgroundColor: Colors.white,
                textFieldStyle: 'underline',
                textAlign: TextAlign.left,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) => InnoConfig.linearGradient.createShader(bounds),
                    child: Icon(Icons.phone_iphone, color: InnoConfig.colors.primaryColor, size: iconSize),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: CustomTextFieldWidget(
                obscureText: _obscurePassword,
                onChange: (text) {},
                hintText: '******',
                fontSize: 18,
                textInputType: TextInputType.visiblePassword,
                textEditingController: _passwordController,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) => InnoConfig.linearGradient.createShader(bounds),
                    child: Icon(Icons.lock, color: InnoConfig.colors.primaryColor, size: iconSize),
                  ),
                ),
                postfixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (Rect bounds) => InnoConfig.linearGradient.createShader(bounds),
                      child: Icon(
                        _obscurePassword ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye_fill,
                        size: iconSize,
                      ),
                    ),
                  ),
                ),
                backgroundColor: Colors.white,
                textFieldStyle: 'underline',
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 10),
            Row(children: [
              const SizedBox(width: 40),
              InnoText(
                '${AppLocalizations.of(context)!.initialPassword}: 123456',
                color: InnoConfig.colors.textColorLight7,
                fontSize: 12,
              ),
            ]),
            const SizedBox(height: 40),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              InnovayBackgroundButton(
                '',
                InnoConfig.colors.backgroundColor,
                _onLoginTap,
                backgroundColor: InnoConfig.colors.backgroundColorTinted,
                prefixWidget: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (Rect bounds) => InnoConfig.linearGradient.createShader(bounds),
                  child: const Icon(Icons.login, color: Colors.white),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  void _onServerButtonTap() {
    CommonUtils.displayBottomPicker(
      context,
      '',
      BackendServerType.values.map((e) {
        Widget icon = const Icon(Icons.location_on_rounded, color: Color(0xFF4158D0), size: 30);
        if (e == BackendServerType.regionRemote) {
          icon = Image.asset("assets/ui/CNIcon1.jpg", width: 30, height: 30);
        } else if (e == BackendServerType.regionCA) {
          icon = Image.asset("assets/ui/CAIcon1.jpg", width: 30, height: 30);
        }
        return InnovayBottomPickerActionButtonRow(
          '',
          InnoConfig.colors.textColor,
          () async {
            Navigator.pop(context);
            _backendServerType = e;
            InnoSecureStorageService().setStaticStorageValue(
              InnoSecureStorageKeys.preferredBackendServer,
              e.toShortString(),
            );
            InnoGlobalData.updateUseRemoteServerValue();
            setState(() {});
          },
          prefixWidget: ClipRRect(borderRadius: BorderRadius.circular(30), child: icon),
        );
      }).toList(),
    );
  }

  void _navigateToHomePage() {
    CommonUtils.navigateToHomeTab0AndClearHistory(context);
  }

  void _onLoginTap() async {
    if (_mobile.isEmpty || _passwordController.text.isEmpty) {
      return SnackBarManager.displayMessage(AppLocalizations.of(context)!.mobileAndPasswordAreRequired);
    }

    if (_useLocalAuthentication) {
      // Use local authentication (device passcode)
      bool authenticated = await _authenticate();
      if (!authenticated) {
        SnackBarManager.displayMessage('Authentication failed. Please try again.');
        return;
      }
    }

    final viewmodel = UserViewmodel();
    final response = await viewmodel.login(_mobile, _passwordController.text);
    if (response) {
      _navigateToHomePage();
    }
  }

  Future<bool> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to log in',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
        ),
      );
    } on PlatformException catch (e) {
      DebugManager.log("Local Authentication failed: $e");
    }
    return authenticated;
  }
}
