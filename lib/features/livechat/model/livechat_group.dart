import 'package:famapp/core/utils/calculation_utils.dart';
import 'package:famapp/core/utils/debug_utils.dart';
import 'package:famapp/features/livechat/pb/message_livechat.pb.dart';
import 'package:famapp/features/livechat/viewmodel/livechat_viewmodel.dart';

import 'livechat_message.dart';
import 'livechat_user.dart';

///
/// Model to hold a livechatGroup object
/// Every chat is a "group",
/// A group between two people are "privateChat"
/// A group of more members are "groupChat"
/// A privateChat and a groupChat are not interchangeable,
/// they're set from creation and cannot be changed
///
class LivechatGroupModel {
  final String id;
  final String clientId;
  final String title;
  final String owner;
  final List<LivechatUserInGroupModel> members;
  final Map<String, String> metadata;
  final bool isGroupChat;
  final String lastMessage;
  final DateTime lastMessageTime;
  final DateTime createdAt;
  final List<LivechatMessageModel> messages = [];
  final Map<String, Function> widgetUpdateCallbacks = {};

  bool get isLocalGroup => id == "";

  LivechatGroupModel._(
    this.id,
    this.clientId,
    this.title,
    this.owner,
    this.members,
    this.metadata,
    this.isGroupChat,
    this.lastMessage,
    this.lastMessageTime,
    this.createdAt,
  );

  factory LivechatGroupModel.fromPBLivechatGroupModel(LivechatGroup pbLivechatGroup) {
    final List<LivechatUserInGroupModel> members = [];
    for (final item in pbLivechatGroup.members) {
      members.add(LivechatUserInGroupModel.fromPBUserInGroupModel(item));
    }

    return LivechatGroupModel._(
      pbLivechatGroup.id,
      "",
      pbLivechatGroup.title,
      pbLivechatGroup.owner,
      members,
      pbLivechatGroup.metadata,
      pbLivechatGroup.isGroupChat,
      pbLivechatGroup.lastMessage,
      pbLivechatGroup.lastMessageTime.toDateTime(),
      pbLivechatGroup.createdAt.toDateTime(),
    );
  }

  factory LivechatGroupModel.createLocalGroup(String title, bool isGroupChat, List<String> membersUuids) {
    final members = <LivechatUserInGroupModel>[
      LivechatUserInGroupModel.fromLivechatUserModel(LivechatViewmodel().currentUser)
    ];
    final viewModel = LivechatViewmodel();
    final selfUuid = viewModel.currentUser.uuid;
    for (final item in membersUuids) {
      if (item == selfUuid) {
        continue;
      }
      if (viewModel.currentUserFriends.containsKey(item)) {
        members.add(LivechatUserInGroupModel.fromLivechatUserModel(viewModel.currentUserFriends[item]!));
      }
    }

    return LivechatGroupModel._(
      "",
      CalculationUtils.randomString(20),
      title,
      selfUuid,
      members,
      {},
      isGroupChat,
      "",
      DateTime.now(),
      DateTime.now(),
    );
  }

  String getLivechatTitle() {
    final userUUID = LivechatViewmodel().currentUser.uuid;
    if (isGroupChat) {
      return title;
    }
    for (final member in members) {
      if (member.uuid != userUUID) {
        return member.name;
      }
    }
    return members.isEmpty ? "-" : members.first.name;
  }

  List<String> getMemberUUIDList() {
    final memberUuids = <String>[];
    for (final item in members) {
      memberUuids.add(item.uuid);
    }
    return memberUuids;
  }

  String getMemberAvatar(String memberUUID) {
    for (final member in members) {
      if (member.uuid == memberUUID) {
        return member.avatar;
      }
    }
    return "";
  }

  String getMemberName(String memberUUID) {
    for (final member in members) {
      if (member.uuid == memberUUID) {
        return member.name;
      }
    }
    return "";
  }

  ///
  /// Returns the first non-self user's UUID
  /// If not exist, returns self user's UUID
  ///
  String getFirstFriendUUID() {
    final userUUID = LivechatViewmodel().currentUser.uuid;
    for (final member in members) {
      if (member.uuid != userUUID) {
        return member.uuid;
      }
    }
    return userUUID;
  }

