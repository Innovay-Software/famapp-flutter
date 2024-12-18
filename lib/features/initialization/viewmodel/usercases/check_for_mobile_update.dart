import 'dart:io';

import 'package:famapp/core/global_data.dart';
import 'package:famapp/core/utils/api_utils.dart';
import 'package:famapp/features/initialization/viewmodel/datasources/initialization_remote_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/config.dart';
import '../../../../core/utils/common_utils.dart';
import '../../../../core/utils/snack_bar_manager.dart';
import '../../../../core/widgets/innovay_text.dart';

class CheckForMobileUpdate {
  Future<ApiResponse> call(BuildContext context) async {
    final remoteDatasource = InitializationRemoteDatasource();
    final response = await remoteDatasource.checkForUpdate(
      currentOS: Platform.operatingSystem.toLowerCase(),
      currentVersion: InnoGlobalData.packageInfo.version,
    );

    if (!response.successful) {
      return response;
    }

    final hasUpdate = response.data['hasUpdate'] ?? false;
    final forceUpdate = response.data['forceUpdate'] ?? false;
    final url = '${response.data['url']}';

    if (!hasUpdate) {
      return response;
    }

    if (!context.mounted) {
      return response;
    }

    CommonUtils.displayCustomDialog(
      context,
      '',
      [InnoText(AppLocalizations.of(context)!.updateAvailable)],
      forceUpdate ? null : Icon(Icons.cancel_outlined, color: InnoConfig.colors.textColorLight7),
      null,
      Icon(Icons.check_circle_outline, color: InnoConfig.colors.primaryColor),
      () {},
      () async {
        if (await canLaunchUrl(Uri.parse(url))) {
          launchUrl(Uri.parse(url));
        } else if (context.mounted) {
          return SnackBarManager.displayMessage(AppLocalizations.of(context)!.cannotOpenUrl);
        }
      },
      !forceUpdate,
    );

    return response;
  }
}
