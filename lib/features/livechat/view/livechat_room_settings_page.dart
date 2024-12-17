import 'package:famapp/features/livechat/viewmodel/livechat_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/config.dart';
import '../../../core/utils/common_utils.dart';
import '../../../core/utils/debug_utils.dart';
import '../../../core/views/app_bar.dart';
import '../../../core/widgets/avatar.dart';
import '../../../core/widgets/buttons/delete_button.dart';
import '../../../core/widgets/expanded_children_row.dart';
import '../../../core/widgets/innovay_text.dart';
import '../../../core/widgets/right_arrow.dart';
import '../model/livechat_group.dart';
import 'livechat_room_search_page.dart';

class LivechatRoomSettingsPage extends StatefulWidget {
  final LivechatGroupModel livechatGroup;
  final Function() onLeaveImGroup;

  const LivechatRoomSettingsPage({
    super.key,
    required this.livechatGroup,
    required this.onLeaveImGroup,
  });

  @override
  State<LivechatRoomSettingsPage> createState() => _LivechatRoomSettingsPageState();
}

class _LivechatRoomSettingsPageState extends State<LivechatRoomSettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onInviteTap() {
    DebugManager.log("Needs Implementation");
  }

  void _inviteUser(int userId) {
    // InnovayGlobalData.switchLoadingOverlay(true);
    // NetworkManager.postRequest(
    //   InnovayConfig.imNetworkConfig.inviteUser(widget.imGroup.id),
    //   {
    //     'inviteeId': userId,
    //     'inviteeRole': inviteeRole.toShortString(),
    //   },
    //   (res) {
    //     InnovayGlobalData.switchLoadingOverlay(false);
    //     widget.imGroup.memberList.add(ImGroupMemberModel(res['data']['newMember']));
    //     SnackBarManager.displayMessage('已加入');
    //     setState(() {});
    //   },
    //   (res) {
    //     InnovayGlobalData.switchLoadingOverlay(false);
    //   },
    // );
  }

  void _onLeaveTap() {
    final user = LivechatViewmodel().currentUser;
    var noticeText = 'Are you sure you want to leave this chat?';
    CommonUtils.displayCustomDialog(
        context,
        AppLocalizations.of(context)!.exitConfirmationTitle,
        [
          InnoText(noticeText),
        ],
        const Icon(Icons.cancel_outlined),
        const Icon(Icons.check_rounded),
        null,
        _onConfirmLeaveTap,
        () => null,
        true);
  }

  void _onConfirmLeaveTap() {
    DebugManager.unimplemented(message: "LivechatGroup.leaveImGroup");
  }

  void _onImMessageSearchTap() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => LivechatRoomSearchPage(livechatGroup: widget.livechatGroup)));
  }

  void _onSyncMessagesTap() async {}

  Widget buildMemberListSection() {
    var borderRadius = 8.0;
    var columnCount = 4;
    var padding = 30.0;
    var spacing = 30.0;
    var avatarSize = (MediaQuery.of(context).size.width - padding * 2 - spacing * (columnCount - 1)) / columnCount - 2;
    var rowCount = ((widget.livechatGroup.members.length + 1) / columnCount).ceil();

    return Container(
        width: MediaQuery.of(context).size.width,
        height: padding * 1.5 + rowCount * (avatarSize + 20) + (rowCount - 1) * spacing,
        padding: EdgeInsets.only(left: padding, right: padding, top: padding),
        color: InnoConfig.colors.backgroundColor,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columnCount,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            childAspectRatio: avatarSize / (avatarSize + 20),
          ),
          itemCount: widget.livechatGroup.members.length,
          itemBuilder: (context, index) {
            if (index < widget.livechatGroup.members.length) {
              var imGroupMember = widget.livechatGroup.members[index];
              var backgroundColor = InnoConfig.colors.backgroundColorTinted;

              return Column(children: [
                Stack(children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius),
                      // border: Border.all(
                      //     color: imGroupMember.id == UserModel.instance.id
                      //         ? InnovayConfig.colors.successColor.withGreen(210)
                      //         : InnovayConfig.colors.backgroundColor,
                      //     width: 2),
                    ),
                    width: avatarSize + 0,
                    height: avatarSize + 0,
                    child: InnoAvatarUserId(
                      0,
                      // imGroupMember.id,
                      userName: imGroupMember.name,
                      size: avatarSize,
                      borderRadius: borderRadius,
                    ),
                  ),
                ]),
                const Spacer(),
                InnoText(
                  imGroupMember.name,
                  style: TextStyle(
                    fontSize: 12,
                    color: InnoConfig.colors.textColorLight7,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ]);
            }
            // return Container(color: Colors.red);
            return Column(children: [
              GestureDetector(
                  onTap: _onInviteTap,
                  child: Container(
                      width: avatarSize,
                      height: avatarSize,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(borderRadius),
                          border: Border.all(style: BorderStyle.solid, color: InnoConfig.colors.textColorLight11)),
                      child: Icon(Icons.add, color: InnoConfig.colors.textColorLight9)))
            ]);
            // return Container(
            //     width: 50,
            //     height: 80,
            //     child: Align(
            //         alignment: Alignment.topCenter,
            //         child: Container(
            //             width: 50,
            //             height: 50,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(4),
            //                 border: Border.all(style: BorderStyle.solid, color: InnovayConfig.colors.textColorLight7)),
            //             child: Icon(Icons.add))));
          },
        ));
  }

  Widget buildMenuBar(String title, Function()? onTap, {String? desc, Widget? rightWidget}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        color: InnoConfig.colors.backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.only(top: 1),
        child: Row(
          children: [
            InnoText(title),
            const Spacer(),
            if (desc != null) InnoText(desc),
            if (rightWidget != null) rightWidget,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InnoAppBar(false, AppLocalizations.of(context)!.settings, []),
      backgroundColor: InnoConfig.colors.backgroundColorTinted3,
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildMemberListSection(),
            const SizedBox(height: 10),
            buildMenuBar(AppLocalizations.of(context)!.search, _onImMessageSearchTap,
                rightWidget: const InnovayRightArrow()),
            // buildMenuBar('同步聊天记录', _onSyncMessagesTap),
            const SizedBox(height: 10),
            if (widget.livechatGroup.isGroupChat)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: ExpandedChildrenRow(children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: InnovayDeleteButton(
                      '',
                      _onLeaveTap,
                      prefixWidget: const Icon(CupertinoIcons.delete_simple),
                    ),
                  ),
                ]),
              ),
          ],
        ),
      ),
    );
  }
}

class ImGroupMemberRoleBackgroundPainter extends CustomPainter {
  Color backgroundColor;
  ImGroupMemberRoleBackgroundPainter({required this.backgroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()..color = backgroundColor;
    var middlePointX = size.width * 0.4;
    var middlePointY = size.height * 0.6;
    var middlePointOffsetX = size.width * 0.2;
    var middlePointOffsetY = size.height * 0.2;
    var customPath1 = Path()
      ..moveTo(0, 0)
      ..cubicTo(size.width * 0.3, 0, middlePointX - middlePointOffsetX, middlePointY - middlePointOffsetY, middlePointX,
          middlePointY)
      ..cubicTo(middlePointX + middlePointOffsetX, middlePointY + middlePointOffsetY, size.width, size.height * 0.7,
          size.width, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0);
    canvas.drawPath(customPath1, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
