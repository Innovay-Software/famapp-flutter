// import 'package:famapp/features/livechat/viewmodel/datasources/im_local_realm_datasource.dart';
//
// import '../../../core/abstracts/inno_viewmodel.dart';
// import '../../../core/utils/debug_utils.dart';
// import '../model/livechat_group.dart';
// import '../model/livechat_message.dart';
// import 'usecases/create_im_message_in_cloud.dart';
//
// class ImGroupViewmodel extends InnoViewmodel {
//   static final ImGroupViewmodel _instance = ImGroupViewmodel._internal();
//   factory ImGroupViewmodel() => _instance;
//   ImGroupViewmodel._internal();
//
//   final ImLocalDatasourceRealm _imLocalDatasource = ImLocalDatasourceRealm.instance;
//   LivechatGroupModel? imGroup;
//   List<ImMessage> imMessages = [];
//
//   void init({required LivechatGroupModel imGroup}) {
//     this.imGroup = imGroup;
//     imMessages.clear();
//     // notifyListeners();
//   }
//
//   void clearImGroup() {
//     imGroup = null;
//     imMessages.clear();
//     notifyListeners();
//   }
//
//   Future<void> getLatestMessages({int limit = 1000}) async {
//     imMessages.clear();
//     await getPreviousMessages(limit: limit);
//   }
//
//   Future<void> getMessages({int limit = 100}) async {
//     if (imGroup == null) {
//       return;
//     }
//
//     final afterId = imMessages.isEmpty ? 0 : imMessages.last.id;
//     final messagesData = await _imLocalDatasource.getImGroupMessagesAfterId(
//       imGroupId: imGroup!.id,
//       afterId: afterId,
//       limit: limit,
//     );
//     for (var messageData in messagesData) {
//       imMessages.insert(0, ImMessage.LivechatMessageModel(false, messageData));
//     }
//     notifyListeners();
//   }
//
//   Future<void> getPreviousMessages({int limit = 100}) async {
//     if (imGroup == null) {
//       return;
//     }
//
//     final beforeId = imMessages.isEmpty ? 999999999 : imMessages.first.id;
//     final messagesData = await _imLocalDatasource.getImGroupMessagesBeforeId(
//       imGroupId: imGroup!.id,
//       beforeId: beforeId,
//       limit: limit,
//     );
//     for (var messageData in messagesData) {
//       imMessages.insert(0, ImMessage.LivechatMessageModel(false, messageData));
//     }
//     notifyListeners();
//   }
//
//   Future<bool> sendImMessage(ImMessage imMessage) async {
//     /// A positive id indicates this message is already in the cloud.
//     if (!imMessage.isLocalMessage) {
//       // if it's not a local message, meaning it was already uploaded to cloud
//       return true;
//     }
//
//     /// if this is an media message (image, audio, video),
//     /// upload it to cloud, then send the url as the message body
//     if (imMessage.type.isMedia) {
//       if (imMessage.fileUploadItem == null) {
//         DebugManager.error("Media im message type with null FileUploadItem");
//         return false;
//       }
//       final imageUploadItem = imMessage.fileUploadItem!;
//       if (!imageUploadItem.isUploaded) {
//         if (!imageUploadItem.isUploading) {
//           imMessages.add(imMessage);
//           notifyListeners();
//           final response = await imageUploadItem.uploadToCloudSync(useChunkUpload: true);
//           if (!imageUploadItem.isUploaded) {
//             DebugManager.error("Image upload item ERROR");
//             return false;
//           }
//
//           imMessage.body = response.fileUrl;
//         }
//       }
//     } else {
//       imMessages.add(imMessage);
//     }
//
//     if (imMessage.isSendingMessageToCloud) return false;
//     imMessage.isSendingMessageToCloud = true;
//
//     final useCase = CreateImMessageInCloud();
//     final response = await useCase.call(imMessage: imMessage);
//     if (!validateUseCaseResponse(response)) {
//       imMessage.isSendingMessageToCloud = false;
//       imMessage.isLocalMessage = true;
//       return false;
//     }
//
//     imMessage.isSendingMessageToCloud = false;
//     imMessage.id = response.right['data']['message']['id'];
//     imMessage.isLocalMessage = false;
//
//     final response2 = await addImMessageToLocalDatasource(imMessage);
//     notifyListeners();
//     return response2;
//   }
//
//   Future<bool> addImMessageToLocalDatasource(ImMessage imMessage) async {
//     await _imLocalDatasource.saveImMessages(imGroupId: imMessage.imGroupId, imMessages: [imMessage]);
//     notifyListeners();
//     return true;
//   }
//
//   Future<bool> deleteImMessages(LivechatGroupModel imGroup, List<int> imMessageIds) async {
//     // Delete ImMessage from local datasource, not deleting from cloud
//     await _imLocalDatasource.deleteImMessages(
//       imGroupId: imGroup.id,
//       messageIds: imMessageIds,
//     );
//     notifyListeners();
//     return true;
//   }
// }
