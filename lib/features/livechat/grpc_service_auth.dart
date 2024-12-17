import 'package:famapp/core/utils/debug_utils.dart';
import 'package:famapp/features/livechat/model/livechat_group.dart';
import 'package:famapp/features/livechat/pb/rpc_services.pb.dart';
import 'package:famapp/features/livechat/viewmodel/livechat_viewmodel.dart';
import 'package:famapp/features/settings/viewmodel/user_viewmodel.dart';

import './model/livechat_user.dart';

class GRPCServiceAuth {
  @Deprecated("Migrate to GRPCService.startUserGeneralStream")
  static Future<LivechatViewmodel> accessTokenLogin() async {
    try {
      final accessToken = UserViewmodel().currentUser.getAccessToken();
      DebugManager.grpc("Calling accessTokenLogin: $accessToken");
      final response = await LivechatViewmodel().grpcService.grpcClient.accessTokenLogin(
            EmptyRequest(),
            // options: LivechatViewmodel().getGRPCRequestOption(),
          );
      DebugManager.grpc("AccessTokenLoginResponse: ${response.toString()}");

      final pbUser = response.user;
      final pbFriends = response.friends;
      final pbGroups = response.groups;

      final livechatUser = LivechatUserModel.fromPBUserModel(pbUser);
      final List<LivechatUserModel> friends = [];
      for (final friend in pbFriends) {
        friends.add(LivechatUserModel.fromPBUserModel(friend));
      }
      final List<LivechatGroupModel> groups = [];
      for (final group in pbGroups) {
        groups.add(LivechatGroupModel.fromPBLivechatGroupModel(group));
      }

      LivechatViewmodel().initViewmodel(livechatUser, friends, groups);
      return LivechatViewmodel();
    } catch (e) {
      DebugManager.log(e.toString());
      rethrow;
    }
  }

  //
  // static Future<LivechatUserModel?> signup(String name, String email, String mobile) async {
  //   try {
  //     final request = SignupRequestMessage(name: name, email: email, mobile: mobile);
  //     final response = await GrpcService.client.signUp(request);
  //     return LivechatUserModel(response.user.id, response.user.name, response.user.email, response.user.mobile);
  //   } catch (e) {
  //     DebugManager.log(e.toString());
  //     rethrow;
  //   }
  // }

  // static Future<LivechatUserModel?> getUser() async {
  //   try {
  //     final response = await GrpcService.client.getUser(
  //       EmptyRequest(),
  //       options: CallOptions(metadata: {'authorization': 'bearer $authToken'}),
  //     );
  //     user = LivechatUserModel(response.user.id, response.user.name, response.user.email, response.user.mobile);
  //     return user;
  //   } catch (e) {
  //     DebugManager.log(e.toString());
  //     rethrow;
  //   }
  // }
  //
  // static Future<List<LivechatUserModel>> getUsers({int pageNumber = 1, String? search}) async {
  //   final res = await GrpcService.client.getUsers(UsersListRequest(pageSize: 10, pageNumber: pageNumber, name: search),
  //       options: CallOptions(metadata: {'authorization': 'bearer $authToken'}));
  //   return res.users.map((e) => LivechatUserModel(e.id, e.name, e.email, e.mobile)).toList();
  // }
  //
  // static Future<List<Message>> getMessages(String username) async {
  //   final res = await GrpcService.client.getAllMessage(
  //       GetAllMessagesRequest(
  //         reciever: username,
  //       ),
  //       options: CallOptions(metadata: {'authorization': 'bearer ${AuthService.authToken}'}));
  //   return res.messages;
  // }
}
