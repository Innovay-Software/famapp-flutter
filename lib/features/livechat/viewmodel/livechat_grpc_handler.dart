// import 'package:grpc/grpc.dart';
// import 'package:famapp/core/abstracts/inno_viewmodel.dart';
// import 'package:famapp/features/livechat/model/livechat_user.dart';
// import 'package:famapp/features/settings/viewmodel/user_viewmodel.dart';
//
// import '../grpc_service.dart';
// import '../model/livechat_group.dart';
//
// class LivechatGrpcHandler extends InnoViewmodel {
//   static final LivechatGrpcHandler _instance = LivechatGrpcHandler._internal();
//   factory LivechatGrpcHandler() => _instance;
//   LivechatGrpcHandler._internal();
//
//   final List<LivechatUserModel> currentUser = [];
//   final List<LivechatUserModel> currentUserFriends = [];
//   final List<LivechatGroupModel> currentUserGroups = [];
//   final Map<String, LivechatGroupModel> privateGroups = {};
//   final GRPCService grpcService = GRPCService();
//
//   get accessToken => UserViewmodel().currentUser.getAccessToken();
//
//   void initViewmodel(
//     LivechatUserModel user,
//     List<LivechatUserModel> friends,
//     List<LivechatGroupModel> groups,
//   ) {
//     currentUser.clear();
//     currentUser.add(user);
//     currentUserFriends.clear();
//     currentUserFriends.addAll(friends);
//     currentUserGroups.clear();
//     currentUserGroups.addAll(groups);
//     _initPrivateGroupChatsMap();
//   }
//
//   void _initPrivateGroupChatsMap() {
//     privateGroups.clear();
//     for (final group in currentUserGroups) {
//       if (group.isGroupChat) {
//         continue;
//       }
//       var friendUUID = group.members[0].uuid == currentUser.first.uuid ? group.members[1].uuid : group.members[0].uuid;
//       privateGroups[friendUUID] = group;
//     }
//     for (final friend in currentUserFriends) {
//       if (privateGroups.containsKey(friend.uuid)) {
//         continue;
//       }
//       var localGroup = LivechatGroupModel(
//         "",
//         friend.name,
//         currentUser.first.uuid,
//         <LivechatUserInGroupModel>[
//           LivechatUserInGroupModel.fromLivechatUserModel(currentUser.first),
//           LivechatUserInGroupModel.fromLivechatUserModel(friend),
//         ],
//         {},
//         false,
//         "",
//         DateTime.fromMicrosecondsSinceEpoch(0),
//         DateTime.fromMicrosecondsSinceEpoch(0),
//       );
//       privateGroups[friend.uuid] = localGroup;
//       currentUserGroups.add(localGroup);
//     }
//   }
//
//   void logout() {
//     currentUser.clear();
//     currentUserFriends.clear();
//     currentUserGroups.clear();
//   }
//
//   void updateGroup(LivechatGroupModel newGroup) {
//     for (var i = 0; i < currentUserGroups.length; i++) {
//       if (currentUserGroups[i].id == newGroup.id) {
//         currentUserGroups[i] = newGroup;
//         return;
//       }
//     }
//     currentUserGroups.add(newGroup);
//   }
//
//   CallOptions getGRPCRequestOption() {
//     return CallOptions(
//       metadata: {'authorization': 'bearer $accessToken'},
//     );
//   }
// }
