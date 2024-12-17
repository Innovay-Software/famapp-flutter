import 'dart:async';

import 'package:famapp/core/utils/debug_utils.dart';
import 'package:famapp/core/utils/dot_env_manager.dart';
import 'package:famapp/features/livechat/model/livechat_message.dart';
import 'package:famapp/features/livechat/pb/rpc_services_user_general.pb.dart';
import 'package:famapp/features/livechat/viewmodel/livechat_viewmodel.dart';
import 'package:grpc/grpc.dart';

import './pb/rpc_services.pbgrpc.dart';
import 'model/livechat_group.dart';
import 'model/livechat_user.dart';

class GRPCService {
  late ClientChannel grpcChannel;
  late GrpcServerServiceClient grpcClient;
  late StreamController<UserGeneralRequest> userGeneralStreamController;

  String userAccessToken = "";
  bool isConnecting = false;
  Timer? reconnectionTimer;
  int reconnectingCount = 0;

  GRPCService() {
    final host = DotEnvField.LIVECHAT_GRPC_SERVER.getDotEnvString("-");
    final port = DotEnvField.LIVECHAT_GRPC_PORT.getDotEnvInt(9090);
    try {
      grpcChannel = ClientChannel(
        host,
        port: port,
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
        ),
        channelShutdownHandler: () {
          DebugManager.error("Channel shut down!");
          DebugManager.unimplemented();
        },
      );
      grpcClient = GrpcServerServiceClient(grpcChannel);
    } catch (e) {
      DebugManager.error("Livechat GRPC server unavailable: $host:$port");
      DebugManager.log(e.toString());
    }
  }

  void startUserGeneralStream(String accessToken) {
    DebugManager.info("Start userGeneralStream $accessToken");
    userGeneralStreamController = StreamController<UserGeneralRequest>();

    userAccessToken = accessToken;
    final options = CallOptions(
      metadata: {'authorization': 'bearer $userAccessToken'},
    );
    DebugManager.info("Create stream");
    final stream = grpcClient.userGeneral(
      userGeneralStreamController.stream,
      options: options,
    );

    DebugManager.info("Listen to stream");
    stream.listen(
      _receiveResponse,
      onError: (err) {
        DebugManager.warning("Stream onError: $err");
      },
      onDone: () {
        DebugManager.warning("Stream onDone");
      },
      cancelOnError: true,
    );

    DebugManager.info("Assign event listeners");
    userGeneralStreamController.onListen = onUserGeneralStreamListen;
    userGeneralStreamController.onCancel = onUserGeneralStreamCancel;
    userGeneralStreamController.onPause = onUserGeneralStreamPause;
    userGeneralStreamController.onResume = onUserGeneralStreamResume;
  }

  void sendUserGeneralLoginRequest() {
    _sendRequest(UserGeneralRequest(
      isLogin: true,
    ));
  }

  void sendUserGeneralUpsertGroupRequest(
    String groupId,
    String groupIdClient,
    String groupName,
    bool isGroupChat,
    List<String> memberUuids,
  ) {
    _sendRequest(UserGeneralRequest(
      isUpsertGroup: true,
      upsertGroupId: groupId,
      upsertGroupIdClient: groupIdClient,
      upsertGroupName: groupName,
      upsertGroupIsGroupChat: isGroupChat,
      upsertGroupMemberUuids: memberUuids,
    ));
  }

  void sendUserGeneralSendMessageRequest(
    String groupId,
    String messageContent,
    String messageType,
  ) {
    _sendRequest(UserGeneralRequest(
      isSendMessage: true,
      sendMessageGroupId: groupId,
      sendMessageContent: messageContent,
      sendMessageType: messageType,
    ));
  }

  void _sendRequest(UserGeneralRequest request) {
    DebugManager.info("_SendRequest: $request");
    userGeneralStreamController.sink.add(request);
  }

  void _receiveResponse(UserGeneralResponse response) {
    DebugManager.info("_ReceiveResponse: $response");
    if (response.isLogin) {
      _handleUserGeneralIsLoginResponse(response);
    } else if (response.isUpsertGroup) {
      _handleUserGeneralIsUpsertGroupResponse(response);
    } else if (response.isNewMessage) {
      _handleUserGeneralIsNewMessageResponse(response);
    }
  }

  void _handleUserGeneralIsLoginResponse(UserGeneralResponse response) {
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
  }

  void _handleUserGeneralIsUpsertGroupResponse(UserGeneralResponse response) {
    final groupClientId = response.newGroupClientId;
    DebugManager.warning("Adding new group: $groupClientId");
    var livechatGroup = LivechatGroupModel.fromPBLivechatGroupModel(response.newGroup);
    LivechatViewmodel().updateGroup(livechatGroup, groupClientId);
  }

  void _handleUserGeneralIsNewMessageResponse(UserGeneralResponse response) {
    LivechatViewmodel().addMessage(LivechatMessageModel.fromPBLivechatMessageModel(response.newMessage));
  }

  void onUserGeneralStreamListen() {
    reconnectingCount = 0;
    reconnectionTimer?.cancel();
    DebugManager.error("OnListen");

    sendUserGeneralLoginRequest();
  }

  void onUserGeneralStreamPause() {
    DebugManager.error("OnPause");
  }

  void onUserGeneralStreamResume() {
    DebugManager.error("OnResume");
  }

  void onUserGeneralStreamCancel() {
    userGeneralStreamController.close();
    DebugManager.error("OnCancel");
    // Connection dropped, try to reconnect
    if (!isConnecting) {
      isConnecting = true;
      reconnectionTimer = Timer(Duration(seconds: 1), () {
        DebugManager.error("Increment reconnectingCount: $reconnectingCount...");
        reconnectingCount++;
        isConnecting = false;
        startUserGeneralStream(userAccessToken);
      });
    }
  }
}
