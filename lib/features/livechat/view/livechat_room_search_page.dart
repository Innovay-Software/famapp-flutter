import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../core/config.dart';
import '../../../core/utils/common_utils.dart';
import '../../../core/views/app_status_bar.dart';
import '../../../core/widgets/avatar.dart';
import '../../../core/widgets/buttons/background_button.dart';
import '../../../core/widgets/cached_image.dart';
import '../../../core/widgets/custom_ui_expanded_row.dart';
import '../../../core/widgets/custom_ui_text_fields.dart';
import '../../../core/widgets/innovay_text.dart';
import '../../../core/widgets/no_content_placeholder_widget.dart';
import '../../../core/widgets/smart_refresher_footer.dart';
import '../model/livechat_group.dart';
import '../model/livechat_message.dart';

class LivechatRoomSearchPage extends StatefulWidget {
  final LivechatGroupModel livechatGroup;

  const LivechatRoomSearchPage({
    super.key,
    required this.livechatGroup,
  });

  @override
  State<LivechatRoomSearchPage> createState() => _LivechatRoomSearchPageState();
}

class _LivechatRoomSearchPageState extends State<LivechatRoomSearchPage> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final ScrollController _scrollController = ScrollController();
  // final Map<int, dynamic> _imGroups = {};
  final List<dynamic> _livechatMessages = [];
  String _searchContent = '';
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _searchMessages(bool forceReload) async {
    // var db = InnoLocalDatabaseService.instance.imDatabase;
    // // var imGroupIds = <int>[];
    // // var imGroupUser = await db.query('im_group_user', where: 'user_id = ?', whereArgs: [UserModel.instance.id]);
    // // for (var item in imGroupUser) {
    // //   var imGroupId = int.tryParse('${item['id']}') ?? 0;
    // //   if (imGroupId > 0 && !imGroupIds.contains(imGroupId)) {
    // //     imGroupIds.add(imGroupId);
    // //   }
    // // }
    // InnoGlobalData.switchLoadingOverlay(true);
    //
    // if (forceReload) {
    //   _livechatMessages.clear();
    //   // _imGroups.clear();
    //   // var imGroups = await db.query(
    //   //   'im_groups',
    //   //   where: 'id in (${List.filled(imGroupIds.length, '?').join(',')})',
    //   //   whereArgs: imGroupIds,
    //   // );
    //   // for (var item in imGroups) {
    //   //   var imGroupId = int.tryParse('${item['id']}') ?? 0;
    //   //   _imGroups[imGroupId] = item;
    //   // }
    // } else {
    //   if (!_hasMore) {
    //     InnoGlobalData.switchLoadingOverlay(false);
    //     return;
    //   }
    // }
    //
    // if (forceReload || _livechatMessages.isEmpty) {
    //   DebugManager.log("Reload: $_searchContent");
    //   var messagesData = await db.query(
    //     'im_messages',
    //     where: "im_group_id = ? AND body like '%$_searchContent%'",
    //     whereArgs: [widget.imGroup.id],
    //     orderBy: 'id DESC',
    //     limit: 500,
    //   );
    //   _livechatMessages.clear();
    //   for (var item in messagesData) {
    //     _livechatMessages.add(ImMessage.LivechatMessageModel(false, item));
    //   }
    //   _hasMore = messagesData.length >= 500;
    // } else {
    //   DebugManager.log("Not Reload");
    //   var messagesData = await db.query(
    //     'im_messages',
    //     where: "im_group_id = ? AND body like '%$_searchContent%' AND id < ?",
    //     whereArgs: [widget.imGroup.id, _livechatMessages.last['id']],
    //     orderBy: 'id DESC',
    //     limit: 500,
    //   );
    //   for (var item in messagesData) {
    //     _livechatMessages.add(ImMessage.LivechatMessageModel(false, item));
    //   }
    //   _hasMore = messagesData.length >= 500;
    // }
    //
    // DebugManager.log("_imMessages length = ${_livechatMessages.length}");
    // InnoGlobalData.switchLoadingOverlay(false);
    // if (mounted) setState(() {});
    // _refreshController.refreshCompleted();
    // _refreshController.loadComplete();
  }

  void _onRefresh() async {
    _searchMessages(true);
  }

  void _onLoading() async {
    if (!_hasMore) return;
    _searchMessages(false);
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: InnoAppStatusBar(context, false),
      backgroundColor: InnoConfig.colors.backgroundColorTinted3,
      body: Column(children: [
        Container(
          color: InnoConfig.colors.backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Row(
            children: [
              Expanded(
                child: CustomTextFieldWidget(
                  initialValue: _searchContent,
                  textAlign: TextAlign.left,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(5),
                    child: Icon(CupertinoIcons.search),
                  ),
                  onChange: (val) {
                    _searchContent = val;
                  },
                  onComplete: (val) {
                    _searchMessages(true);
                  },
                ),
              ),
              InnovayBackgroundButton(
                '',
                InnoConfig.colors.textColor,
                () {
                  Navigator.pop(context);
                },
                prefixWidget: const Icon(Icons.close_rounded),
              ),
            ],
          ),
        ),
        Expanded(
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: _hasMore,
            header: const WaterDropHeader(),
            footer: const InnovaySmartRefresherFooter(),
            controller: _refreshController,
            scrollController: _scrollController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: ListView.builder(
              itemBuilder: (context, index) {
                if (_livechatMessages.isEmpty) {
                  return const InnoNoContentPlaceholder();
                }
                var imMessage = _livechatMessages[index];
                return Container(
                  color: InnoConfig.colors.backgroundColor,
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.only(top: 1),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    InnoAvatarUserId(imMessage.userId, userName: imMessage.userName, size: 40),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Row(children: [
                          InnoText(imMessage.userName, color: InnoConfig.colors.textColorLight7, fontSize: 11),
                          const Spacer(),
                          InnoText(
                            DateFormat('y-MM-dd HH:mm').format(imMessage.createdAt.toLocal()),
                            color: InnoConfig.colors.textColorLight7,
                            fontSize: 11,
                          ),
                        ]),
                        const SizedBox(height: 5),
                        if (imMessage.type == ImMessageType.text || imMessage.type == ImMessageType.systemText)
                          ExpandedRowWidget(children: [InnoText(imMessage.body, color: InnoConfig.colors.textColor)]),
                        if (imMessage.type == ImMessageType.image)
                          ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: GestureDetector(
                                  onTap: () {
                                    CommonUtils.displayImageFullScreenBottomSheet(context, [imMessage.body], 0);
                                  },
                                  child: Stack(children: [
                                    Container(
                                        color: InnoConfig.colors.backgroundColor,
                                        child: InnovayCachedImage(imMessage.body,
                                            width: screenWidth * 0.4, fit: BoxFit.cover))
                                  ]))),
                      ]),
                    ),
                  ]),
                );
              },
              itemCount: max(1, _livechatMessages.length),
            ),
          ),
        )
      ]),
    );
  }
}
