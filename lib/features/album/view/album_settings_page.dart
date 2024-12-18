import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/config.dart';
import '../../../core/global_data.dart';
import '../../../core/utils/common_utils.dart';
import '../../../core/utils/datetime_util.dart';
import '../../../core/utils/debug_utils.dart';
import '../../../core/utils/snack_bar_manager.dart';
import '../../../core/views/app_bar.dart';
import '../../../core/widgets/avatar.dart';
import '../../../core/widgets/custom_ui_data_entry_bars.dart';
import '../../../core/widgets/innovay_text.dart';
import '../../members/model/member_model.dart';
import '../../members/viewmodel/members_viewmodel.dart';
import '../../settings/viewmodel/user_viewmodel.dart';
import '../model/album.dart';
import '../viewmodel/album_viewmodel.dart';
import '../viewmodel/enums/album_type.dart';

class AlbumSettingsPage extends StatefulWidget {
  final Album album;
  const AlbumSettingsPage({super.key, required this.album});

  @override
  State<AlbumSettingsPage> createState() => _AlbumSettingsPageState();
}

class _AlbumSettingsPageState extends State<AlbumSettingsPage> {
  final UserViewmodel _userViewmodel = UserViewmodel();
  final AlbumViewmodel _albumViewmodel = AlbumViewmodel();
  final List<Member> _potentialInvitees = [];
  final List<int> _selectedInviteeIds = [];

