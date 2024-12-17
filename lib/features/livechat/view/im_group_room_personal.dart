// import 'package:flutter/material.dart';
//
// import '../../innovay/config.dart';
// import '../../innovay/utils/debug_utils.dart';
// import '../../innovay/widgets/app_bar.dart';
// import '../../innovay/widgets/buttons/background_button.dart';
// import '../../innovay/widgets/page_loading_scaffold_widget.dart';
// import './livechat_room_settings_page.dart';
// import './models/livechat_group.dart';
// import './services/im_viewmodel.dart';
// import './widgets/livechat_room_page.dart';
//
// class ImGroupRoomPersonalPage extends StatefulWidget {
//   final String pageTitle;
//   final bool openVoiceCall;
//   final ImCenterService imCenterModel;
//   final ImGroupModel imGroupModel;
//
//   const ImGroupRoomPersonalPage({
//     super.key,
//     required this.pageTitle,
//     required this.openVoiceCall,
//     required this.imCenterModel,
//     required this.imGroupModel,
//   });
//
//   @override
//   State<ImGroupRoomPersonalPage> createState() => _ImGroupRoomPersonalPageState();
// }
//
// class _ImGroupRoomPersonalPageState extends State<ImGroupRoomPersonalPage> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (widget.imGroupModel.id == 0) {
//       DebugManager.error("ImGroupRoomPersonal.build: Invalid imGroupModel: ${widget.imGroupModel.id}");
//       return const InnovayPageLoadingScaffoldWidget();
//     }
//
//     return Scaffold(
//       appBar: InnovayAppBar(
//         false,
//         widget.pageTitle,
//         [
//           InnovayBackgroundButton(
//             '',
//             InnovayConfig.colors.textColor,
//             _onSettingsTap,
//             prefixWidget: const Icon(Icons.more_horiz_rounded),
//           )
//         ],
//       ),
//       backgroundColor: InnovayConfig.colors.backgroundColor,
//       body: SafeArea(
//         child: Column(children: [
//           Expanded(
//             child:
//                 ImChatRoom(pageTitle: widget.pageTitle, imCenter: widget.imCenterModel, imGroup: widget.imGroupModel),
//           ),
//         ]),
//       ),
//     );
//   }
//
//   void _onSettingsTap() async {
//     await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ImGroupRoomSettingsPage(
//           imGroup: widget.imGroupModel,
//           onLeaveImGroup: () {
//             DebugManager.log("onLeaveImGroup");
//             Navigator.pop(context);
//           },
//         ),
//       ),
//     );
//   }
// }
