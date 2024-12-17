import 'package:famapp/features/livechat/pb/message_livechat.pb.dart';
import 'package:famapp/features/livechat/viewmodel/livechat_viewmodel.dart';

import '../../../core/models/inno_file_upload_item.dart';

enum ImMessageType {
  text,
  systemText,
  image,
  audio,
  video,
  voiceCallInvitation,
  voiceCallCancellation,
  voiceCallRejection,
}

extension ImMessageTypeExtension on ImMessageType {
  String toShortString() {
    return toString().split('.').last;
  }

  bool get isMedia {
    return [ImMessageType.image, ImMessageType.audio, ImMessageType.video].contains(this);
  }
}

class LivechatMessageModel {
  // final UserViewmodel _userViewmodel = UserViewmodel();
  // final ImViewmodel _imViewmodel = ImViewmodel();

  final String id;
  final String groupId;
  final String type;
  final String owner;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  String localVideoThumbnailPath = '';
  bool localVideoThumbnailExists = false;
  bool seen = false;
  bool isSendingMessageToCloud = false;
  bool isLocalMessage = false;
  InnoFileUploadItem? fileUploadItem;

  LivechatMessageModel(this.id, this.groupId, this.type, this.owner, this.content, this.createdAt, this.updatedAt);

  factory LivechatMessageModel.fromPBLivechatMessageModel(LivechatMessage pbLivechatMessage) {
    return LivechatMessageModel(
      pbLivechatMessage.id,
      pbLivechatMessage.groupId,
      pbLivechatMessage.type,
      pbLivechatMessage.owner,
      pbLivechatMessage.content,
      DateTime.fromMillisecondsSinceEpoch(pbLivechatMessage.createdAt.toInt(), isUtc: true),
      DateTime.fromMillisecondsSinceEpoch(pbLivechatMessage.updatedAt.toInt(), isUtc: true),
    );
  }

