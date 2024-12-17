// import '../../../core/abstracts/inno_viewmodel.dart';
// import '../../../core/global_data.dart';
// import '../../../core/utils/debug_utils.dart';
// import '../../settings/viewmodel/user_viewmodel.dart';
// import '../model/livechat_group.dart';
// import '../model/livechat_message.dart';
// import '../model/livechat_user.dart';
// import 'datasources/im_local_realm_datasource import 'im_group_viewmodel.dart';
// import 'usecases/create_im_group_in_cloud.dart';
// import 'usecases/get_im_groups_from_cloud.dart';
// import 'usecases/get_im_messages_from_cloud.dart';
//
// class ImViewmodel extends InnoViewmodel {
//   static final ImViewmodel _instance = ImViewmodel._internal();
//   factory ImViewmodel() => _instance;
//   ImViewmodel._internal();
//
//   final UserViewmodel _userViewmodel = UserViewmodel();
//   final Map<int, LivechatUserModel> imUserMap = {};
//   final List<LivechatGroupModel> imGroupList = [];
//
//   Future<void> init({bool reloadMessages = true}) async {
//     final localDatasource = ImLocalDatasourceRealm.instance;
//
//     // Cache all users
//     imUserMap.clear();
//     final imUsersData = await localDatasource.getAllImUsers();
//     for (var item in imUsersData) {
//       var userId = int.tryParse('${item['id']}') ?? 0;
//       if (userId <= 0) {
//         continue;
//       }
//       imUserMap[userId] = LivechatUserModel.fromJson(item);
//     }
//
//     // Get all imGroups from imGroupUsers
//     imGroupList.clear();
//     final userId = UserViewmodel().currentUser.id;
//     final imGroupsData = await localDatasource.getAllImGroupsForUser(userId);
//     for (var item in imGroupsData) {
//       // Sync imGroups
//       final imGroupId = int.tryParse('${item['id']}') ?? 0;
//       final imGroupUsers = await localDatasource.getAllImGroupUsers(imGroupId);
//       final imGroup = LivechatGroupModel.fromJson(item, imGroupUsers, imUserMap);
//       imGroupList.add(imGroup);
//     }
//
//     await createEmptyImGroupsForNonChatters();
//     notifyListeners();
//   }
//
//   Future<void> createEmptyImGroupsForNonChatters() async {
//     // Remove non chatter ImGroups
//     for (var i = 0; i < imGroupList.length; i++) {
//       if (imGroupList[i].id <= 0) {
//         imGroupList.removeAt(i);
//         i--;
//       }
//     }
//
//     // Get current chatterIds
//     final createdChatterIds = <int>[];
//     for (var imGroup in imGroupList) {
//       if (imGroup.isGroupChat) {
//         continue;
//       }
//       var nonSelfMembers = imGroup.getNonSelfMembers();
//       if (nonSelfMembers.isNotEmpty) {
//         createdChatterIds.add(nonSelfMembers.first.id);
//       }
//     }
//
//     // Cross reference with all chatters to find non chatters
//     final allChatterIds = imUserMap.keys;
//     final missingChatterIds = allChatterIds.toSet().difference(createdChatterIds.toSet()).toList();
//     for (var chatterId in missingChatterIds) {
//       if (chatterId == _userViewmodel.currentUser.id) continue;
//       imGroupList.add(LivechatGroupModel.emptyPersonalChat(chatterId, imUserMap));
//     }
//
//     notifyListeners();
//     DebugManager.log("ImCenterService.queryImGroups completed ${imGroupList.length}");
//   }
//
//   Future<bool> createImGroupInCloud(LivechatGroupModel imGroupModel) async {
//     if (imGroupModel.id > 0) {
//       return true;
//     }
//     final chatterUserIds = imGroupModel.getNonSelfMembers().map((item) => item.id).toList();
//     final useCase = CreateImGroupInCloud();
//     final response = await useCase.call(chatterUserIds: chatterUserIds);
//     if (!validateUseCaseResponse(response)) {
//       return false;
//     }
//
//     final imGroupJsonData = response.right['data']['imGroup'];
//     final imGroupId = int.tryParse('${imGroupJsonData['id']}') ?? 0;
//     if (imGroupId == 0) {
//       DebugManager.error("ImViewmodel.createImGroupInCloud error creating imGroup in cloud: $imGroupId");
//       return false;
//     }
//
//     final localDatasource = ImLocalDatasourceRealm.instance;
//     localDatasource.saveImGroup(imGroupId, imGroupJsonData);
//
//     final selfUserId = _userViewmodel.currentUser.id;
//     final imGroupUserData = [
//       {'user_id': selfUserId},
//       ...(chatterUserIds.map((userId) => {'user_id': userId})),
//     ];
//     localDatasource.saveImGroupUser(imGroupId, false, imGroupUserData);
//
//     // var imGroupData = await db.query('im_group', where: 'id = ?', whereArgs: [imGroupId]);
//     // var imGroupUsersData = await db.query('im_group_user', where: 'im_group_id = ?', whereArgs: [imGroupId]);
//     // imGroupModel.syncData(imGroupData.first, imGroupUsersData, imUserMap);
//
//     notifyListeners();
//     return true;
//   }
//
//   Future<bool> synchronizeLatestImMessages() async {
//     final imLocalDatasource = ImLocalDatasourceRealm.instance;
//     final useCase = GetImGroupsFromCloud();
//     final response = await useCase.call();
//     if (!validateUseCaseResponse(response)) {
//       return false;
//     }
//
//     // Save ImUsers
//     final imUsersJsonData = response.right['data']['imUsers'];
//     await imLocalDatasource.saveImUsers(imUsersJsonData);
//
//     // Save ImGroups and messages
//     final imGroupsJsonData = response.right['data']['imGroups'];
//     for (var item in imGroupsJsonData) {
//       try {
//         var imGroupData = item['imGroup'];
//         var imGroupUsersData = item['imGroupUsers'];
//         var imMessagesData = item['imMessages'];
//         var hasMore = int.tryParse('${item['hasMoreMessages']}') ?? 0;
//         var imGroupId = int.tryParse('${imGroupData['id']}') ?? 0;
//         var isGroupChat = int.tryParse('${imGroupData['is_group_chat']}') ?? 0;
//
//         await imLocalDatasource.saveImGroup(imGroupId, imGroupData);
//         await imLocalDatasource.saveImGroupUser(imGroupId, isGroupChat == 1, imGroupUsersData);
//         while (true) {
//           final lastSyncedMessageId =
//               await imLocalDatasource.saveImMessages(imGroupId: imGroupId, imMessagesData: imMessagesData);
//
//           if (hasMore == 0) {
//             break;
//           }
//
//           final useCase2 = GetImMessagesFromCloud();
//           final response = await useCase2.call(imGroupId: imGroupId, afterId: lastSyncedMessageId);
//           if (!response.isRight) {
//             break;
//           }
//           imMessagesData = response.right['data']['imMessages'];
//           hasMore = int.tryParse(response.right['data']['hasMoreMessages']) ?? 0;
//         }
//       } catch (e, stacktrace) {
//         DebugManager.error(e.toString());
//         DebugManager.error(stacktrace);
//         return false;
//       }
//     }
//
//     notifyListeners();
//     return true;
//   }
//
//   void moveImGroupToTop(int imGroupId) {
//     for (var i = 0; i < imGroupList.length; i++) {
//       if (imGroupList[i].id == imGroupId) {
//         imGroupList.insert(0, imGroupList.removeAt(i));
//         break;
//       }
//     }
//     notifyListeners();
//   }
//
//   void addImGroup(int index, LivechatGroupModel imGroupModel) {
//     DebugManager.log("addImGroup $index ${imGroupModel.id}");
//     imGroupList.insert(index, imGroupModel);
//     notifyListeners();
//   }
//
//   LivechatGroupModel? getImGroup(int imGroupId) {
//     for (var item in imGroupList) {
//       if (item.id == imGroupId) {
//         return item;
//       }
//     }
//     return null;
//   }
//
//   Future<void> wsUpdateCallback(dynamic data) async {
//     try {
//       DebugManager.log('imCenterModel.wsUpdateCallback');
//       DebugManager.log(data.toString());
//       // return;
//
//       if (data.containsKey('imMessage')) {
//         var deviceToken = data['deviceToken'] ?? InnoGlobalData.deviceToken;
//         if (deviceToken == InnoGlobalData.deviceToken) {
//           DebugManager.log("Ignore self sent message: $deviceToken");
//           return;
//         }
//
//         // Create imMessage model
//         var imMessage = data['imMessage'];
//         if (imMessage.containsKey('created_at') && int.tryParse('${imMessage['created_at']}') == null) {
//           var createdAt = DateTime.tryParse('${imMessage['created_at']}') ?? DateTime.now().toUtc();
//           imMessage['created_at'] = (createdAt.millisecondsSinceEpoch / 1000).floor();
//         }
//         var imMessageModel = ImMessage.LivechatMessageModel(false, imMessage);
//         // Save imMessage data to local database
//         final imGroupViewmodel = ImGroupViewmodel();
//         await imGroupViewmodel.addImMessageToLocalDatasource(imMessageModel);
//         DebugManager.log("Saved new message to local database");
//       }
//
//       if (data.containsKey('newImGroup')) {
//         DebugManager.log("ImCenterService.wsUpdateCallback, NewImGroup received");
//         synchronizeLatestImMessages();
//         var imGroupId = int.tryParse('${data['newImGroup']['id']}') ?? 0;
//         moveImGroupToTop(imGroupId);
//       }
//     } catch (e) {
//       DebugManager.log(e.toString());
//     }
//   }
// }
