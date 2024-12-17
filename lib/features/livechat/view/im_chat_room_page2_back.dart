// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:famapp/core/utils/debug_utils.dart';
// import 'package:famapp/features/livechat/model/livechat_group.dart';
// import 'package:famapp/features/livechat/pb/message_livechat.pb.dart';
// import 'package:famapp/features/livechat/pb/rpc_livechat.pb.dart';
// import 'package:famapp/features/livechat/viewmodel/livechat_viewmodel.dart';
//
// import '../grpc_service_livechat_group.dart';
// import '../widgets/receiver_message_widget.dart';
// import '../widgets/sender_message_widget.dart';
//
// class ImChatRoomPage2 extends StatefulWidget {
//   final LivechatGroupModel livechatGroup;
//   const ImChatRoomPage2({super.key, required this.livechatGroup});
//
//   @override
//   State<ImChatRoomPage2> createState() => _ImChatRoomPageState();
// }
//
// class _ImChatRoomPageState extends State<ImChatRoomPage2> with WidgetsBindingObserver {
//   late LivechatGroupModel _livechatGroup;
//   final TextEditingController controller = TextEditingController();
//   List<LivechatMessage> messages = [];
//   bool isLoading = false;
//   final StreamController<SendMessageRequest> streamController = StreamController<SendMessageRequest>();
//   final ScrollController scrollController = ScrollController();
//
//   String? error;
//
//   @override
//   void initState() {
//     super.initState();
//     _livechatGroup = widget.livechatGroup;
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       initAsync();
//     });
//   }
//
//   initAsync() async {
//     if (_livechatGroup.id.isEmpty) {
//       final memberUuids = _livechatGroup.getMemberUUIDList();
//       final newGroup = await GRPCServiceLivechatGroup.createLivechatGroup("Group Chat", memberUuids);
//       setState(() {
//         _livechatGroup = newGroup;
//       });
//     }
//     await fetchChatsHistory();
//     startListeningMessageRequest();
//     // addMessage("Join_room");
//   }
//
//   void startListeningMessageRequest() {
//     final stream = LivechatViewmodel().grpcService.grpcClient.sendMessage(
//           streamController.stream,
//           options: LivechatViewmodel().getGRPCRequestOption(),
//         );
//     stream.listen((value) {
//       DebugManager.grpc("stream.listen $value");
//
//       messages.add(value);
//       setState(() {});
//     });
//   }
//
//   void addMessage(String message) {
//     // Simulate adding a message to the stream when a button is clicked
//     final req = SendMessageRequest(
//       groupId: _livechatGroup.id,
//       content: message,
//       type: "text",
//     );
//     streamController.sink.add(req);
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
//   fetchChatsHistory() async {
//     final newMessages = await GRPCServiceLivechatGroup.getChatHistory(_livechatGroup.id, DateTime.now());
//     messages.addAll(newMessages);
//     setState(() {});
//
//     // DebugManager.unimplemented(message: "fetch chat history");
//     // try {
//     //   isLoading = true;
//     //   setState(() {});
//     //   final res = await ChatService.getMessages(widget.receiever.mobile);
//     //   messages.addAll(res);
//     // } catch (e) {
//     //   ScaffoldMessenger.of(context).showSnackBar(
//     //     SnackBar(
//     //       content: Text('Failed to get messages: $error'),
//     //     ),
//     //   );
//     // } finally {
//     //   setState(() {
//     //     isLoading = false;
//     //   });
//     // }
//   }
//
//   @override
//   void dispose() {
//     streamController.close();
//     controller.dispose();
//     scrollController.dispose();
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
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         title: Text(_livechatGroup.getLivechatTitle()),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             isLoading
//                 ? loadingWidget()
//                 : (error != null
//                     ? errorWidget()
//                     : messages.isNotEmpty
//                         ? Expanded(
//                             child: ListView.builder(
//                                 shrinkWrap: true,
//                                 controller: scrollController,
//                                 itemCount: messages.length,
//                                 itemBuilder: ((context, index) {
//                                   LivechatMessage message = messages[index];
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
