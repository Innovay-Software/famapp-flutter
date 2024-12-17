// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:tencent_trtc_cloud/trtc_cloud.dart';
// import 'package:tencent_trtc_cloud/trtc_cloud_def.dart';
// import 'package:tencent_trtc_cloud/trtc_cloud_listener.dart';
// import 'package:tencent_trtc_cloud/tx_audio_effect_manager.dart';
// import 'package:tencent_trtc_cloud/tx_beauty_manager.dart';
// import 'package:tencent_trtc_cloud/tx_device_manager.dart';
//
// import './avatar.dart';
// import './buttons/grey_button.dart';
// import './expanded_text.dart';
// import './innovay_text.dart';
// import '../config.dart';
// import '../global_data.dart';
// import '../utils/network_utils.dart';
// import '../utils/snack_bar_manager.dart';
// import '../utils/debug_utils.dart';
// import '../models/trtc_meeting_model.dart';
// import '../models/user.dart';
// import '../../utils/common_utils.dart';
// import '../../widgets/universal_widgets/index.dart';
// import 'expanded_children_row.dart';
//
// enum VoiceCallPhase { notConnected, connected }
//
// class VoiceCallOverlay extends StatefulWidget {
//   const VoiceCallOverlay({Key? key}) : super(key: key);
//
//   @override
//   State<VoiceCallOverlay> createState() => VoiceCallOverlayState();
// }
//
// class VoiceCallOverlayState extends State<VoiceCallOverlay> with WidgetsBindingObserver {
//   final TrtcMeetingModel _meetingModel = TrtcMeetingModel();
//   Offset _offset = const Offset(0, 500);
//   VoiceCallPhase callPhase = VoiceCallPhase.notConnected;
//   bool _showVoiceCallWidget = true;
//   bool _showVoiceCallFloatingButton = false;
//   Map<int, dynamic> userCandidates = {};
//
//   Map<String, dynamic> _imGroup = {};
//   // int _meetingRoomId = 0;
//   String _userId = '';
//   String _userSig = '';
//
//   bool _isOpenMic = true;
//   bool _isOpenCamera = false;
//   bool _isFrontCamera = false;
//   bool _isSpeaker = true;
//   int? _localViewId;
//
//   TRTCCloud? _trtcCloud;
//   TXDeviceManager? _txDeviceManager;
//   TXBeautyManager? _txBeautyManager;
//   TXAudioEffectManager? _txAudioManager;
//
//   List _userList = [];
//   List _userListLast = [];
//
//   Timer? _callingTimer;
//   int _callingTime = 0;
//   int _lastSyncedCallingTime = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     InnovayGlobalData.voiceCallOverlay = this;
//     // onVoiceCallInvitationRejected = (int imGroupId) {
//     //   DebugManager.Log('onVoiceCallInvitationRejected', repeatTime: 5);
//     //   if (!_imGroup['is_group_chat'] && imGroupId == _imGroup['id']) {
//     //     endVoicCall(false);
//     //   }
//     // };
//   }
//
//   @override
//   void dispose() {
//     if (_callingTimer != null) {
//       _callingTimer!.cancel();
//     }
//     super.dispose();
//   }
//
//   void onVoiceCallInvitationRejected(int imGroupId) {
//     DebugManager.log('onVoiceCallInvitationRejected', repeatTime: 5);
//     if (!_imGroup['is_group_chat'] && imGroupId == _imGroup['id']) {
//       endVoicCall(false);
//     }
//   }
//
//   void switchShowVoiceCallFloatingButton(bool state) {
//     if (_showVoiceCallFloatingButton == state) return;
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       setState(() {
//         _showVoiceCallFloatingButton = state;
//       });
//     });
//   }
//
//   void onFloatingButtonDrag(DragUpdateDetails d) {
//     var shareButtonRadius = 28.0;
//     setState(() {
//       _offset = Offset(
//           d.globalPosition.dx
//                   .clamp(shareButtonRadius, MediaQuery.of(context).size.width - shareButtonRadius) -
//               shareButtonRadius,
//           d.globalPosition.dy.clamp(shareButtonRadius * 2, MediaQuery.of(context).size.height - 100) -
//               shareButtonRadius);
//     });
//   }
//
//   void setMeetingRoomImGroupAndStartVoiceCall(Map<String, dynamic> imGroup, bool sendInvitation) {
//     setMeetingRoomImGroup(imGroup);
//     _startVoiceCall(sendInvitation);
//   }
//
//   void setMeetingRoomImGroup(Map<String, dynamic> imGroup) {
//     setState(() {
//       _imGroup = imGroup;
//     });
//   }
//
//   void clearMeetingRoomImGroup() {
//     setState(() {
//       _imGroup = {};
//     });
//   }
//
//   void onCollapseTap() {
//     setState(() {
//       _showVoiceCallWidget = false;
//     });
//   }
//
//   void onVoiceButtonTap(bool sendInvitation) async {
//     // DebugManager.Log(ModalRoute.of(context)?.settings.name?? 'empty Route');
//     if (isVoiceCallInProgress()) {
//       if (_showVoiceCallWidget) {
//         setState(() {
//           _showVoiceCallWidget = false;
//           endVoicCall(true);
//         });
//       } else {
//         setState(() {
//           _showVoiceCallWidget = true;
//         });
//       }
//     } else {
//       if (_imGroup.isEmpty) {
//         return displaySnackBarMessage('缺少房间ID');
//       }
//       _startVoiceCall(sendInvitation);
//     }
//   }
//
//   void onCallingTimeUpdate() {
//   }
//
//   void _startVoiceCall(bool shouldSendInvitation) async {
//     if (Platform.isAndroid && !(await Permission.microphone.request().isGranted)) {
//       return SnackBarManager.displayMessage('您需要打开麦克风权限');
//     }
//
//     if (_imGroup.isEmpty) return;
//     _meetingModel.setUserSetting({
//       "meetId": _imGroup['id'],
//       "userId": InnovayGlobalData.tencentImConfig['userId'],
//       "userSig": InnovayGlobalData.tencentImConfig['userSig'],
//       "enabledCamera": false,
//       "enabledMicrophone": true,
//       "quality": TRTCCloudDef.TRTC_AUDIO_QUALITY_DEFAULT,
//     });
//     _userId = InnovayGlobalData.tencentImConfig['userId'];
//     _userSig = InnovayGlobalData.tencentImConfig['userSig'];
//     _isOpenCamera = false;
//     _isOpenMic = true;
//     _userList = [];
//     _userListLast = [];
//     // _screenUserList = [];
//     _showVoiceCallWidget = true;
//
//     iniRoom();
//
//     if (shouldSendInvitation) {
//       sendVoiceCallInvitationMessage();
//     }
//   }
//
//   void endVoiceCall(bool isActiveEnded) async {
//     _trtcCloud!.unRegisterListener(onRtcListener);
//     if (_callingTimer != null) {
//       _callingTimer!.cancel();
//     }
//
//     await _trtcCloud!.exitRoom();
//     await TRTCCloud.destroySharedInstance();
//     callPhase = VoiceCallPhase.notConnected;
//     setState(() {});
//     if (isActiveEnded && _callingTime == 0) {
//       sendVoiceCallCancelMessage();
//     }
//   }
//
//   iniRoom() async {
//     InnovayGlobalData.switchLoadingOverlay(true);
//     // Create TRTCCloud singleton
//     _trtcCloud = (await TRTCCloud.sharedInstance())!;
//     // Tencent Cloud Audio Effect Management Module
//     _txDeviceManager = _trtcCloud!.getDeviceManager();
//     // Beauty filter and animated effect parameter management
//     _txBeautyManager = _trtcCloud!.getBeautyManager();
//     // Tencent Cloud Audio Effect Management Module
//     _txAudioManager = _trtcCloud!.getAudioEffectManager();
//     // Register event callback
//     _trtcCloud!.registerListener(onRtcListener);
//
//     // Enter the room
//     enterRoom();
//     initData();
//
//     //Set beauty effect
//     _txBeautyManager!.setBeautyStyle(TRTCCloudDef.TRTC_BEAUTY_STYLE_NATURE);
//     _txBeautyManager!.setBeautyLevel(6);
//   }
//
//   void sendVoiceCallInvitationMessage() {
//     NetworkManager.postRequest(
//         InnovayConfig.imNetworkConfig.sendMessage(_imGroup['id']),
//         {
//           'type': 'voiceCallInvitation',
//           'body': '${UserModel.instance.name} 开启了语音通话',
//         },
//         (p0) => null,
//         (p0) => null);
//   }
//
//   void sendVoiceCallCancelMessage() {
//     NetworkManager.postRequest(
//         InnovayConfig.imNetworkConfig.sendMessage(_imGroup['id']),
//         {
//           'type': 'voiceCallCancellation',
//           'body': '${UserModel.instance.name} 取消了语音通话',
//         },
//         (p0) => null,
//         (p0) => null);
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     switch (state) {
//       case AppLifecycleState.inactive:
//         break;
//       case AppLifecycleState
//           .resumed: //Switch from the background to the foreground, and the interface is visible
//         if (Platform.isAndroid) {
//           _userListLast = jsonDecode(jsonEncode(_userList));
//           _userList = [];
//           // _screenUserList = MeetingTool.getScreenList(_userList);
//           setState(() {});
//
//           const timeout = Duration(milliseconds: 100); //10ms
//           Timer(timeout, () {
//             _userList = _userListLast;
//             // _screenUserList = MeetingTool.getScreenList(_userList);
//             setState(() {});
//           });
//         }
//         break;
//       case AppLifecycleState.paused: // Interface invisible, background
//         break;
//       case AppLifecycleState.detached:
//         break;
//     }
//   }
//
//   enterRoom() async {
//     if (_userId.isEmpty || _userSig.isEmpty || _imGroup.isEmpty) {
//       return displaySnackBarMessage('Cannot enter room $_userId - $_userSig');
//     }
//     await _trtcCloud!.enterRoom(
//         TRTCParams(
//             sdkAppId: InnovayConfig.tencentImSdkAppId,
//             userId: _userId,
//             userSig: _userSig,
//             role: TRTCCloudDef.TRTCRoleAnchor,
//             roomId: _imGroup['id']),
//         TRTCCloudDef.TRTC_APP_SCENE_LIVE);
//   }
//
//   initData() async {
//     if (_isOpenCamera) {
//       _userList.add({
//         'userId': _userId,
//         'type': 'video',
//         'visible': true,
//         'size': {'width': 0, 'height': 0}
//       });
//     } else {
//       _userList.add({
//         'userId': _userId,
//         'type': 'video',
//         'visible': false,
//         'size': {'width': 0, 'height': 0}
//       });
//     }
//     if (_isOpenMic) {
//       await _trtcCloud!.startLocalAudio(TRTCCloudDef.TRTC_AUDIO_QUALITY_DEFAULT);
//     }
//
//     // _screenUserList = MeetingTool.getScreenList(_userList);
//     _meetingModel.setList(_userList);
//     setState(() {});
//   }
//
//   onRtcListener(type, param) async {
//     if (type == TRTCCloudListener.onError) {
//       if (param['errCode'] == -1308) {
//         displaySnackBarMessage('Failed to start screen recording');
//         await _trtcCloud!.stopScreenCapture();
//         _userList[0]['visible'] = true;
//         setState(() {});
//         _trtcCloud!.startLocalPreview(_isFrontCamera, _localViewId);
//       } else {
//         displaySnackBarMessage(param['errMsg']);
//         return;
//       }
//     }
//     if (type == TRTCCloudListener.onEnterRoom) {
//       if (param > 0) {
//         InnovayGlobalData.switchLoadingOverlay(false);
//         callPhase = VoiceCallPhase.connected;
//         displaySnackBarMessage('您已进入房间 ${_imGroup['id']}');
//         setState(() {
//           _callingTime = 0;
//           _lastSyncedCallingTime = 0;
//           if (_callingTimer != null) {
//             _callingTimer!.cancel();
//           }
//           _callingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
//             onCallingTimeUpdate();
//           });
//         });
//         setState(() {});
//       }
//     }
//     if (type == TRTCCloudListener.onExitRoom) {
//       if (param > 0) {
//         displaySnackBarMessage('您已退出房间 ${_imGroup['id']}');
//         if (_callingTimer != null) {
//           _callingTimer!.cancel();
//         }
//         callPhase = VoiceCallPhase.notConnected;
//       }
//     }
//     // Remote user entry
//     if (type == TRTCCloudListener.onRemoteUserEnterRoom) {
//       DebugManager.log('onRemoteuserEnterRoom');
//       DebugManager.log(param.toString());
//       _userList.add({
//         'userId': param,
//         'type': 'video',
//         'visible': false,
//         'size': {'width': 0, 'height': 0}
//       });
//       // _screenUserList = MeetingTool.getScreenList(_userList);
//       _meetingModel.setList(_userList);
//       setState(() {});
//     }
//     // Remote user leaves room
//     if (type == TRTCCloudListener.onRemoteUserLeaveRoom) {
//       String userId = param['userId'];
//       for (var i = 0; i < _userList.length; i++) {
//         if (_userList[i]['userId'] == userId) {
//           _userList.removeAt(i);
//         }
//       }
//       //The user who is amplifying the video exit room
//       // if (doubleUserId == userId) {
//       //   isDoubleTap = false;
//       // }
//       // _screenUserList = MeetingTool.getScreenList(_userList);
//       _meetingModel.setList(_userList);
//       setState(() {
//         if (!_imGroup['is_group_chat']) {
//           endVoicCall(false);
//         }
//       });
//     }
//     if (type == TRTCCloudListener.onUserVideoAvailable) {
//       String userId = param['userId'];
//
//       if (param['available']) {
//         for (var i = 0; i < _userList.length; i++) {
//           if (_userList[i]['userId'] == userId && _userList[i]['type'] == 'video') {
//             _userList[i]['visible'] = true;
//           }
//         }
//       } else {
//         for (var i = 0; i < _userList.length; i++) {
//           if (_userList[i]['userId'] == userId && _userList[i]['type'] == 'video') {
//             _trtcCloud!.stopRemoteView(userId, TRTCCloudDef.TRTC_VIDEO_STREAM_TYPE_BIG);
//             _userList[i]['visible'] = false;
//           }
//         }
//       }
//
//       // _screenUserList = MeetingTool.getScreenList(_userList);
//       _meetingModel.setList(_userList);
//       setState(() {});
//     }
//
//     if (type == TRTCCloudListener.onUserSubStreamAvailable) {
//       String userId = param["userId"];
//       if (param["available"]) {
//         _userList.add({
//           'userId': userId,
//           'type': 'subStream',
//           'visible': true,
//           'size': {'width': 0, 'height': 0}
//         });
//       } else {
//         for (var i = 0; i < _userList.length; i++) {
//           if (_userList[i]['userId'] == userId && _userList[i]['type'] == 'subStream') {
//             // if (isDoubleTap &&
//             //     doubleUserId == userList[i]['userId'] &&
//             //     doubleUserIdType == userList[i]['type']) {
//             //   doubleTap(userList[i]);
//             // }
//             _trtcCloud!.stopRemoteView(userId, TRTCCloudDef.TRTC_VIDEO_STREAM_TYPE_SUB);
//             _userList.removeAt(i);
//           }
//         }
//       }
//       // _screenUserList = MeetingTool.getScreenList(_userList);
//       _meetingModel.setList(_userList);
//       setState(() {});
//     }
//   }
//
//   void displaySnackBarMessage(String msg) {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       SnackBarManager.displayMessage(msg);
//     });
//   }
//
//   bool isVoiceCallInProgress() {
//     return callPhase == VoiceCallPhase.connected;
//   }
//
//   Widget renderUserView(item, valueKey) {
//     var currentUserId = item['userId'];
//     var isSelf = currentUserId == _userId;
//     var userId = int.parse(currentUserId.split('-')[1]);
//     var userName = currentUserId;
//     var userAvatar = InnovayAvatar(InnovayConfig.mainNetworkConfig.userAvatar(userId), 50);
//     if (isSelf) {
//       userName = '${UserModel.instance.name} (我)';
//     } else if (userCandidates.containsKey(userId)) {
//       userName = userCandidates[userId]['name'];
//     } else {
//       userName = userName.split('-').last;
//     }
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//       alignment: Alignment.center,
//       child: Row(children: [
//         Container(
//           margin: const EdgeInsets.only(bottom: 10),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(180),
//             border: Border.all(color: Colors.white, width: 1),
//           ),
//           child: ClipOval(
//             child: userAvatar,
//           ),
//         ),
//         const SizedBox(width: 10),
//         InnovayText(userName, color: Colors.white),
//         const SizedBox(width: 10),
//         const Icon(
//           Icons.signal_cellular_alt,
//           color: Colors.white,
//           size: 20,
//         ),
//         Expanded(flex: 1, child: Container()),
//       ]),
//     );
//   }
//
//   Widget buildTopRow() {
//     List<Widget> children = [];
//     children.add(
//       ExpandedText(1, '语音群号：${_imGroup['id']}', color: InnovayConfig.colors.primaryColorTextColor),
//     );
//
//     int minutes = (_callingTime / 60).floor();
//     int seconds = _callingTime % 60;
//     children.add(Expanded(
//         flex: 1,
//         child: InnovayText('${minutes < 10 ? '0' : ''}$minutes:${seconds < 10 ? '0' : ''}$seconds',
//             color: InnovayConfig.colors.primaryColorTextColor, fontSize: 14)));
//     children.add(Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [InnovayGreyButton('收起', onCollapseTap, fontSize: 14)],
//     ));
//
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//       color: InnovayConfig.colors.primaryColor,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: children,
//       ),
//     );
//   }
//
//   Widget buildBottomRow() {
//     return Container(
//         padding: const EdgeInsets.only(top: 10, bottom: 50),
//         color: const Color.fromRGBO(30, 30, 30, 1),
//         child: Column(children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               GestureDetector(
//                 onTap: () async {
//                   if (_isSpeaker) {
//                     _txDeviceManager!.setAudioRoute(TRTCCloudDef.TRTC_AUDIO_ROUTE_EARPIECE);
//                   } else {
//                     _txDeviceManager!.setAudioRoute(TRTCCloudDef.TRTC_AUDIO_ROUTE_SPEAKER);
//                   }
//                   setState(() {
//                     _isSpeaker = !_isSpeaker;
//                   });
//                 },
//                 child: Icon(
//                   _isSpeaker ? Icons.volume_up : Icons.hearing,
//                   color: Colors.white,
//                   size: 36.0,
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () async {
//                   if (_isOpenMic) {
//                     _trtcCloud!.stopLocalAudio();
//                   } else {
//                     _trtcCloud!.startLocalAudio(TRTCCloudDef.TRTC_AUDIO_QUALITY_DEFAULT);
//                   }
//                   setState(() {
//                     _isOpenMic = !_isOpenMic;
//                   });
//                 },
//                 child: Icon(
//                   _isOpenMic ? Icons.mic : Icons.mic_off,
//                   color: Colors.white,
//                   size: 36.0,
//                 ),
//               )
//             ],
//           ),
//           ExpandedChildrenRow(children: [
//             InnovayText(
//               _isSpeaker ? '扬声器' : '耳机',
//               color: Colors.white,
//               textAlign: TextAlign.center,
//             ),
//             InnovayText(
//               _isOpenMic ? '麦克风已打开' : '麦克风已关闭',
//               color: Colors.white,
//               textAlign: TextAlign.center,
//             )
//           ])
//         ]));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     List<Widget> stackChildren = [];
//     if (isVoiceCallInProgress()) {
//       if (_showVoiceCallWidget) {
//         stackChildren.add(Positioned(
//           left: 0,
//           right: 0,
//           top: 0,
//           bottom: 0,
//           child: Container(color: InnovayConfig.colors.loadingGreyTransparentBackgroundColor),
//         ));
//
//         List<Widget> onlineUserChildWidgets = [
//           Container(
//               padding: const EdgeInsets.all(15),
//               child: InnovayText('当前在线:', color: Colors.white, fontWeight: FontWeight.bold))
//         ];
//
//         for (var i = 0; i < _userList.length; i++) {
//           var item = _userList[i];
//           ValueKey valueKey = ValueKey(item['userId'] + item['type'] + '0');
//           onlineUserChildWidgets.add(
//             renderUserView(item, valueKey),
//           );
//         }
//
//         stackChildren.add(Positioned(
//             left: 0,
//             right: 0,
//             bottom: 0,
//             child: SizedBox(
//               height: MediaQuery.of(context).size.height * 0.7,
//               child: Column(
//                 children: [
//                   buildTopRow(),
//                   Expanded(
//                       flex: 1,
//                       child: Container(
//                           color: const Color.fromRGBO(60, 60, 60, 1),
//                           child: SingleChildScrollView(
//                               child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: onlineUserChildWidgets)))),
//                   // beautySetting(),
//                   buildBottomRow()
//                 ],
//               ),
//             )));
//
//         stackChildren.add(
//           Positioned(
//               left: _offset.dx,
//               top: _offset.dy,
//               child: GestureDetector(
//                 onPanUpdate: onFloatingButtonDrag,
//                 child: FloatingActionButton(
//                   onPressed: () {
//                     onVoiceButtonTap(true);
//                   },
//                   backgroundColor: InnovayConfig.colors.voiceCallOnColor,
//                   child: InnovayText('挂断', color: InnovayConfig.colors.primaryColorTextColor),
//                 ),
//               )),
//         );
//       } else {
//         int minutes = (_callingTime / 60).floor();
//         int seconds = _callingTime % 60;
//         stackChildren.add(
//           Positioned(
//               left: _offset.dx,
//               top: _offset.dy,
//               child: GestureDetector(
//                 onPanUpdate: onFloatingButtonDrag,
//                 child: FloatingActionButton(
//                   onPressed: () {
//                     onVoiceButtonTap(true);
//                   },
//                   backgroundColor: InnovayConfig.colors.voiceCallOnColor,
//                   child: InnovayText(
//                       '通话中\n${minutes < 10 ? '0' : ''}$minutes:${seconds < 10 ? '0' : ''}$seconds',
//                       color: InnovayConfig.colors.deleteColorTextColor,
//                       fontSize: 12),
//                 ),
//               )),
//         );
//       }
//     } else if (_showVoiceCallFloatingButton && _imGroup.isNotEmpty) {
//       stackChildren.add(
//         Positioned(
//             left: _offset.dx,
//             top: _offset.dy,
//             child: GestureDetector(
//               onPanUpdate: onFloatingButtonDrag,
//               child: FloatingActionButton(
//                 onPressed: () {
//                   onVoiceButtonTap(true);
//                 },
//                 backgroundColor: InnovayConfig.colors.voiceCallOffColor,
//                 child: Image.asset('assets/innovay/VoiceChat.png', width: 80, height: 80, fit: BoxFit.contain),
//               ),
//             )),
//       );
//     }
//     return Stack(children: stackChildren);
//   }
// }
