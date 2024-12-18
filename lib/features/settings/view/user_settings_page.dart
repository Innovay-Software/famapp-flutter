import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/config.dart';
import '../../../core/views/app_bar.dart';
import '../../../core/widgets/buttons/background_button.dart';
import '../../../core/widgets/custom_ui_data_entry_bars.dart';
import '../viewmodel/user_viewmodel.dart';

class UserSettingsPage extends StatefulWidget {
  const UserSettingsPage({super.key});

  @override
  State<UserSettingsPage> createState() => _UserSettingsPageState();
}

class _UserSettingsPageState extends State<UserSettingsPage> with AutomaticKeepAliveClientMixin<UserSettingsPage> {
  final UserViewmodel _viewmodel = UserViewmodel();
  String _name = '';
  String _mobile = '';
  String _password = '';
  String _password2 = '';
  String _iLockerPasscode = '';

  @override
  void initState() {
    super.initState();
    _name = _viewmodel.currentUser.name;
    _mobile = _viewmodel.currentUser.mobile;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: InnoConfig.colors.backgroundColorTinted3,
      appBar: InnoAppBar(false, AppLocalizations.of(context)!.settings, [
        InnovayBackgroundButton(
          '',
          InnoConfig.colors.primaryColor,
          _onSaveTap,
          prefixWidget: const Icon(Icons.check),
        ),
      ]),
      body: SingleChildScrollView(
        child: Container(
          color: InnoConfig.colors.backgroundColor,
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              DataEntryTextBar(
                title: AppLocalizations.of(context)!.name,
                currentUserInput: _name,
                onUserInput: (text) {
                  _name = text;
                },
              ),
              DataEntryTextBar(
                title: AppLocalizations.of(context)!.mobile,
                currentUserInput: _mobile,
                inputType: TextInputType.number,
                onUserInput: (text) {
                  _mobile = text;
                },
              ),
              DataEntryTextBar(
                title: AppLocalizations.of(context)!.loginPassword,
                currentUserInput: '',
                onUserInput: (text) {
                  _password = text;
                },
              ),
              DataEntryTextBar(
                title: '',
                hintText:
                    '${AppLocalizations.of(context)!.pleaseEnterSecond}${AppLocalizations.of(context)!.loginPassword}',
                currentUserInput: '',
                onUserInput: (text) {
                  _password2 = text;
                },
              ),
              DataEntryTextBar(
                title: AppLocalizations.of(context)!.lockerPasscode,
                currentUserInput: '',
                onUserInput: (text) {
                  _iLockerPasscode = text;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSaveTap() async {
    // if (_password.isNotEmpty || _password2.isNotEmpty) {
    //   if (_password.length < 4) {
    //     return SnackBarManager.displayMessage(AppLocalizations.of(context)!.passwordTooShort);
    //   }
    //   if (_password != _password2) {
    //     return SnackBarManager.displayMessage(AppLocalizations.of(context)!.passwordsDoNotMatch);
    //   }
    // }
    //
    // if (_iLockerPasscode.isNotEmpty) {
    //   if (int.tryParse(_iLockerPasscode) == null) {
    //     return SnackBarManager.displayMessage(AppLocalizations.of(context)!.passwordLocker);
    //   }
    //   if (_iLockerPasscode.length != 6) {
    //     return SnackBarManager.displayMessage(AppLocalizations.of(context)!.passwordLocker);
    //   }
    // }

    final result = await _viewmodel.updateUserProfile(
      name: _name,
      mobile: _mobile,
      password: _password,
      lockerPasscode: _iLockerPasscode,
    );

    if (result && mounted) {
      Navigator.pop(context);
    }
  }
}