  bool isOwner() {
    return owner == LivechatViewmodel().currentUser.uuid;
  }
  // ImMessage(this.isLocalMessage, dynamic rawData) {
  //   id = int.tryParse('${rawData['id']}') ?? 0;
  //   imGroupId = int.tryParse('${rawData['im_group_id']}') ?? 0;
  //   userId = int.tryParse('${rawData['user_id']}') ?? 0;
  //   userName = _imViewmodel.imUserMap[userId]?.name ?? '-';
  //   type = ImMessageType.values.firstWhere(
  //     (e) => e.toShortString() == '${rawData['type'] ?? 'text'}',
  //     orElse: () => ImMessageType.text,
  //   );
  //   body = '${rawData['body']}';
  //   seen = '${rawData['seen']}' == '1';
  //   createdAt = DateTime.fromMillisecondsSinceEpoch(
  //     (int.tryParse('${rawData['created_at']}') ?? 0) * 1000,
  //     isUtc: true,
  //   );
  //   generateLocalVideoThumbnailPath();
  // }
  //
  // Future<String> generateLocalVideoThumbnailPath() async {
  //   if (localVideoThumbnailPath.isNotEmpty) {
  //     return localVideoThumbnailPath;
  //   }
  //   localVideoThumbnailPath = (await getTemporaryDirectory()).path;
  //   localVideoThumbnailPath = '$localVideoThumbnailPath${getFileName()}.thumbnail.jpg';
  //   return localVideoThumbnailPath;
  // }
  //
  // void setImageUploadItem(InnoFileUploadItem fileUploadItemInstance) {
  //   fileUploadItem = fileUploadItemInstance;
  // }
  //
  // bool isOwner() {
  //   return userId == _userViewmodel.currentUser.id;
  // }
  //
  // //
  // // Future<void> sendMessageToCloud(Function() onSuccessCallback) async {
  // //   /// A positive id indicates this message is already in the cloud.
  // //   if (!isLocalMessage) {
  // //     // if it's not a local message, meaning it was already uploaded to cloud
  // //     return;
  // //   }
  // //
  // //   /// if this is an image message, upload it to cloud, then send the url as the message body
  // //   if (type == ImMessageType.image || type == ImMessageType.video || type == ImMessageType.audio) {
  // //     if (imageUploadItem == null) return;
  // //     if (!imageUploadItem!.isUploaded) {
  // //       if (!imageUploadItem!.isUploading) {
  // //         imageUploadItem!.uploadToCloud((responseMap) {
  // //           body = responseMap['file_url'];
  // //           sendMessageToCloud(onSuccessCallback);
  // //         }, useChunkUpload: true);
  // //       }
  // //       return;
  // //     }
  // //   }
  // //
  // //   if (isSendingMessageToCloud) return;
  // //   isSendingMessageToCloud = true;
  // //
  // //   try {
  // //     var res = await NetworkManager.postRequestSync(InnoConfig.imNetworkConfig.sendMessage(imGroupId), dataLoad: {
  // //       'type': type.toShortString(),
  // //       'body': body,
  // //       'deviceToken': InnoGlobalData.deviceToken,
  // //     });
  // //
  // //     // DebugManager.log("send message success");
  // //     // DebugManager.log(res['data']['message']);
  // //     isSendingMessageToCloud = false;
  // //     id = res['data']['message']['id'];
  // //     isLocalMessage = false;
  // //     await saveToLocalDatabase();
  // //
  // //     onSuccessCallback();
  // //   } on InnoApiException catch (e) {
  // //     DebugManager.error(e.errorMessage());
  // //   } catch (e) {
  // //     DebugManager.error(e.toString());
  // //   }
  // // }
  // //
  // // Future<void> saveToLocalDatabase() async {
  // //   var db = InnoLocalDatabaseService.instance.imDatabase;
  // //   var records = await db.query('im_messages', where: 'id = ?', whereArgs: [id]);
  // //   if (records.isEmpty) {
  // //     await db.insert('im_messages', {
  // //       'id': id,
  // //       'im_group_id': imGroupId,
  // //       'user_id': userId,
  // //       'body': body,
  // //       'type': type.toShortString(),
  // //       'seen': 1,
  // //       'created_at': (createdAt.millisecondsSinceEpoch / 1000).floor(),
  // //     });
  // //     DebugManager.log("ImMessaged inserted");
  // //   }
  // //
  // //   // Get corresponding imGroup and update imGroup data
  // //   var imGroup = _imViewmodel.getImGroup(imGroupId);
  // //   if (imGroup != null) {
  // //     await imGroup.getLatestMessages();
  // //     var latestMessage = '$userName: ';
  // //     if (type == ImMessageType.image) {
  // //       latestMessage += '[图片]';
  // //     } else if (type == ImMessageType.video) {
  // //       latestMessage += '[视频]';
  // //     } else if (type == ImMessageType.audio) {
  // //       latestMessage += '[语音]';
  // //     } else {
  // //       latestMessage += body;
  // //     }
  // //     imGroup.latestMessage = latestMessage;
  // //     _imViewmodel.moveImGroupToTop(imGroup.id);
  // //   }
  // // }
  //
  // String getFileName() {
  //   if (type == ImMessageType.image || type == ImMessageType.video || type == ImMessageType.audio) {
  //     return body.split('/').last;
  //   }
  //   return '-';
  // }
  //
  // bool hasVideoThumbnail() {
  //   return localVideoThumbnailExists;
  // }
  //
  // Future<void> generateVideoThumbnail(Function() successCallback) async {
  //   if (type != ImMessageType.video) return;
  //
  //   var thumbnailPath = await generateLocalVideoThumbnailPath();
  //   localVideoThumbnailExists = await io.File(thumbnailPath).exists();
  //   if (!localVideoThumbnailExists) {
  //     // isVideo
  //     final fileName = await VideoThumbnail.thumbnailFile(
  //       video: body,
  //       thumbnailPath: (await getTemporaryDirectory()).path,
  //       imageFormat: ImageFormat.JPEG,
  //       maxWidth: 128,
  //       quality: 75,
  //     );
  //
  //     if (fileName != null) {
  //       io.File(fileName).rename(thumbnailPath);
  //     }
  //     localVideoThumbnailExists = true;
  //   }
  //   successCallback();
  // }
}