  @override
  void initState() {
    super.initState();
    _selectedInviteeIds.clear();
    _selectedInviteeIds.addAll(widget.album.inviteeIds);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getInvitees();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getInvitees() async {
    var memberViewmodel = MemberViewmodel();
    if (memberViewmodel.members.isEmpty) {
      await memberViewmodel.listMembers();
    }
    _potentialInvitees.clear();
    _potentialInvitees.addAll(MemberViewmodel().members);
    setState(() {});
  }

  List<Widget> _getAlbumTypeSpecialWidgets() {
    if (widget.album.albumType == AlbumType.baby) {
      var currentDate = widget.album.metadata['birthDate'] == null
          ? DateTime.now()
          : DateTime.parse(widget.album.metadata['birthDate']);
      return [
        DataEntryTextBar(
          title: AppLocalizations.of(context)!.babyNickName,
          currentUserInput: widget.album.metadata['name'] ?? '',
          onUserInput: (text) {
            widget.album.metadata['name'] = text;
          },
        ),
        DataEntryDateBar(
          title: AppLocalizations.of(context)!.birthdate,
          currentDate: currentDate,
          onConfirm: (newDate) {
            widget.album.metadata['birthDate'] = DatetimeUtils.formattedDate(newDate);
          },
        ),
      ];
    }
    return [];
  }

  Widget _buildInviteeRow(Member member) {
    if (member.id == _userViewmodel.currentUser.id) {
      return const SizedBox.shrink();
    }
    return Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        margin: const EdgeInsets.only(top: 1),
        child: Row(
          children: [
            InnoAvatarUserId(member.id, size: 40, userName: member.name, clearCache: true),
            // CircleAvatar(
            //     radius: 20,
            //     backgroundImage: inviteeModel.avatar.isEmpty ? null : NetworkImage(inviteeModel.avatar),
            //     child: inviteeModel.avatar.isEmpty
            //         ? Center(child: InnovayText(inviteeModel.name.split('')[0], color: Colors.white))
            //         : null),
            const SizedBox(width: 10),
            InnoText(member.name),
            const Spacer(),
            GestureDetector(
                onTap: () {
                  if (_selectedInviteeIds.contains(member.id)) {
                    _selectedInviteeIds.remove(member.id);
                  } else {
                    _selectedInviteeIds.add(member.id);
                  }
                  setState(() {});
                },
                child: _selectedInviteeIds.contains(member.id)
                    ? Icon(Icons.check_circle, size: 30, color: InnoConfig.colors.primaryColor)
                    : Icon(Icons.circle_outlined, size: 30, color: InnoConfig.colors.primaryColorLighter))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> albumTypeOptions = [];
    final List<String> albumTypeTranslatedStrings = [];
    for (var element in AlbumType.values) {
      albumTypeOptions.add({'value': element, 'title': element.toTranslatedString(context)});
      albumTypeTranslatedStrings.add(element.toTranslatedString(context));
    }

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.light,
      // For iOS.
      // Use [dark] for white status bar and [light] for black status bar.
      statusBarBrightness: Brightness.dark,
    ));

    return Scaffold(
      appBar: InnoAppBar(false, AppLocalizations.of(context)!.settings, [
        IconButton(
          onPressed: _onDeleteTap,
          icon: const Icon(CupertinoIcons.delete_simple, size: 24),
          color: InnoConfig.colors.deleteColor,
        ),
        IconButton(
          onPressed: _onSaveTap,
          icon: const Icon(CupertinoIcons.checkmark_alt),
          color: InnoConfig.colors.primaryColor,
        )
      ]),
      backgroundColor: InnoConfig.colors.backgroundColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              DataEntryTextBar(
                  title: AppLocalizations.of(context)!.title,
                  currentUserInput: widget.album.title,
                  onUserInput: (content) {
                    widget.album.title = content;
                  }),
              DataEntrySingleImageUploadBar(
                  title: AppLocalizations.of(context)!.coverImage,
                  imageUrl: widget.album.cover,
                  onImageUpdated: (url) {
                    widget.album.cover = url;
                  }),
              DataEntrySwitchBar(
                title: AppLocalizations.of(context)!.viewerUpload,
                value: widget.album.inviteePost,
                onValueChanged: (value) {
                  widget.album.inviteePost = value;
                  setState(() {});
                },
                color: InnoConfig.colors.primaryColor,
              ),
              DataEntrySingleSelectBar(
                  hasNeutralOption: false,
                  title: AppLocalizations.of(context)!.albumType,
                  selectedValue: widget.album.albumType.toTranslatedString(context),
                  selectOptions: albumTypeTranslatedStrings,
                  onOptionSelected: (selectedIndex) {
                    widget.album.albumType = albumTypeOptions[selectedIndex]['value'];
                    setState(() {});
                  }),
              ..._getAlbumTypeSpecialWidgets(),
              const SizedBox(height: 20),
              InnoText(AppLocalizations.of(context)!.invitees, fontWeight: FontWeight.bold),
              const SizedBox(height: 20),
              ...(_potentialInvitees.map((invitee) {
                if (invitee.id == widget.album.ownerId) {
                  return const SizedBox.shrink();
                }
                return _buildInviteeRow(invitee);
              }).toList())
            ]),
          ),
        ),
      ),
    );
  }

  void _onSaveTap() async {
    if (widget.album.title.isEmpty) {
      SnackBarManager.displayMessage(
        AppLocalizations.of(context)!.itemCantBeEmpty(AppLocalizations.of(context)!.title),
      );
      return;
    }

    final beforeAlbumId = widget.album.id;
    widget.album.inviteeIds = _selectedInviteeIds;
    final isSuccessful = await _albumViewmodel.saveAlbum(widget.album);
    if (!isSuccessful) {
      return;
    }

    if (beforeAlbumId == 0) {
      _albumViewmodel.albums.add(widget.album);
    }
    DebugManager.log(widget.album.rawData.toString());
    if (mounted) {
      Navigator.pop(context);
    }
  }

  void _onDeleteTap() {
    CommonUtils.displayCustomDialog(
      context,
      AppLocalizations.of(context)!.deleteConfirmationTitle,
      [],
      const Icon(Icons.cancel_outlined),
      const Icon(CupertinoIcons.delete),
      null,
      () async {
        InnoGlobalData.switchLoadingOverlay(true);
        final isSuccessful = await _albumViewmodel.deleteAlbum(widget.album);
        InnoGlobalData.switchLoadingOverlay(false);
        if (isSuccessful && mounted) {
          Navigator.pop(context);
        }
      },
      () => null,
      true,
    );
  }
}
