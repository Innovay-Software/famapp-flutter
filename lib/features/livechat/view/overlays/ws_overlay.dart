// import 'dart:convert';
//
// import 'package:dart_pusher_channels/dart_pusher_channels.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// import '../../../../core/config.dart';
// import '../../../../core/global_data.dart';
// import '../../../../core/services/websocket_service.dart';
// import '../../../../core/utils/common_utils.dart';
// import '../../../../core/utils/debug_utils.dart';
// import '../../../../core/utils/snack_bar_manager.dart';
// import '../../../settings/viewmodel/user_viewmodel.dart';
// import '../../viewmodel/im_init_viewmodel.dart';
// import '../../viewmodel/im_viewmodel.dart';
//
// class WsOverlay extends StatefulWidget {
//   const WsOverlay({super.key});
//
//   @override
//   State<WsOverlay> createState() => _WsOverlayState();
// }
//
// class _WsOverlayState extends State<WsOverlay> with WidgetsBindingObserver {
//   final UserViewmodel _userViewmodel = UserViewmodel();
//   final ImViewmodel _imViewmodel = ImViewmodel();
//   final ImInitViewmodel _imInitViewmodel = ImInitViewmodel();
//   final bool _usingEchoInstance = false;
//   bool _isInitialized = false;
//   String _wsUrl = '';
//   WebViewController? _webViewController;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     InnoGlobalData.wsInitialization = _forceInitWebsocketConnection;
//   }
//
//   @override
//   void dispose() {
//     if (_webViewController != null) {
//       _webViewController!.runJavaScript('disconnect();');
//       _webViewController = null;
//     }
//     super.dispose();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     DebugManager.log("imWsOverlay.didChangeAppLifecycleState ${state.toString()}");
//     switch (state) {
//       case AppLifecycleState.resumed:
//         DebugManager.log("app in resumed");
//         // _imInitViewmodel.fullSynchronizationFromCloud();
//         break;
//       case AppLifecycleState.inactive:
//         DebugManager.log("app in inactive");
//         break;
//       case AppLifecycleState.paused:
//         DebugManager.log("app in paused");
//         break;
//       case AppLifecycleState.detached:
//         DebugManager.log("app in detached");
//         break;
//       case AppLifecycleState.hidden:
//         DebugManager.log("app hidden");
//         break;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Widget child = const SizedBox.shrink();
//
//     if (_wsUrl.isNotEmpty && _webViewController != null) {
//       var isScreenWidthMode = true;
//       var width = isScreenWidthMode ? MediaQuery.of(context).size.width : 18.0;
//       var height = 3.0;
//       child = Positioned(
//         left: isScreenWidthMode ? 0 : (MediaQuery.of(context).size.width - width) / 2,
//         right: isScreenWidthMode ? 0 : null,
//         top: 0, // MediaQuery.of(context).padding.top - height,
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(100),
//           child: SizedBox(
//             width: width,
//             height: height,
//             child: WebViewWidget(controller: _webViewController!),
//           ),
//         ),
//       );
//     }
//
//     return Stack(children: [
//       child,
//     ]);
//   }
//
//   Future<bool> _forceInitWebsocketConnection(dynamic data) async {
//     DebugManager.log("WsOverlay: _initWebsocketConnection");
//     if (mounted) setState(() {});
//     DebugManager.log("_initWebsocketConnection", repeatTime: 3);
//     if (_usingEchoInstance) {
//       // Using flutter plugin echo instance
//       // it currently has an issue: events in public channel can be received, but events from private channels can't
//       // cloud not figure out the issue, might be a bug in the plugin package it self?
//       // pong events can be received successfully in the private channel, just not triggered events
//       // Therefore disabling it for now, and use the backup plan instead
//       final isSuccessful = await _imInitViewmodel.fullSynchronizationFromCloud();
//       if (!isSuccessful) {
//         return false;
//       }
//       _createEchoChannel();
//     } else {
//       // Using a webpage from backend that contains echo instance
//       // a backup plan that works
//       final isSuccessful = await _imInitViewmodel.fullSynchronizationFromCloud();
//       if (!isSuccessful) {
//         return false;
//       }
//       _createWebViewController();
//     }
//     _isInitialized = true;
//     if (mounted) setState(() {});
//     return true;
//   }
//
//   void _createEchoChannel() {
//     final user = _userViewmodel.currentUser;
//     var websocketServicePrivate = WebsocketService.createPrivateChannel('private.im.center.${user.id}');
//     // var websocketServicePublic = WebsocketService.createPublicChannel('public.im.center.${UserModel.instance.id}');
//   }
//
//   void _onEchoEventReceived(ChannelReadEvent event) {
//     try {
//       DebugManager.log("Received new echo event: ${event.channelName}");
//
//       var messageObj = event.tryGetDataAsMap();
//       if (messageObj == null) return;
//
//       if (messageObj.containsKey('type') && messageObj['type'] == 'subscribed') {
//         InnoGlobalData.isWebsocketConnected = true;
//         SnackBarManager.displayMessage('Connected', seconds: 1);
//
//         if (!mounted) return;
//         setState(() {});
//       } else if (messageObj.containsKey('notifications')) {
//         DebugManager.log("Notifications");
//         InnoGlobalData.notificationService.syncRawData(messageObj['notifications']);
//       } else {
//         DebugManager.log("Other");
//         _imViewmodel.wsUpdateCallback(messageObj);
//       }
//     } catch (e) {
//       DebugManager.error('_onEchoEventReceived error');
//       DebugManager.error(e.toString());
//     }
//   }
//
//   void _createWebViewController() {
//     if (!mounted) {
//       return;
//     }
//
//     if (!InnoGlobalData.isConnectedToInternet) {
//       return;
//     }
//
//     final user = _userViewmodel.currentUser;
//     if (_wsUrl.isEmpty) {
//       _wsUrl = InnoConfig.imNetworkConfig.imCenterPrivateWsPage();
//     }
//     SnackBarManager.displayMessage('IM server connecting ...', seconds: 4);
//
//     _webViewController = CommonUtils.createWebViewController(
//       // '$_wsUrl?token=${UserModel.instance.accessToken}',
//       _wsUrl,
//       {'Authorization': 'Bearer ${user.getAccessToken()}'},
//       // {},
//       'WsCallback',
//       _webviewJsReceiver,
//       (url) {},
//     );
//   }
//
//   void _webviewJsReceiver(JavaScriptMessage receivedMessage) {
//     var messageObj = jsonDecode(receivedMessage.message) ?? {};
//     DebugManager.log("Received WsCallback Message:");
//     DebugManager.log(messageObj.toString());
//     if (messageObj.containsKey('type') && messageObj['type'].toString().startsWith('connected')) {
//       InnoGlobalData.isWebsocketConnected = true;
//       SnackBarManager.displayMessage('Connected', seconds: 1);
//       if (mounted) {
//         setState(() {});
//       }
//     } else if (messageObj.containsKey('type') && messageObj['type'] == 'disconnected') {
//       InnoGlobalData.isWebsocketConnected = true;
//       SnackBarManager.displayMessage('Disconnected', seconds: 1);
//       if (mounted) {
//         setState(() {});
//       }
//     } else if (messageObj.containsKey('notifications')) {
//       InnoGlobalData.notificationService.syncRawData(messageObj['notifications']);
//     } else {
//       _imViewmodel.wsUpdateCallback(messageObj);
//     }
//   }
// }