  void addMessage(LivechatMessageModel newMessage) {
    if (messages.isEmpty) {
      messages.add(newMessage);
    } else {
      // Messages should be in reverse chronological order
      var inserted = false;
      for (var i = 0; i < messages.length; i++) {
        if (messages[i].createdAt.compareTo(newMessage.createdAt) < 0) {
          messages.insert(i, newMessage);
          inserted = true;
          break;
        }
      }
      if (!inserted) {
        messages.add(newMessage);
      }
    }
    DebugManager.log("widgetUpdateCallbacks : ${widgetUpdateCallbacks.length}");
    widgetUpdateCallbacks.forEach((k, v) => v());
  }
  //
  // // ImGroup(
  // //   Map<String, dynamic> imGroupData,
  // //   List<Map<String, dynamic>> imGroupUsersData,
  // //   Map<int, ImUserModel> imUserMap,
  // // ) {
  // //   syncData(imGroupData, imGroupUsersData, imUserMap);
  // // }
  //
  // factory ImGroup.fromJson(
  //   Map<String, dynamic> imGroupJson,
  //   List<Map<String, dynamic>> imGroupUsersJson,
  //   Map<int, ImUserModel> imUserMap,
  // ) {
  //   final imGroup = ImGroup._();
  //   imGroup.syncData(imGroupJson, imGroupUsersJson, imUserMap);
  //   return imGroup;
  // }
  //
  // factory ImGroup.emptyPersonalChat(
  //   int chatterUserId,
  //   Map<int, ImUserModel> imUserMap,
  // ) {
  //   return ImGroup.fromJson(
  //     {'id': 0, 'latest_message': ''},
  //     [
  //       {'id': 0, 'im_group_id': 0, 'user_id': chatterUserId},
  //       {'id': 0, 'im_group_id': 0, 'user_id': UserViewmodel().currentUser.id}
  //     ],
  //     imUserMap,
  //   );
  // }
  //
  // void syncData(
  //   Map<String, dynamic> imGroupData,
  //   List<Map<String, dynamic>> imGroupUsersData,
  //   Map<int, ImUserModel> imUserMap,
  // ) {
  //   id = int.tryParse('${imGroupData['id']}') ?? 0;
  //   ownerId = int.tryParse('${imGroupData['owner_id']}') ?? 0;
  //
  //   cloudGroupId = '${imGroupData['cloud_group_id'] ?? ''}';
  //   imGroupTitle = '${imGroupData['title'] ?? ''}';
  //   latestMessage = '${imGroupData['latest_message'] ?? ''}';
  //   isGroupChat = '${imGroupData['is_group_chat']}' == '1';
  //
  //   memberList.clear();
  //   for (var item in imGroupUsersData) {
  //     var userId = int.tryParse('${item['user_id']}') ?? 0;
  //     if (imUserMap.containsKey(userId)) {
  //       memberList.add(imUserMap[userId]!);
  //     }
  //   }
  // }
  //
  // bool isOwnerSelf() {
  //   return ownerId == _userViewmodel.currentUser.id;
  // }
  //
  // List<int> getMemberIds() {
  //   return memberList.map((e) => e.id).toList();
  // }
  //
  // ImUserModel firstNonSelfMember() {
  //   return getNonSelfMembers().first;
  // }
  //
  // List<ImUserModel> getNonSelfMembers() {
  //   var imUsers = <ImUserModel>[];
  //   for (var item in memberList) {
  //     if (item.id == _userViewmodel.currentUser.id) continue;
  //     imUsers.add(item);
  //   }
  //   return imUsers;
  // }
  // //
  // // Future<void> syncLatestMessages(Function() successCallback) async {
  // //   InnovayGlobalData.switchLoadingOverlay(true);
  // //
  // //   try {
  // //     var res = await NetworkManager.postRequestSync(
  // //       InnovayConfig.imNetworkConfig.latestImGroupMessages(id, syncedLatestMessageId),
  // //       {},
  // //     );
  // //
  // //     var newMessages = <ImMessageModel>[];
  // //     for (var item in res['data']['messages']) {
  // //       newMessages.add(ImMessageModel(false, item));
  // //     }
  // //
  // //     var messageIndex = messages.length - 1;
  // //     var newMessageIndex = newMessages.length - 1;
  // //
  // //     while (messageIndex >= 0 && newMessageIndex >= 0) {
  // //       if (newMessageIndex < 0) break;
  // //       if (messageIndex < 0) {
  // //         messages.insert(0, newMessages[newMessageIndex]);
  // //         newMessageIndex -= 1;
  // //         continue;
  // //       }
  // //
  // //       var currentMessage = messages[messageIndex];
  // //       var currentNewMessage = newMessages[newMessageIndex];
  // //
  // //       if (currentNewMessage.id > currentMessage.id) {
  // //         messages.insert(messageIndex + 1, currentNewMessage);
  // //         newMessageIndex -= 1;
  // //       } else if (currentNewMessage.id == currentMessage.id) {
  // //         newMessageIndex -= 1;
  // //       } else {
  // //         messageIndex -= 1;
  // //       }
  // //     }
  // //
  // //     syncedLatestMessageId = messages.last.id;
  // //
  // //     if (messages.length < 50) {
  // //       await getMessages(false, () {});
  // //     }
  // //   } on ApiException catch (e) {
  // //     DebugManager.error(e.errorMessage());
  // //   } catch (e) {
  // //     DebugManager.error(e.toString());
  // //   }
  // //
  // //   InnovayGlobalData.switchLoadingOverlay(false);
  // //   successCallback();
  // // }
  // //
  // // Future<bool> deleteImMessages(Map<int, int> targetImMessageIdsMap) async {
  // //   final datasource = ImLocalDatasource.instance;
  // //   await datasource.deleteImMessages(imGroupId: id, messageIds: targetImMessageIdsMap.keys.toList());
  // //   return true;
  // // }
  //
  // // void addImMessage(ImMessageModel newImMessageModel) {
  // //   // DebugManager.log('ImGroupModel.addImMessage: ${newImMessageModel.id} ${newImMessageModel.userId} ${newImMessageModel.userName}');
  // //   for (var i = messages.length - 1; i >= 0; i--) {
  // //     if (newImMessageModel.id < messages[i].id) {
  // //       messages.insert(i + 1, newImMessageModel);
  // //       return;
  // //     }
  // //   }
  // //   messages.add(newImMessageModel);
  // //   latestMessage = '${newImMessageModel.userName}: ';
  // //   if (newImMessageModel.type == ImMessageType.image) {
  // //     latestMessage += '[图片]';
  // //   } else if (newImMessageModel.type == ImMessageType.video) {
  // //     latestMessage += '[视频]';
  // //   } else {
  // //     latestMessage += newImMessageModel.body;
  // //   }
  // // }
  //
  // // Future<ImGroupModel> createImGroup() async {
  // //   if (id != 0) {
  // //     DebugManager.log("ImGroup already exist in cloud, no need to create");
  // //     return this;
  // //   }
  // //
  // //   try {
  // //     var newImGroup = await ImUtil.getPersonalImGroup(singleChatterId);
  // //     var imCenterService = ImCenterService.instance;
  // //     imCenterService.imGroupList.remove(this);
  // //     imCenterService.addImGroup(0, newImGroup);
  // //     return newImGroup;
  // //   } catch (e) {
  // //     await Future.delayed(const Duration(seconds: 1));
  // //     return createImGroup();
  // //   }
  // // }
  //
  // void leaveImGroup(Function() onSuccessCallback) {
  //   throw Exception('needs implementation');
  //   // InnovayGlobalData.switchLoadingOverlay(true);
  //   // NetworkManager.postRequest(
  //   //   InnovayConfig.imNetworkConfig.leaveImGroup(id),
  //   //   {},
  //   //   (res) {
  //   //     InnovayGlobalData.switchLoadingOverlay(false);
  //   //     memberList.removeWhere((e) => e.id == UserModel.instance.id);
  //   //     onSuccessCallback();
  //   //   },
  //   //   (res) {
  //   //     InnovayGlobalData.switchLoadingOverlay(false);
  //   //   },
  //   // );
  // }
}
