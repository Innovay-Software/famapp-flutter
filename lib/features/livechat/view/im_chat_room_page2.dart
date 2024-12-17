// import 'package:flutter/material.dart';
// import 'package:famapp/core/utils/debug_utils.dart';
// import 'package:famapp/features/livechat/viewmodel/livechat_viewmodel.dart';
// import 'package:provider/provider.dart';
//
// import '../widgets/receiver_message_widget.dart';
// import '../widgets/sender_message_widget.dart';
//
// class ImChatRoomPage2 extends StatefulWidget {
//   const ImChatRoomPage2({super.key});
//
//   @override
//   State<ImChatRoomPage2> createState() => _ImChatRoomPageState();
// }
//
// class _ImChatRoomPageState extends State<ImChatRoomPage2> with WidgetsBindingObserver {
//   final String _callbackKey = "_ImChatRoomPageState";
//   final TextEditingController controller = TextEditingController();
//   // List<LivechatMessage> messages = [];
//   bool isLoading = false;
//   final ScrollController scrollController = ScrollController();
//
//   String? error;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       initAsync();
//     });
//   }
//
//   initAsync() async {
//     if (LivechatViewmodel().currentLivechatGroup == null) {
//       return;
//     }
//
//     final currentLivechatGroup = LivechatViewmodel().currentLivechatGroup!;
//     if (currentLivechatGroup.isLocalGroup) {
//       var livechatGroup = LivechatViewmodel().currentLivechatGroup!;
//       var members = <String>[];
//       for (final item in livechatGroup.members) {
//         members.add(item.uuid);
//       }
//       LivechatViewmodel().grpcService.sendUserGeneralUpsertGroupRequest(
//             "",
//             livechatGroup.clientId,
//             livechatGroup.title,
//             livechatGroup.isGroupChat,
//             members,
//           );
//     }
//
//     // Adding callbacks
//     currentLivechatGroup.widgetUpdateCallbacks[_callbackKey] = () => setState(() {});
//   }
//
//   // void startListeningMessageRequest() {
//   //   final stream = LivechatViewmodel().grpcService.grpcClient.sendMessage(
//   //         streamController.stream,
//   //         options: LivechatViewmodel().getGRPCRequestOption(),
//   //       );
//   //   stream.listen((value) {
//   //     DebugManager.grpc("stream.listen $value");
//   //
//   //     messages.add(value);
//   //     setState(() {});
//   //   });
//   // }
//
//   void addMessage(String message) {
//     // Simulate adding a message to the stream when a button is clicked
//     LivechatViewmodel().grpcService.sendUserGeneralSendMessageRequest(
//           LivechatViewmodel().currentLivechatGroup!.id,
//           message,
//           "text",
//         );
//   }
//
//   void _sendMessage() {
//     final messageText = controller.text;
//
//     if (messageText.isNotEmpty) {
//       addMessage(messageText);
//
//       controller.clear();
//       scrollDown();
//       setState(() {});
//     }
//   }
//
//   // fetchChatsHistory() async {
//   //   final newMessages = await GRPCServiceLivechatGroup.getChatHistory(livechatGroup.id, DateTime.now());
//   //   // messages.addAll(newMessages);
//   //   setState(() {});
//   //
//   //   // DebugManager.unimplemented(message: "fetch chat history");
//   //   // try {
//   //   //   isLoading = true;
//   //   //   setState(() {});
//   //   //   final res = await ChatService.getMessages(widget.receiever.mobile);
//   //   //   messages.addAll(res);
//   //   // } catch (e) {
//   //   //   ScaffoldMessenger.of(context).showSnackBar(
//   //   //     SnackBar(
//   //   //       content: Text('Failed to get messages: $error'),
//   //   //     ),
//   //   //   );
//   //   // } finally {
//   //   //   setState(() {
//   //   //     isLoading = false;
//   //   //   });
//   //   // }
//   // }
//
//   @override
//   void dispose() {
//     controller.dispose();
//     scrollController.dispose();
//     var currentLivechatGroup = LivechatViewmodel().currentLivechatGroup!;
//     currentLivechatGroup.widgetUpdateCallbacks.remove(_callbackKey);
//     super.dispose();
//   }
//
//   void scrollDown() {
//     // scrollController.animateTo(
//     //   scrollController.position.maxScrollExtent,
//     //   duration: const Duration(seconds: 2),
//     //   curve: Curves.fastOutSlowIn,
//     // );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (LivechatViewmodel().currentLivechatGroup == null) {
//       DebugManager.error("Missing currentLivechatGroup in LivechatViewmodel!");
//       Navigator.pop(context);
//       return const SizedBox.shrink();
//     }
//     var livechatGroup = context.watch<LivechatViewmodel>().currentLivechatGroup!;
//     var livechatMessages = context.watch<LivechatViewmodel>().currentLivechatGroup!.messages;
//
//     return Scaffold(
//       // Avoid content hidden by keyboard
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         title: Text(livechatGroup.getLivechatTitle()),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             isLoading
//                 ? loadingWidget()
//                 : (error != null
//                     ? errorWidget()
//                     : livechatMessages.isNotEmpty
//                         ? Expanded(
//                             child: ListView.builder(
//                                 shrinkWrap: true,
//                                 controller: scrollController,
//                                 itemCount: livechatMessages.length,
//                                 itemBuilder: ((context, index) {
//                                   final message = livechatMessages[index];
//                                   bool isOwn = message.owner == LivechatViewmodel().currentUser.first.uuid;
//                                   return isOwn
//                                       ? SentMessageScreen(
//                                           message: message,
//                                         )
//                                       : ReceivedMessageScreen(message: message);
//                                 })),
//                           )
//                         : const Expanded(
//                             child: Center(
//                               child: Text("No message found,start conversion with 'hi' "),
//                             ),
//                           )),
//             Container(
//               height: 80,
//               width: MediaQuery.of(context).size.width,
//               color: Colors.transparent,
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
//                       margin: const EdgeInsets.only(left: 10, right: 10),
//                       child: TextField(
//                         maxLines: null,
//                         controller: controller,
//                         enabled: !isLoading,
//                         decoration: InputDecoration(
//                             prefixIcon: IconButton(
//                               onPressed: () {},
//                               icon: const Icon(Icons.message),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(16),
//                                 borderSide: const BorderSide(color: Colors.black)),
//                             suffixIcon: IconButton(
//                                 onPressed: () {
//                                   _sendMessage();
//                                 },
//                                 icon: const Icon(Icons.send)),
//                             hintText: 'Reply to this wave'),
//                         onChanged: (value) {
//                           if (value.isNotEmpty) {}
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   loadingWidget() => const Center(child: CircularProgressIndicator());
//   errorWidget() => Center(child: Text(error ?? "Something went wrong", style: const TextStyle(color: Colors.red)));
// }
