import 'dart:io';

import 'package:dart_ping_ios/dart_ping_ios.dart';
import 'package:famapp/core/overlays/inno_debug_overlay.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import 'core/config.dart';
import 'core/global_data.dart';
import 'core/inno_init_service.dart';
import 'core/overlays/inno_loading_overlay.dart';
import 'core/overlays/inno_snackbar_overlay.dart';
import 'core/routes/routes.dart';
import 'core/services/inno_local_database_service.dart';
import 'core/services/user_notification_service.dart';
import 'core/utils/dot_env_manager.dart';
import 'core/widgets/download_button_overlay.dart';
import 'features/album/viewmodel/album_viewmodel.dart';
import 'features/cache_manager/viewmodel/cache_manager_viewmodel.dart';
import 'features/initialization/view/initialization.dart';
import 'features/livechat/viewmodel/livechat_viewmodel.dart';
import 'features/locker/viewmodel/locker_viewmodel.dart';
import 'features/members/viewmodel/members_viewmodel.dart';
import 'features/settings/viewmodel/used_account_viewmodel.dart';
import 'features/settings/viewmodel/user_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///
  /// Load .env file
  ///
  await DotEnvManager.loadDotEnv([".env"]);

  ///
  /// InnoService initialization
  ///
  await InnoInitService.appInitialization();

  ///
  /// UserNotificationService Init
  ///
  UserNotificationService();

  ///
  /// Plugin1 Initialization: FlutterDownloader
  ///
  // await FlutterDownloader.initialize(
  //   debug: kDebugMode, // optional: set to false to disable printing logs to console (default: true)
  //   ignoreSsl: true, // option: set to false to disable working with http links (default: false)
  // );

  ///
  /// Plugin2 Initialization: DartPingIOS
  ///
  DartPingIOS.register();

  ///
  /// Plugin4 Initialization: PackageInfo
  ///
  InnoGlobalData.packageInfo = await PackageInfo.fromPlatform();

  ///
  /// Plugin5 Initialization: HttpOverride
  ///
  HttpOverrides.global = InnoHttpOverrides();

  ///
  /// Start app
  ///
  ///
  runApp(const Famapp());
}

class Famapp extends StatefulWidget {
  const Famapp({super.key});

  @override
  State<Famapp> createState() => _FamappState();
}

class _FamappState extends State<Famapp> {
  @override
  void initState() {
    super.initState();
    UserViewmodel.mainContext = context;
  }

  @override
  void dispose() async {
    await InnoLocalDatabaseService.instance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AlbumViewmodel()),
        ChangeNotifierProvider(create: (context) => CacheManagerViewmodel()),
        // ChangeNotifierProvider(create: (context) => ImViewmodel()),
        // ChangeNotifierProvider(create: (context) => ImGroupViewmodel()),
        ChangeNotifierProvider(create: (context) => LivechatViewmodel()),
        ChangeNotifierProvider(create: (context) => LockerViewmodel()),
        ChangeNotifierProvider(create: (context) => MemberViewmodel()),
        ChangeNotifierProvider(create: (context) => UsedAccountViewmodel()),
        ChangeNotifierProvider(create: (context) => UserViewmodel()),
      ],
      child: MaterialApp(
        navigatorKey: InnoGlobalData.materialAppKey,
        title: DotEnvField.APP_NAME.getDotEnvString('Famlinno'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: const [
          Locale('en'), // Using en as the default language
          Locale('zh'),
        ],
        // localeResolutionCallback: (locale, supportedLocales) {
        //   return Locale('en');
        // },
        showPerformanceOverlay: false,
        showSemanticsDebugger: false,
        theme: ThemeData(primarySwatch: Colors.indigo),
        routes: AppRoutes.getRoutes(),
        home: const InitializationPage(),
        builder: (context, child) {
          return Scaffold(
            body: Stack(
              children: [
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: DefaultTextStyle(
                      style: TextStyle(fontSize: 14, color: InnoConfig.colors.textColor),
                      child: Stack(children: [
                        if (child != null) child,
                        // const WsOverlay(),
                        const DownloadButtonOverlay(),
                        const InnoLoadingOverlay(),
                        const InnoSnackBarOverlay(),
                        if (kDebugMode) const InnoDebugOverlay(),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class InnoHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    // For testing purposes, ignore certificate verifications
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
