import 'dart:io';

import 'package:famapp/core/widgets/avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/config.dart';
import '../../../core/global_data.dart';
import '../../../core/models/inno_file_upload_item.dart';
import '../../../core/services/inno_secure_storage_service.dart';
import '../../../core/utils/common_utils.dart';
import '../../../core/utils/debug_utils.dart';
import '../../../core/utils/snack_bar_manager.dart';
import '../../../core/views/app_bar.dart';
import '../../../core/widgets/buttons/background_button.dart';
import '../../../core/widgets/buttons/bottom_picker_action_button_row.dart';
import '../../../core/widgets/innovay_text.dart';
import '../../../core/widgets/right_arrow.dart';
import '../../../enums/enums.dart';
import '../../cache_manager/view/cache_manager_page.dart';
import '../../locker/view/locker_home_page.dart';
import '../../members/view/member_list_page.dart';
import '../viewmodel/user_viewmodel.dart';
import 'used_accounts_page.dart';
import 'user_settings_page.dart';

class UserCenterPage extends StatefulWidget {
  const UserCenterPage({super.key});

  @override
  State<UserCenterPage> createState() => _UserCenterPageState();
}

class _UserCenterPageState extends State<UserCenterPage> with AutomaticKeepAliveClientMixin<UserCenterPage> {
  final UserViewmodel _viewmodel = UserViewmodel();
  InnoFileUploadItem? _currentFileUploadItem;

  @override
  void initState() {
    super.initState();
    // widget.setStateCallback(() {
    //   setState(() {});
    // });

    // DebugManager.log("_BottomTab3PageState.init");
    // CommonUtils.setDarkStatusText(backgroundColor: Colors.red);
  }

