import 'dart:math';

import 'package:famapp/features/livechat/viewmodel/livechat_viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../core/config.dart';
import '../../../../core/widgets/avatar.dart';
import '../../../../core/widgets/innovay_text.dart';
import '../../../../core/widgets/member_avatars.dart';
import '../../../../core/widgets/notification_badge_widget.dart';
import '../../model/livechat_group.dart';

class LivechatGroupBar extends StatefulWidget {
  final LivechatGroupModel livechatGroup;
  final Function(LivechatGroupModel) onTap;

  const LivechatGroupBar({
    super.key,
    required this.livechatGroup,
    required this.onTap,
  });

  @override
  State<LivechatGroupBar> createState() => _LivechatGroupBarState();
}

class _LivechatGroupBarState extends State<LivechatGroupBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var nonSelfMembers = <Map<String, dynamic>>[];
    for (final member in widget.livechatGroup.members) {
      if (member.uuid != LivechatViewmodel().currentUser.uuid) {
        nonSelfMembers.add({"url": member.avatar, "username": member.name});
      }
    }
    // var userIds = <int>[];
    // var userNames = <String>[];
    // for (var item in widget.imGroupModel.memberList) {
    //   if (item.id == UserModel.instance.id) continue;
    //   userIds.add(item.id);
    //   userNames.add(item.name);
    // }
    // if (userIds.isEmpty) {
    //   userIds.add(UserModel.instance.id);
    // }
    return GestureDetector(
      onTap: () {
        widget.onTap(widget.livechatGroup);
        // _onTap(context);
      },
      child: Container(
        color: InnoConfig.colors.backgroundColor,
        width: MediaQuery.of(context).size.width,
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Row(
          children: [
            Stack(children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: nonSelfMembers.isEmpty
                    ? InnoAvatar(url: LivechatViewmodel().currentUser.avatar)
                    : nonSelfMembers.length == 1
                        ? InnoAvatar(url: nonSelfMembers.first["url"], size: 43)
                        : MemberAvatarsBox(members: nonSelfMembers, avatarSize: 20),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: InnoBadge(notificationKey: 'imGroup${widget.livechatGroup.id}'),
              ),
            ]),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  InnoText(
                    widget.livechatGroup.getLivechatTitle(),
                    fontSize: 16,
                    color: widget.livechatGroup.isLocalGroup ? Colors.pink.shade300 : null,
                  ),
                  const SizedBox(height: 5),
                  InnoText(
                    widget.livechatGroup.lastMessage.isEmpty ? '无内容' : widget.livechatGroup.lastMessage,
                    color: InnoConfig.colors.textColorLight7,
                    fontSize: 12,
                  ),
                  const Spacer(),
                  Divider(height: 1, color: InnoConfig.colors.textColorLight12),
                ],
              ),
            ),
            if (kDebugMode)
              InnoText(widget.livechatGroup.id.substring(
                0,
                min(4, widget.livechatGroup.id.length),
              ))
          ],
        ),
      ),
    );
  }

  // void _onTap(BuildContext context) async {
  //   DebugManager.log("OnTap");
  //   await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => ImGroupRoomPersonalPage(
  //         pageTitle: imGroupModel.title,
  //         contactUserId: imGroupModel.singleChatterId,
  //         openVoiceCall: false,
  //         imGroupModel: imGroupModel,
  //       ),
  //     ),
  //   );
  // }
}
