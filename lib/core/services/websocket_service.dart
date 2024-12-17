// Migrated from websocket to gRPC
// import 'dart:async';
//
// import 'package:dart_pusher_channels/dart_pusher_channels.dart';
//
// import '../../features/im/viewmodel/im_viewmodel.dart';
// import '../../features/settings/viewmodel/user_viewmodel.dart';
// import '../global_data.dart';
// import '../utils/debug_utils.dart';
// import '../utils/snack_bar_manager.dart';
//
// class WebsocketService {
//   PusherChannelsClient? client;
//   Channel? channel;
//   StreamSubscription? connectionSubs;
//
//   static PusherChannelsClient getPusherChannelsClient() {
//     const hostOptions = PusherChannelsOptions.fromHost(
//       scheme: 'wss',
//       host: 'ws.babyphotos.innovay.dev',
//       key: 'innobaby_im_pusher_key',
//       shouldSupplyMetadataQueries: true,
//       metadata: PusherChannelsOptionsMetadata.byDefault(),
//       port: 443,
//     );
//
//     final client = PusherChannelsClient.websocket(
//       options: hostOptions,
//       connectionErrorHandler: (exception, trace, refresh) {
//         DebugManager.error("connectionErrorHandler");
//         refresh();
//       },
//       // minimumReconnectDelayDuration: const Duration(seconds: 1),
//       // defaultActivityDuration: const Duration(seconds: 120),
//       // activityDurationOverride: const Duration(seconds: 120),
//       // waitForPongDuration: const Duration(seconds: 30),
//     );
//
//     return client;
//   }
//
//   static WebsocketService createPrivateChannel(String channelName) {
//     final instance = WebsocketService();
//     final user = UserViewmodel().currentUser;
//     DebugManager.log("_createEchoPrivateChannel");
//     try {
//       var client = getPusherChannelsClient();
//       instance.client = client;
//
//       var channel = client.privateChannel(
//         channelName,
//         authorizationDelegate: EndpointAuthorizableChannelTokenAuthorizationDelegate.forPrivateChannel(
//           authorizationEndpoint: Uri.parse('https://babyphotos.innovay.dev/broadcasting/auth'),
//           headers: {
//             'Authorization': 'Bearer ${user.getAccessToken()}',
//           },
//         ),
//       );
//       instance.channel = channel;
//
//       final StreamSubscription connectionSubs = client.onConnectionEstablished.listen((_) {
//         DebugManager.log("Subscribing....");
//         channel.subscribe();
//       });
//       instance.connectionSubs = connectionSubs;
//
//       channel.bindToAll().listen(instance.onEchoEventReceived);
//       client.connect();
//
//       Future.delayed(const Duration(seconds: 5)).then((value) {
//         DebugManager.log("Triggering an event");
//         channel.trigger(
//           eventName: 'client-event',
//           data: {'hello': 'Hello'},
//         );
//       });
//     } catch (e) {
//       DebugManager.error('Pusher error');
//       DebugManager.error(e.toString());
//     }
//     return instance;
//   }
//
//   static WebsocketService createPublicChannel(String channelName) {
//     var instance = WebsocketService();
//     DebugManager.log("_createEchoPublicChannel");
//     try {
//       var client = getPusherChannelsClient();
//       instance.client = client;
//
//       var channel = client.publicChannel(channelName);
//       instance.channel = channel;
//
//       final StreamSubscription connectionSubs = client.onConnectionEstablished.listen((_) {
//         channel.subscribeIfNotUnsubscribed();
//       });
//       instance.connectionSubs = connectionSubs;
//
//       channel.bindToAll().listen(instance.onEchoEventReceived);
//       client.connect();
//     } catch (e) {
//       DebugManager.error('Pusher error');
//       DebugManager.error(e.toString());
//     }
//     return instance;
//   }
//
//   void onEchoEventReceived(ChannelReadEvent event) {
//     try {
//       DebugManager.log("Received new echo event: ${event.channelName} ${event.name}");
//       DebugManager.log("Received new echo event: ${event.data.toString()}");
//
//       var messageObj = event.tryGetDataAsMap();
//       if (messageObj == null) return;
//
//       if (messageObj.containsKey('type') && messageObj['type'] == 'subscribed') {
//         InnoGlobalData.isWebsocketConnected = true;
//         SnackBarManager.displayMessage('Connected', seconds: 1);
//       } else if (messageObj.containsKey('notifications')) {
//         DebugManager.log("Notifications");
//         InnoGlobalData.notificationService.syncRawData(messageObj['notifications']);
//       } else {
//         DebugManager.log("Other");
//         ImViewmodel().wsUpdateCallback(messageObj);
//       }
//     } catch (e) {
//       DebugManager.error('_onEchoEventReceived error');
//       DebugManager.error(e.toString());
//     }
//   }
//
//   void disconnect() {
//     connectionSubs?.cancel();
//     client?.dispose();
//   }
// }
