import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/config.dart';
import '../../../core/utils/common_utils.dart';
import '../../../core/utils/snack_bar_manager.dart';
import '../../../core/views/app_bar.dart';
import '../../../core/widgets/buttons/background_button.dart';
import '../../../core/widgets/custom_ui_data_entry_bars.dart';
import '../../../core/widgets/innovay_text.dart';
import '../model/member_model.dart';
import '../viewmodel/members_viewmodel.dart';

class MemberDetailPage extends StatefulWidget {
  final String pageTitle;
  final Member member;

  const MemberDetailPage({
    super.key,
    required this.pageTitle,
    required this.member,
  });

  @override
  State<MemberDetailPage> createState() => _MemberDetailPageState();
}

class _MemberDetailPageState extends State<MemberDetailPage> {
  final MemberViewmodel _viewmodel = MemberViewmodel();
  final List<String> _roleOptions = ['admin', 'manager', 'member'];
  String _name = '';
  String _mobile = '';
  String _role = '';
  String _password = '';
  String _lockerPasscode = '';

  @override
  void initState() {
    super.initState();
    _name = widget.member.name;
    _mobile = widget.member.mobile;
    _role = widget.member.role;
    _lockerPasscode = widget.member.lockerPasscode;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InnoAppBar(false, widget.pageTitle, [
        InnovayBackgroundButton(
          '',
          InnoConfig.colors.deleteColor,
          _onDeleteTap,
          prefixWidget: const Icon(CupertinoIcons.delete_simple),
        ),
        InnovayBackgroundButton(
          '',
          InnoConfig.colors.successColor,
          _onSaveTap,
          prefixWidget: const Icon(CupertinoIcons.checkmark_alt),
        ),
      ]),
      body: SingleChildScrollView(
        child: Container(
          color: InnoConfig.colors.backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                onUserInput: (text) {
                  _mobile = text;
                },
              ),
              DataEntrySingleSelectBar(
                title: AppLocalizations.of(context)!.role,
                selectedValue: _role,
                selectOptions: _roleOptions,
                hasNeutralOption: false,
                onOptionSelected: (index) {
                  _role = _roleOptions[index];
                },
              ),
              DataEntryTextBar(
                title: AppLocalizations.of(context)!.loginPassword,
                currentUserInput: _password,
                onUserInput: (text) {
                  _password = text;
                },
              ),
              DataEntryTextBar(
                title: AppLocalizations.of(context)!.lockerPasscode,
                currentUserInput: _lockerPasscode,
                inputType: TextInputType.number,
                onUserInput: (text) {
                  _lockerPasscode = text;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onDeleteTap() {
    var member = widget.member;
    if (member.isAdmin()) {
      return SnackBarManager.displayMessage(AppLocalizations.of(context)!.deleteFailed);
    }
    CommonUtils.displayCustomDialog(
      context,
      AppLocalizations.of(context)!.deleteConfirmationTitle,
      [InnoText('${member.name} - ${member.mobile}')],
      const Icon(CupertinoIcons.xmark_circle),
      Icon(CupertinoIcons.delete, color: InnoConfig.colors.deleteColor),
      null,
      _onConfirmDeleteUser,
      () => null,
      true,
    );
  }

  void _onConfirmDeleteUser() async {
    var result = await _viewmodel.deleteMember(member: widget.member);
    if (mounted) {
      Navigator.pop(context, true);
    }
  }

  void _onSaveTap() async {
    if (_lockerPasscode.isNotEmpty && (int.tryParse(_lockerPasscode) == null || _lockerPasscode.length != 6)) {
      return SnackBarManager.displayMessage(AppLocalizations.of(context)!.passwordLocker);
    }

    var member = widget.member;
    member.name = _name;
    member.mobile = _mobile;
    member.role = _role;
    member.password = _password;
    member.lockerPasscode = _lockerPasscode;
    var success = await _viewmodel.saveMember(member: member);
    if (mounted && success) {
      Navigator.pop(context, true);
    }

    // InnovayGlobalData.switchLoadingOverlay(true);
    // member.syncToCloud(() {
    //   InnovayGlobalData.switchLoadingOverlay(false);
    //   Navigator.pop(context);
    // });
  }
}