  @override
  void dispose() {
    DebugManager.log("_UserCenterPageState.dispose");
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var user = context.watch<UserViewmodel>().currentUser;
    var packageInfo = InnoGlobalData.packageInfo;
    colorLerp(degree) => Color.lerp(const Color(0xFFC850C0), const Color(0xFF4158D0), degree) ?? Colors.white;

    DebugManager.log("aaaavatar = ${user.avatarUrl}");
    List<Map> links = [
      {
        'title': AppLocalizations.of(context)!.locker,
        'subtitle': AppLocalizations.of(context)!.notes.toLowerCase(),
        'icon': CupertinoIcons.doc_chart,
        'marginTop': 20,
        'onTap': _onLockerTap,
        'color': colorLerp(0.0 / 5.0),
      },
      {
        'title': AppLocalizations.of(context)!.members,
        'subtitle': AppLocalizations.of(context)!.adminOnly.toLowerCase(),
        'icon': CupertinoIcons.lock_shield,
        'marginTop': 1,
        'onTap': _onManagerUsersTap,
        'requiresAdmin': true,
        'color': colorLerp(0.0 / 6.0),
      },
      {
        'title': AppLocalizations.of(context)!.settings,
        'subtitle': AppLocalizations.of(context)!.namePasswordEtc.toLowerCase(),
        'icon': CupertinoIcons.profile_circled,
        'marginTop': 1,
        'onTap': _onUserSettingsTap,
        'color': colorLerp(1.0 / 6.0),
      },
      {
        'title': AppLocalizations.of(context)!.accounts,
        'subtitle': AppLocalizations.of(context)!.switchAccounts.toLowerCase(),
        'icon': Icons.supervised_user_circle_outlined,
        'marginTop': 1,
        'onTap': _onSwitchUserTap,
        'color': colorLerp(3.0 / 6.0),
      },
      {
        'title': AppLocalizations.of(context)!.cache,
        'subtitle': AppLocalizations.of(context)!.clearAllCache.toLowerCase(),
        'icon': Icons.cached_rounded,
        'marginTop': 1,
        'onTap': _onClearCacheTap,
        'color': colorLerp(4.0 / 6.0),
      },
      {
        'title': AppLocalizations.of(context)!.updates,
        'subtitle': '${packageInfo.version}.${packageInfo.buildNumber}',
        'icon': Icons.update_rounded,
        'marginTop': 1,
        'onTap': _onVersionTap,
        'color': colorLerp(5.0 / 6.0),
      },
      {
        'title': AppLocalizations.of(context)!.serviceLocation,
        'subIcon': InnoGlobalData.useRegionRemote
            ? Image.asset("assets/ui/CNIcon1.jpg", width: 30, height: 30)
            : Image.asset("assets/ui/CAIcon1.jpg", width: 30, height: 30),
        'icon': Icons.dns_outlined,
        'marginTop': 1,
        'marginBottom': 150,
        'onTap': _onPreferredLocationTap,
        'color': colorLerp(6.0 / 6.0),
      },
    ];

    return Scaffold(
      appBar: InnoAppBar(
        false,
        '',
        [
          InnovayBackgroundButton(
            '',
            InnoConfig.colors.deleteColor,
            _onLogoutTap,
            prefixWidget: const Icon(Icons.logout_outlined),
          )
        ],
        showLeading: false,
      ),
      backgroundColor: InnoConfig.colors.backgroundColorTinted3,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image.network(
          //   'https://drive.google.com/uc?export=view&id=1VdjEgb0aZl9IZa2jOzGU5_SNbmlmeiCj',
          //   width: 100,
          //   height: 100,
          // ),
          // InnoText(AppLocalizations.of(context)!.helloWorld),
          Container(
            padding: const EdgeInsets.only(bottom: 15),
            color: InnoConfig.colors.backgroundColor,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // InnovayPrimaryButton('Print Cache Status', () {
                //   CacheService.printCacheStatus();
                // }),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () {
                    _viewmodel.updateUserAvatar((uploadItem) {
                      _currentFileUploadItem = uploadItem;
                      if (uploadItem != null && uploadItem.isUploaded && uploadItem.remoteUrl.isNotEmpty) {
                        user.avatarUrl = uploadItem.remoteUrl;
                      }
                      setState(() {});
                    });
                  },
                  child: Stack(
                    children: [
                      InnoAvatar(
                        url: user.avatarUrl,
                        size: 80,
                        borderRadius: 100,
                        username: user.name,
                        clearCache: true,
                      ),
                      if (_currentFileUploadItem != null)
                        Stack(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.black.withOpacity(0.4),
                                image: DecorationImage(
                                  image: FileImage(File(_currentFileUploadItem!.localPath)),
                                  // colorFilter: const ColorFilter.mode(
                                  //   Colors.black,
                                  //   BlendMode.saturation,
                                  // ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Center(
                                child: CircularProgressIndicator(
                                  value: _currentFileUploadItem!.uploadProgress / 100.0,
                                  backgroundColor: Colors.black.withOpacity(0.1),
                                  color: Colors.white,
                                  semanticsLabel: '123',
                                  semanticsValue: '123',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 80,
                              height: 80,
                              child: Center(
                                child: InnoText(
                                  '${_currentFileUploadItem!.uploadProgress}%',
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      const Positioned(
                        bottom: 5,
                        right: 5,
                        child: Icon(CupertinoIcons.camera_fill, color: Color(0xFFC850C0), size: 16),
                      ),
                      const Positioned(
                        bottom: 5,
                        right: 5,
                        child: Icon(CupertinoIcons.camera_fill, color: Color(0xDDFFCC70), size: 15),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                InnoText(
                  user.name,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: InnoConfig.colors.textColor,
                ),
                const SizedBox(height: 5),
                InnoText(
                  user.mobile,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: InnoConfig.colors.textColorLight7,
                ),
                // InnoText(
                //   user.avatarUrl.split('/').last,
                //   fontSize: 12,
                //   fontWeight: FontWeight.bold,
                //   color: InnoConfig.colors.textColorLight7,
                // ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: links.map((item) {
                  if (item['requiresAdmin'] == true) {
                    if (!user.isAdmin()) {
                      return const SizedBox.shrink();
                    }
                  }
                  // return CalendarDatePicker(
                  //   initialDate: DateTime.now(),
                  //   firstDate: DateTime(1900),
                  //   lastDate: DateTime(2100),
                  //   onDateChanged: (value) {},
                  // );
                  return GestureDetector(
                    onTap: item['onTap'],
                    child: Container(
                      margin: EdgeInsets.only(
                          top: item['marginTop'] * 1.0 ?? 0.0, bottom: (item['marginBottom'] ?? 0.0) * 1.0),
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      decoration: BoxDecoration(
                        // border: Border(bottom: BorderSide(color: InnovayConfig.colors.dividerLineColor)),
                        color: InnoConfig.colors.backgroundColor,
                      ),
                      child: Row(
                        children: [
                          Icon(item['icon'], color: item['color']),
                          const SizedBox(width: 20),
                          InnoText(item['title'], fontSize: 14),
                          const SizedBox(width: 20),
                          item['subtitle'] == null
                              ? const Spacer()
                              : Expanded(
                                  child: InnoText(
                                    item['subtitle'],
                                    color: InnoConfig.colors.textColorLight7,
                                    fontSize: 12,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                          if (item['subIcon'] != null) item['subIcon'],
                          if (item['onTap'] != null) const InnovayRightArrow()
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onLogoutTap() async {
    CommonUtils.displayCustomDialog(
      context,
      AppLocalizations.of(context)!.logoutConfirmationTitle,
      [],
      const Icon(CupertinoIcons.xmark_circle),
      Icon(Icons.logout_outlined, color: InnoConfig.colors.deleteColor),
      null,
      () {
        _viewmodel.logout();
      },
      () => null,
      true,
    );
  }

  void _onLockerTap() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LockerHomePage(
          setStateCallback: (Function() setStateCallback) {},
        ),
      ),
    );
  }

  void _onManagerUsersTap() async {
    if (!_viewmodel.currentUser.isAdmin()) {
      return SnackBarManager.displayPermissionDeniedMessage();
    }
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MemberListPage()),
    );
  }

  void _onUserSettingsTap() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UserSettingsPage()),
    );
  }

  void _onSwitchUserTap() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UsedAccountsPage()),
    );
  }

  void _onClearCacheTap() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CacheManagerPage()),
    );
  }

  void _onVersionTap() {
    CommonUtils.checkForNewVersion(context, AppLocalizations.of(context)!.noNewVersion);
  }

  void _onPreferredLocationTap() {
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
          () {
            Navigator.pop(context);
            var oldUseRemoteServerValue = InnoGlobalData.useRegionRemote;
            InnoSecureStorageService().setStaticStorageValue(
              InnoSecureStorageKeys.preferredBackendServer,
              e.toShortString(),
            );
            InnoGlobalData.updateUseRemoteServerValue();
            setState(() {});
            SnackBarManager.displayMessage(AppLocalizations.of(context)!.settingsUpdated);
            if (oldUseRemoteServerValue == InnoGlobalData.useRegionRemote) {
              // setState(() {});
            } else {
              Navigator.pushNamedAndRemoveUntil(context, '/InitializationScreen', (r) => false);
              return;
            }
          },
          prefixWidget: ClipRRect(borderRadius: BorderRadius.circular(30), child: icon),
        );
      }).toList(),
    );
  }
}
