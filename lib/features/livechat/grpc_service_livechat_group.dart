import 'package:grpc/grpc.dart';
import 'package:famapp/core/utils/debug_utils.dart';
import 'package:famapp/features/livechat/model/livechat_group.dart';
import 'package:famapp/features/livechat/pb/google/protobuf/timestamp.pb.dart';
import 'package:famapp/features/livechat/pb/message_livechat.pb.dart';
import 'package:famapp/features/livechat/pb/rpc_livechat.pb.dart';
import 'package:famapp/features/livechat/viewmodel/livechat_viewmodel.dart';

class GRPCServiceLivechatGroup {
  @Deprecated("Migrate to GRPCService.startUserGeneralStream")
  static Future<LivechatGroupModel> createLivechatGroup(String title, List<String> members) async {
    DebugManager.grpc("CreateLivechatGroup $title $members");
    final res = await LivechatViewmodel().grpcService.grpcClient.createLivechatGroup(
          CreateLivechatGroupRequest(title: title, members: members),
          options: CallOptions(
            metadata: {'authorization': 'bearer ${LivechatViewmodel().accessToken}'},
          ),
        );
    final group = LivechatGroupModel.fromPBLivechatGroupModel(res.livechatGroup);
    DebugManager.grpc("CreateLivechatGroup Response $group");
    // LivechatViewmodel().updateGroup(group);
    return group;
  }

  @Deprecated("Migrate to GRPCService.startUserGeneralStream")
  static Future<LivechatGroupModel> updateLivechatGroup(String groupID, String title, List<String> members) async {
    DebugManager.grpc("UpdateLivechatGroup $title $members");
    final res = await LivechatViewmodel().grpcService.grpcClient.updateLivechatGroup(
          UpdateLivechatGroupRequest(groupId: groupID, title: title, members: members),
          options: CallOptions(
            metadata: {'authorization': 'bearer ${LivechatViewmodel().accessToken}'},
          ),
        );
    final group = LivechatGroupModel.fromPBLivechatGroupModel(res.livechatGroup);
    DebugManager.grpc("UpdateLivechatGroup Response $group");
    // LivechatViewmodel().updateGroup(group);
    return group;
  }

  @Deprecated("Migrate to GRPCService.startUserGeneralStream")
  static Future<List<LivechatMessage>> getChatHistory(String groupID, DateTime pivotDatetime) async {
    final pivotTimestamp = Timestamp.fromDateTime(pivotDatetime);
    final res = await LivechatViewmodel().grpcService.grpcClient.getLatestMessages(
          GetLatestMessagesRequest(groupId: groupID, pivotDatetime: pivotTimestamp),
          // options: LivechatViewmodel().getGRPCRequestOption(),
        );
    //
    // final messageList = <LivechatMessageModel>[];
    // for (final item in res.messages) {
    //   messageList.add(LivechatMessageModel.fromPBLivechatMessageModel(item));
    // }

    return res.messages;
  }
}
