import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/config.dart';
import '../../../core/global_data.dart';
import '../../../core/utils/common_utils.dart';
import '../../../core/views/app_bar.dart';
import '../../../core/widgets/innovay_text.dart';
import '../../../features/locker/viewmodel/locker_viewmodel.dart';
import '../../../features/members/model/member_model.dart';
import '../../../features/members/viewmodel/members_viewmodel.dart';
import '../../members/view/widgets/member_selection_panel.dart';
import '../model/locker_note_model.dart';

class LockerNoteSettingsPage extends StatefulWidget {
  final LockerNote lockerNote;
  const LockerNoteSettingsPage({super.key, required this.lockerNote});

  @override
  State<LockerNoteSettingsPage> createState() => _LockerNoteSettingsPageState();
}

class _LockerNoteSettingsPageState extends State<LockerNoteSettingsPage> {
  final LockerViewmodel _viewmodel = LockerViewmodel();
  final List<Member> _potentialInvitees = [];
  final List<int> _selectedInviteeIds = [];

  @override
  void initState() {
    super.initState();
    _potentialInvitees.clear();
    _potentialInvitees.addAll(MemberViewmodel().members);
    _selectedInviteeIds.clear();
    for (var item in widget.lockerNote.invitees) {
      _selectedInviteeIds.add(item['id']);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onDeleteTap() {
    CommonUtils.displayCustomDialog(
      context,
      AppLocalizations.of(context)!.deleteConfirmationTitle,
      [InnoText(AppLocalizations.of(context)!.deleteWontRecover, fontSize: 12)],
      const Icon(CupertinoIcons.xmark_circle),
      Icon(CupertinoIcons.delete, color: InnoConfig.colors.deleteColor),
      null,
      _onDeleteConfirmed,
      () => null,
      true,
    );
  }

  void _onDeleteConfirmed() async {
    InnoGlobalData.switchLoadingOverlay(true);
    final response = await _viewmodel.deleteLockerNote(lockerNote: widget.lockerNote);
    InnoGlobalData.switchLoadingOverlay(false);
    if (response && mounted) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.light,
      // For iOS.
      // Use [dark] for white status bar and [light] for black status bar.
      statusBarBrightness: Brightness.dark,
    ));

    return Scaffold(
      appBar: InnoAppBar(
        false,
        AppLocalizations.of(context)!.settings,
        [
          IconButton(
            onPressed: _onDeleteTap,
            icon: const Icon(CupertinoIcons.delete),
            color: InnoConfig.colors.deleteColor,
          ),
          IconButton(
            onPressed: _onSaveTap,
            icon: const Icon(CupertinoIcons.checkmark_alt),
            color: InnoConfig.colors.primaryColor,
          )
        ],
        leadingWidget: const Icon(CupertinoIcons.xmark),
      ),
      backgroundColor: InnoConfig.colors.backgroundColor,
      body: SafeArea(
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: MemberSelectionPanel(
              title: AppLocalizations.of(context)!.visibleByNumPeople(_selectedInviteeIds.length),
              selectedIds: _selectedInviteeIds,
              onSelectionUpdated: (selectedIds) {
                _selectedInviteeIds.clear();
                _selectedInviteeIds.addAll(selectedIds);
                setState(() {});
              },
            ),
          ),
        ]),
      ),
    );
  }

  void _onSaveTap() async {
    var newInvitees = <Map<String, dynamic>>[];
    for (var id in _selectedInviteeIds) {
      newInvitees.add({'id': id, 'name': ''});
    }
    widget.lockerNote.invitees = newInvitees;
    var success = await _viewmodel.saveLockerNote(lockerNote: widget.lockerNote);
    if (mounted && success) {
      Navigator.pop(context, false);
    }
  }
}
