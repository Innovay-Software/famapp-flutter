import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../core/config.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../../../core/widgets/innovay_text.dart';
import '../../model/livechat_user.dart';

class ChatUserPicker extends StatefulWidget {
  final List<LivechatUserModel> availableUsers;
  final List<int> selectedUserIds;

  const ChatUserPicker({
    super.key,
    required this.availableUsers,
    required this.selectedUserIds,
  });

  @override
  State<ChatUserPicker> createState() => _ChatUserPickerState();
}

class _ChatUserPickerState extends State<ChatUserPicker> {
  final List<int> _selectedUserIds = [];
  @override
  void initState() {
    super.initState();
    _selectedUserIds.addAll(widget.selectedUserIds);
  }

  @override
  Widget build(BuildContext context) {
    var avatarSize = 44.0;
    return Container(
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
      color: InnoConfig.colors.backgroundColor,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .5,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...widget.availableUsers.map((e) => ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  title: Column(children: [
                    Row(children: [
                      InnoText(e.name),
                      const Spacer(),
                      if (_selectedUserIds.contains(e.id))
                        Icon(Icons.check_rounded, color: InnoConfig.colors.successColor),
                    ]),
                  ]),
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      width: avatarSize,
                      height: avatarSize,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: InnoConfig.colors.primaryColor,
                      ),
                      padding: const EdgeInsets.all(1),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: e.avatar.isEmpty
                              ? Center(
                                  child: InnoText(
                                  e.name[0],
                                  color: Colors.white,
                                  fontSize: max(18, avatarSize * 0.3),
                                ))
                              : InnovayCachedImage(
                                  e.avatar,
                                  width: avatarSize,
                                  height: avatarSize,
                                  errorText: e.name[0],
                                  errorTextSize: max(18, avatarSize * 0.3),
                                  errorBackgroundColor: InnoConfig.colors.primaryColor,
                                  errorForegroundColor: InnoConfig.colors.primaryColorTextColor,
                                )),
                    ),
                  ),
                  onTap: () {
                    _onUserTap(e.id);
                  },
                )),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  void _onUserTap(String id) {
    // DebugManager.log("_onUserTap ${id}");
    // if (_selectedUserIds.contains(id)) {
    //   _selectedUserIds.remove(id);
    // } else {
    //   _selectedUserIds.add(id);
    // }
    // setState(() {});
  }
}
