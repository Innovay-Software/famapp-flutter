import 'package:famapp/features/livechat/view/livechat_room_page.dart';
import 'package:famapp/features/livechat/viewmodel/livechat_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/config.dart';
import '../../../core/utils/common_utils.dart';
import '../../../core/utils/debug_utils.dart';
import '../../../core/views/app_bar.dart';
import '../../../core/widgets/avatar.dart';
import '../../../core/widgets/buttons/background_button.dart';
import '../../../core/widgets/buttons/bottom_picker_action_button_row.dart';
import '../../settings/viewmodel/user_viewmodel.dart';
import '../model/livechat_group.dart';
import 'widgets/livechat_group_bar.dart';

class LivechatHomePage extends StatefulWidget {
  const LivechatHomePage({super.key});

  @override
  State<LivechatHomePage> createState() => _LivechatHomePageState();
}

class _LivechatHomePageState extends State<LivechatHomePage> with AutomaticKeepAliveClientMixin<LivechatHomePage> {
  final UserViewmodel _userViewmodel = UserViewmodel();

  @override
  void initState() {
    super.initState();
    DebugManager.log("ImHome.initState");
    // _imViewmodel.onWsSyncStartedCallbacks.add(_refreshPage);
    // _imViewmodel.onWsSyncCompletedCallbacks.add(_refreshPage);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      init();
    });
  }

  Future<void> init() async {
    // Login to livechat backend
    final accessToken = UserViewmodel().currentUser.getAccessToken();
    if (accessToken.isEmpty) {
      DebugManager.error("Missing accessToken");
      return;
    }
    final viewModel = LivechatViewmodel();
    viewModel.grpcService.startUserGeneralStream(accessToken);
    // viewModel.grpcService.userGeneralStreamController.done

    // await GRPCServiceAuth.accessTokenLogin();
    // Check if livechatViewModel is initialized:
    // if (viewModel.currentUser.isEmpty) {
    //   DebugManager.error("Missing viewmodel logged in use");
    // }
    // DebugManager.log("${viewModel.grpcService.grpcClient.toString()} initialized");
    // DebugManager.log("Livechat User Logged in: ${LivechatViewmodel().currentUser.first.name}");

    // if (user != null) {
    //   DebugManager.log("Logging success: ${user.name.toUpperCase()}");
    //   if (mounted) {
    //     await Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => ImChatRoomPage(
    //           pageTitle: "Testing Chat",
    //           imGroup: ImGroup.emptyPersonalChat(0, <int, ImUserModel>{user.id: user}),
    //         ),
    //       ),
    //     );
    //   }
    // }
  }

  @override
  void dispose() {
    DebugManager.log("ImHome Dispose");
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var currentUser = context.watch<UserViewmodel>().currentUser;
    var livechatCurrentUser = context.watch<LivechatViewmodel>().currentUser;
    var allLivechatGroups = <LivechatGroupModel>[];
    allLivechatGroups.addAll(context.watch<LivechatViewmodel>().allBackendLivechatGroups);
    allLivechatGroups.addAll(context.watch<LivechatViewmodel>().allLocalLivechatGroups);
    return Scaffold(
      appBar: InnoAppBar(
        false,
        currentUser.name,
        [
          InnovayBackgroundButton(
            '',
            prefixWidget: const Icon(Icons.more_horiz_rounded),
            InnoConfig.colors.primaryColor,
            _onMenuTap,
          ),
        ],
        toolbarHeight: 100,
        // showLeading: false,
        leadingWidget: Align(
          alignment: Alignment.topRight,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                width: 2,
                color: livechatCurrentUser.isDummy() ? InnoConfig.colors.deleteColor : InnoConfig.colors.successColor,
              ),
            ),
            // padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: InnoAvatar(
                url: livechatCurrentUser.avatar,
                userName: livechatCurrentUser.name,
                size: 40,
              ),
            ),
          ),
        ),
        onBackTap: () => null, // Override the default back tap
        // bottom: Divider(),
      ),
      backgroundColor: InnoConfig.colors.backgroundColor,
      body: ListView.builder(
        itemBuilder: (c, i) {
          return LivechatGroupBar(
            // key: Key(
            //     'ImGroup.${_imCenterService.imGroupList[i].id}.${_imCenterService.imGroupList[i].singleChatterId}'),
            livechatGroup: allLivechatGroups[i],
            onTap: _onImGroupBarTap,
          );
        },
        // itemExtent: 100.0,
        itemCount: allLivechatGroups.length,
      ),
    );
  }

  void _onMenuTap() {
    CommonUtils.displayBottomPicker(context, '', [
      InnovayBottomPickerActionButtonRow(
        '',
        InnoConfig.colors.textColor,
        _onNewImGroupTap,
        prefixWidget: Icon(Icons.group_add, color: InnoConfig.colors.primaryColor),
      ),
      InnovayBottomPickerActionButtonRow(
        '',
        InnoConfig.colors.textColor,
        _onSyncDataTap,
        prefixWidget: Icon(Icons.sync, color: InnoConfig.colors.primaryColor),
      ),
    ]);
  }

  void _onNewImGroupTap() {
    DebugManager.error('Needs implementation');
    // CommonUtils.displayBottomPicker(context, '', [ChatUserPicker(availableUsers: _users, selectedUserIds: const [])]);
  }

  void _onSyncDataTap() async {
    // Navigator.pop(context);
    // CommonUtils.displayCustomDialog(
    //   context,
    //   'Sync from cloud?',
    //   [],
    //   const Icon(CupertinoIcons.xmark_circle, color: Colors.grey),
    //   null,
    //   Icon(CupertinoIcons.checkmark_alt_circle, color: InnoConfig.colors.primaryColor),
    //   () => null,
    //   () async {
    //     SnackBarManager.displayMessage('Sync in progress...');
    //     await _imViewmodel.init();
    //     final imInitViewmodel = ImInitViewmodel();
    //     await imInitViewmodel.purgeDataAndSyncFromCloud();
    //     SnackBarManager.displayMessage('Sync completed');
    //     if (mounted) setState(() {});
    //   },
    //   true,
    // );
  }

  void _onImGroupBarTap(LivechatGroupModel livechatGroup) async {
    DebugManager.log("OnTap");
    LivechatViewmodel().setCurrentLivechatGroup(livechatGroup);
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LivechatRoomPage(),
      ),
    );
    // _getPageData();
  }
}
