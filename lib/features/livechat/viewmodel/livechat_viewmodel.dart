import 'package:famapp/core/abstracts/inno_viewmodel.dart';
import 'package:famapp/features/livechat/model/livechat_message.dart';
import 'package:famapp/features/livechat/model/livechat_user.dart';
import 'package:famapp/features/settings/viewmodel/user_viewmodel.dart';

import '../grpc_service.dart';
import '../model/livechat_group.dart';

class LivechatViewmodel extends InnoViewmodel {
  static final LivechatViewmodel _instance = LivechatViewmodel._internal();
  factory LivechatViewmodel() => _instance;
  LivechatViewmodel._internal();

  /// First item is current User
  LivechatUserModel currentUser = LivechatUserModel.dummy();

  /// Friends
  final Map<String, LivechatUserModel> currentUserFriends = {};

  /// LivechatGroups
  final List<LivechatGroupModel> allBackendLivechatGroups = [];

  /// Local livechat groups
  final List<LivechatGroupModel> allLocalLivechatGroups = [];

  /// Map<GroupID, model>
  final Map<String, LivechatGroupModel> groupChatsMap = {};

  /// Map<UUID, model>, using UUID as the key because non-existing private chats are created as local livechatGroups
  final Map<String, LivechatGroupModel> privateChatsMap = {};

  /// GRPC service
  final GRPCService grpcService = GRPCService();
  final List<LivechatMessageModel> orphanMessages = [];

  /// Currently active livechatGroup used in chatDetail page
  LivechatGroupModel? currentLivechatGroup;

  get accessToken => UserViewmodel().currentUser.getAccessToken();

  void initViewmodel(
    LivechatUserModel user,
    List<LivechatUserModel> friends,
    List<LivechatGroupModel> groups,
  ) {
    _updateUser(user);
    _updateFriends(friends);
    _updateLivechatGroups(groups);
  }

  void _updateUser(LivechatUserModel user) {
    // First user will be the current user
    // Using an array to avoid nullable user
    currentUser = user;
  }

  void _updateFriends(List<LivechatUserModel> friends) {
    // Set Friends
    currentUserFriends.clear();
    for (final item in friends) {
      currentUserFriends[item.uuid] = item;
    }
  }

  void _updateLivechatGroups(List<LivechatGroupModel> groups) {
    allBackendLivechatGroups.clear();
    allLocalLivechatGroups.clear();
    groupChatsMap.clear();
    privateChatsMap.clear();

    // All
    allBackendLivechatGroups.addAll(groups);

    // GroupChats and PrivateChats
    for (final item in groups) {
      if (item.isGroupChat) {
        groupChatsMap[item.id] = item;
      } else {
        privateChatsMap[item.getFirstFriendUUID()] = item;
      }
    }

    // Create local livechatGroups for missing private groups:
    for (final friend in currentUserFriends.values) {
      if (privateChatsMap.containsKey(friend.uuid)) {
        continue;
      }
      var localGroup = LivechatGroupModel.createLocalGroup("", false, [friend.uuid]);
      privateChatsMap[friend.uuid] = localGroup;
      groupChatsMap[friend.uuid] = localGroup;
      allLocalLivechatGroups.add(localGroup);
    }
  }

  void logout() {
    currentUser = LivechatUserModel.dummy();
    currentUserFriends.clear();
    allBackendLivechatGroups.clear();
    allLocalLivechatGroups.clear();

    groupChatsMap.clear();
    privateChatsMap.clear();
  }

  ///
  /// Adding an updated livechatGroup, might be a new one or an existing one
  ///
  void updateGroup(LivechatGroupModel newGroup, String groupClientId) {
    var replaceIndex = -1;
    for (var i = 0; i < allBackendLivechatGroups.length; i++) {
      if (allBackendLivechatGroups[i].id == newGroup.id) {
        replaceIndex = i;
      }
    }
    if (replaceIndex >= 0) {
      allBackendLivechatGroups[replaceIndex] = newGroup;
    } else {
      // a new group, put it in front because it's just created
      allBackendLivechatGroups.insert(0, newGroup);
    }
    for (var i = 0; i < allLocalLivechatGroups.length; i++) {
      if (allLocalLivechatGroups[i].clientId == groupClientId) {
        allLocalLivechatGroups.removeAt(i);
        break;
      }
    }

    // Save it to groupChatsMap or privateChatsMap
    if (newGroup.isGroupChat) {
      groupChatsMap[newGroup.id] = newGroup;
    } else {
      privateChatsMap[newGroup.getFirstFriendUUID()] = newGroup;
    }

    // Update currentLivechatGroup if necessary
    if (currentLivechatGroup != null && currentLivechatGroup!.clientId == groupClientId) {
      currentLivechatGroup = newGroup;
    }
  }

  ///
  /// Adding a new message
  ///
  void addMessage(LivechatMessageModel livechatMessage) {
    if (groupChatsMap.containsKey(livechatMessage.groupId)) {
      groupChatsMap[livechatMessage.groupId]!.addMessage(livechatMessage);
    } else {
      for (var i = 0; i < allBackendLivechatGroups.length; i++) {
        if (allBackendLivechatGroups[i].id == livechatMessage.groupId) {
          allBackendLivechatGroups[i].addMessage(livechatMessage);
          return;
        }
      }
      orphanMessages.add(livechatMessage);
    }
  }

  // CallOptions getGRPCRequestOption() {
  //   return CallOptions(
  //     metadata: {'authorization': 'bearer $accessToken'},
  //   );
  // }

  void setCurrentLivechatGroup(LivechatGroupModel group) {
    currentLivechatGroup = group;
  }
}
