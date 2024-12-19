import 'package:famapp/core/utils/dot_env_manager.dart';
import 'package:flutter/material.dart';

import './networks/user_notifications_network_config.dart';
import 'color_theme.dart';

class InnoConfig {
  static UserNotificationNetworkConfig userNotificationNetworkConfig = UserNotificationNetworkConfig(
    DotEnvField.DOMAIN_CA.getDotEnvString(''),
    DotEnvField.DOMAIN_REMOTE.getDotEnvString(''),
    DotEnvField.API_VERSION.getDotEnvString('v1'),
  );

  static final InnoColorTheme colors = InnoColorTheme();
  static const int homeInitialTabIndex = 0;
  static const int chunkUploadSizeInMb = 5;
  static const List<Color> colorGradient = [Color(0xFF4158D0), Color(0xFFC850C0), Color(0xFFFFCC70)];
  static const LinearGradient linearGradient = LinearGradient(
    // center: Alignment.topCenter,
    begin: Alignment(-1, 1),
    end: Alignment(1, -1),
    stops: [.1, .5, 1],
    colors: colorGradient,
  );
}
