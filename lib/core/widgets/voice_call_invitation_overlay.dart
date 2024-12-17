// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:vibration/vibration.dart';
// import 'package:assets_audio_player/assets_audio_player.dart';
//
// import './avatar.dart';
// import './innovay_text.dart';
// import '../config.dart';
// import '../global_data.dart';
// import '../utils/network_utils.dart';
// import '../utils/snack_bar_manager.dart';
// import '../utils/debug_utils.dart';
// import '../models/user.dart';
//
// class VoiceCallInvitationOverlay extends StatefulWidget {
//   const VoiceCallInvitationOverlay({Key? key}) : super(key: key);
//
//   @override
//   State<VoiceCallInvitationOverlay> createState() => VoiceCallInvitationOverlayState();
// }
//
// class VoiceCallInvitationOverlayState extends State<VoiceCallInvitationOverlay> {
//   bool _showInvitation = false;
//   String _inviterName = '';
//   String _imGroupType = '';
//   int _inviterId = 0;
//   int _imGroupId = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     InnovayGlobalData.voiceCallInvitationOverlay = this;
//   }
//
//   void openInvitationWidget(String inviterName, int inviterId, String imGroupType, int imGroupId) async {
//     DebugManager.log('voice call invitation overlay. openInvitationWidget $_showInvitation');
//     if (_showInvitation) return;
//     setState(() {
//       _showInvitation = true;
//       _inviterName = inviterName;
//       _inviterId = inviterId;
//       _imGroupType = imGroupType;
//       _imGroupId = imGroupId;
//     });
//     SystemSound.play(SystemSoundType.alert);
//
//     var hasVibrator = await Vibration.hasVibrator();
//     if (hasVibrator != null && hasVibrator) {
//       final assetsAudioPlayer = AssetsAudioPlayer();
//       assetsAudioPlayer.open(Audio("assets/audio/VoiceCall.mp3"));
//       int loopCount = 0;
//       while (true) {
//         Vibration.vibrate(duration: 500, amplitude: 255);
//         if (loopCount % 5 == 0) {
//           DebugManager.log('play sound');
//           assetsAudioPlayer.play();
//         }
//         await Future.delayed(const Duration(seconds: 1));
//         if (!_showInvitation) break;
//       }
//
//       assetsAudioPlayer.stop();
//     } else {
//       DebugManager.log('No vibrator');
//     }
//   }
//
//   void onVoiceCallInvitationCancelled(int imGroupId) {
//     if (imGroupId != _imGroupId) return;
//
//     setState(() {
//       _showInvitation = false;
//     });
//   }
//
//   void _onHangupTap() {
//     setState(() {
//       _showInvitation = false;
//     });
//
//     NetworkManager.postRequest(
//         InnovayConfig.imNetworkConfig.sendMessage(_imGroupId),
//         {
//           'type': 'voiceCallRejection',
//           'body': '${UserModel.instance.name} 拒绝了语音通话',
//         },
//         (p0) => null,
//         (p0) => null);
//   }
//
//   void _onPickupTap() async {
//     if (Platform.isAndroid && !(await Permission.microphone.request().isGranted)) {
//       return SnackBarManager.displayMessage('您需要打开麦克风权限');
//     }
//
//     setState(() {
//       _showInvitation = false;
//
//       var url = '';
//       if (_imGroupType == 'personal') {
//         url = InnovayConfig.imNetworkConfig.personalImGroup(_inviterId);
//       }
//
//       if (url.isEmpty) {
//         return SnackBarManager.displayMessage('Invalid type: $_imGroupType');
//       }
//       InnovayGlobalData.switchLoadingOverlay(true);
//       NetworkManager.postRequest(url, {}, (res) {
//         InnovayGlobalData.switchLoadingOverlay(false);
//         InnovayGlobalData.voiceCallOverlay
//             .setMeetingRoomImGroupAndStartVoiceCall(res['data']['imGroup'], false);
//       }, (res) {
//         InnovayGlobalData.switchLoadingOverlay(false);
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return !_showInvitation
//         ? const SizedBox.shrink()
//         : Positioned(
//             top: 0,
//             left: 0,
//             child: Container(
//                 margin: EdgeInsets.only(left: 15, top: MediaQuery.of(context).padding.top, right: 15),
//                 padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
//                 width: MediaQuery.of(context).size.width - 30,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(30),
//                   color: Colors.black87,
//                 ),
//                 child: Row(children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(15),
//                     child: InnovayAvatar(InnovayConfig.mainNetworkConfig.userAvatar(_inviterId), 50),
//                   ),
//                   const SizedBox(width: 10),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       InnovayText('$_inviterName $_inviterId',
//                           fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
//                       const SizedBox(height: 5),
//                       const InnovayText(
//                         '邀请您语音通话',
//                         fontSize: 12,
//                         color: Colors.white,
//                       )
//                     ],
//                   ),
//                   const Spacer(),
//                   GestureDetector(onTap: _onHangupTap, child: Image.asset('assets/innovay/VoiceCallHangup.png')),
//                   const SizedBox(width: 30),
//                   GestureDetector(onTap: _onPickupTap, child: Image.asset('assets/innovay/VoiceCallPickup.png')),
//                 ])));
//   }
// }
