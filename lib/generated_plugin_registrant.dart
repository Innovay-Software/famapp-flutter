//
// Generated file. Do not edit.
//

// ignore_for_file: directives_ordering
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_secure_storage_web/flutter_secure_storage_web.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:video_player_web/video_player_web.dart';

// ignore: public_member_api_docs
void registerPlugins(Registrar registrar) {
  FlutterSecureStorageWeb.registerWith(registrar);
  VideoPlayerPlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}
