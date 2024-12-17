// import 'package:flutter/cupertino.dart';
// import 'package:tencent_trtc_cloud/trtc_cloud.dart';
// import 'package:tencent_trtc_cloud/trtc_cloud_def.dart';
// import 'package:tencent_trtc_cloud/trtc_cloud_listener.dart';
// import 'package:tim_ui_kit/tim_ui_kit.dart';
// import '../passcode_overlay.dart';
// import '../utils/snack_bar_manager.dart';
// import '../utils/trtc/meeting_model.dart';
//
// import 'debug_utils.dart';
//
// class ImVoiceCallUtil {
//   VoiceCallPhase currentPhase = VoiceCallPhase.notConntected;
//   int imGroupId = 0;
//   TRTCCloud? trtcCloud;
//   MeetingModel meetModel = MeetingModel();
//
//   void onVoiceButtonTap(int imGroupId, Function() successCallback) {
//     DebugManager.Log('ImVoiceCallUtil.onCallButtonTap $imGroupId');
//     switch (currentPhase) {
//       case VoiceCallPhase.notConntected:
//         this.imGroupId = imGroupId;
//         startVoiceCall(successCallback);
//         break;
//       case VoiceCallPhase.dialing:
//         // endVoiceCall();
//         break;
//       case VoiceCallPhase.connected:
//         // endVoiceCall();
//         break;
//     }
//   }
//
//   void startVoiceCall(Function() successCallback) async {
//     // var result = await Permission.camera.request();
//     // DebugManager.Log(result.toString());
//     //
//     // if (!(await Permission.camera.request().isGranted)) {
//     //   return SnackBarManager.displayMessage('您需要授权摄像头权限才能进行语音通话');
//     // }
//     // if (!(await Permission.microphone.request().isGranted)) {
//     //   return SnackBarManager.displayMessage('您需要授权麦克风权限才能进行语音通话');
//     // }
//
//     meetModel.setUserSetting({
//       "meetId": imGroupId,
//       "userId": globalData.tencentImConfig['userId'],
//       "userSig": globalData.tencentImConfig['userSig'],
//       "enabledCamera": false,
//       "enabledMicrophone": true,
//       "quality": TRTCCloudDef.TRTC_AUDIO_QUALITY_SPEECH,
//     });
//     successCallback();
//
//     // // Create TRTCCloud singleton
//     // trtcCloud = await TRTCCloud.sharedInstance();
//     // // // Tencent Cloud Audio Effect Management Module
//     // // var txDeviceManager = trtcCloud?.getDeviceManager();
//     // // // Beauty filter and animated effect parameter management
//     // // var txBeautyManager = trtcCloud?.getBeautyManager();
//     // // // Tencent Cloud Audio Effect Management Module
//     // // var txAudioManager = trtcCloud?.getAudioEffectManager();
//     //
//     // // Register a listener
//     // trtcCloud?.registerListener(onRtcListener);
//     //
//     // // Room entry/exit
//     // trtcCloud?.enterRoom(
//     //     TRTCParams(
//     //         sdkAppId: globalConfig.tencentImSdkAppId,
//     //         userId: globalData.tencentImConfig['userId'],
//     //         userSig: globalData.tencentImConfig['userSig'],
//     //         roomId: imGroupId),
//     //     TRTCCloudDef.TRTC_APP_SCENE_VIDEOCALL);
//     //
//     // currentPhase = VoiceCallPhase.dialing;
//   }
//
//   // void endVoiceCall() async {
//   //   trtcCloud?.exitRoom();
//   //   trtcCloud?.unRegisterListener(onRtcListener);
//   // }
//   //
//   // void onRtcListener(TRTCCloudListener type, param) {
//   //   // Callback for room entry
//   //   if (type == TRTCCloudListener.onEnterRoom) {
//   //     currentPhase = VoiceCallPhase.connected;
//   //     if (param > 0) {
//   //       DebugManager.Log('User enter the room successfully');
//   //       SnackBarManager.displayMessage('Entered the room successfully');
//   //     }
//   //   }
//   //   // Callback for the entry of a remote user
//   //   if (type == TRTCCloudListener.onRemoteUserEnterRoom) {
//   //     // The parameter is the user ID of the remote user.
//   //     DebugManager.Log('new user joined the room successfully');
//   //     SnackBarManager.displayMessage('new user joined the room');
//   //   }
//   //   // Whether the remote user has a playable primary image (generally for camera)
//   //   if (type == TRTCCloudListener.onUserVideoAvailable) {
//   //     //param['userId'] is the user ID of the remote user
//   //     //param['visible'] indicates whether image is enabled
//   //     DebugManager.Log(
//   //         'onUserVideoAvailable ${param['userId']} ${param['visible']}');
//   //     SnackBarManager.displayMessage('onUserVideoAvailable');
//   //   }
//   // }
//
//   Widget generateImWindowVoiceCallSection(int imGroupId) {
//     return Container();
//     // return Container(
//     //     color: const Color(0xFFE8F0F7), //  globalConfig.colors.backgroundColor,
//     //     padding: const EdgeInsets.only(bottom: 50),
//     //     child: Row(
//     //         mainAxisAlignment: MainAxisAlignment.center,
//     //         crossAxisAlignment: CrossAxisAlignment.center,
//     //         children: [
//     //           GestureDetector(
//     //               onTap: () { onVoiceButtonTap(imGroupId); },
//     //               child: Image.asset('assets/ui/VoiceChat.png',
//     //                   width: 80, height: 80, fit: BoxFit.contain))
//     //         ]));
//   }
// }
