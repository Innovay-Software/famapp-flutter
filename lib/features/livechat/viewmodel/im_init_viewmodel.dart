// import '../../../core/abstracts/inno_viewmodel.dart';
// import '../../../core/utils/debug_utils.dart';
// import 'datasources/im_local_realm_datasource.dart';
// import 'usecases/get_im_groups_from_cloud.dart';
// import 'usecases/get_im_messages_from_cloud.dart';
//
// class ImInitViewmodel extends InnoViewmodel {
//   static final ImInitViewmodel _instance = ImInitViewmodel._internal();
//   factory ImInitViewmodel() => _instance;
//   ImInitViewmodel._internal();
//
//   Future<bool> purgeDataAndSyncFromCloud() async {
//     final datasource = ImLocalDatasourceRealm.instance;
//     await datasource.purgeData();
//     return await fullSynchronizationFromCloud();
//   }
//
//   Future<bool> fullSynchronizationFromCloud() async {
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
// }
