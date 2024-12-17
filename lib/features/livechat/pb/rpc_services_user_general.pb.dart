//
//  Generated code. Do not modify.
//  source: rpc_services_user_general.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'message_livechat.pb.dart' as $3;
import 'message_user.pb.dart' as $5;

class UserGeneralRequest extends $pb.GeneratedMessage {
  factory UserGeneralRequest({
    $core.bool? isLogin,
    $core.bool? isUpsertGroup,
    $core.String? upsertGroupId,
    $core.String? upsertGroupIdClient,
    $core.String? upsertGroupName,
    $core.bool? upsertGroupIsGroupChat,
    $core.Iterable<$core.String>? upsertGroupMemberUuids,
    $core.bool? isSendMessage,
    $core.String? sendMessageGroupId,
    $core.String? sendMessageContent,
    $core.String? sendMessageType,
    $core.bool? isRewordMessage,
    $core.String? rewordMessageContent,
  }) {
    final $result = create();
    if (isLogin != null) {
      $result.isLogin = isLogin;
    }
    if (isUpsertGroup != null) {
      $result.isUpsertGroup = isUpsertGroup;
    }
    if (upsertGroupId != null) {
      $result.upsertGroupId = upsertGroupId;
    }
    if (upsertGroupIdClient != null) {
      $result.upsertGroupIdClient = upsertGroupIdClient;
    }
    if (upsertGroupName != null) {
      $result.upsertGroupName = upsertGroupName;
    }
    if (upsertGroupIsGroupChat != null) {
      $result.upsertGroupIsGroupChat = upsertGroupIsGroupChat;
    }
    if (upsertGroupMemberUuids != null) {
      $result.upsertGroupMemberUuids.addAll(upsertGroupMemberUuids);
    }
    if (isSendMessage != null) {
      $result.isSendMessage = isSendMessage;
    }
    if (sendMessageGroupId != null) {
      $result.sendMessageGroupId = sendMessageGroupId;
    }
    if (sendMessageContent != null) {
      $result.sendMessageContent = sendMessageContent;
    }
    if (sendMessageType != null) {
      $result.sendMessageType = sendMessageType;
    }
    if (isRewordMessage != null) {
      $result.isRewordMessage = isRewordMessage;
    }
    if (rewordMessageContent != null) {
      $result.rewordMessageContent = rewordMessageContent;
    }
    return $result;
  }
  UserGeneralRequest._() : super();
  factory UserGeneralRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserGeneralRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UserGeneralRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'isLogin')
    ..aOB(2, _omitFieldNames ? '' : 'isUpsertGroup')
    ..aOS(3, _omitFieldNames ? '' : 'upsertGroupId')
    ..aOS(4, _omitFieldNames ? '' : 'upsertGroupIdClient')
    ..aOS(5, _omitFieldNames ? '' : 'upsertGroupName')
    ..aOB(6, _omitFieldNames ? '' : 'upsertGroupIsGroupChat')
    ..pPS(7, _omitFieldNames ? '' : 'upsertGroupMemberUuids')
    ..aOB(8, _omitFieldNames ? '' : 'isSendMessage')
    ..aOS(9, _omitFieldNames ? '' : 'sendMessageGroupId')
    ..aOS(10, _omitFieldNames ? '' : 'sendMessageContent')
    ..aOS(11, _omitFieldNames ? '' : 'sendMessageType')
    ..aOB(12, _omitFieldNames ? '' : 'isRewordMessage')
    ..aOS(13, _omitFieldNames ? '' : 'rewordMessageContent')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserGeneralRequest clone() => UserGeneralRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserGeneralRequest copyWith(void Function(UserGeneralRequest) updates) => super.copyWith((message) => updates(message as UserGeneralRequest)) as UserGeneralRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserGeneralRequest create() => UserGeneralRequest._();
  UserGeneralRequest createEmptyInstance() => create();
  static $pb.PbList<UserGeneralRequest> createRepeated() => $pb.PbList<UserGeneralRequest>();
  @$core.pragma('dart2js:noInline')
  static UserGeneralRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserGeneralRequest>(create);
  static UserGeneralRequest? _defaultInstance;

  /// Feature1: Login - client initialited - server responds
  @$pb.TagNumber(1)
  $core.bool get isLogin => $_getBF(0);
  @$pb.TagNumber(1)
  set isLogin($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIsLogin() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsLogin() => clearField(1);

  /// Feature2: UpsertGroup - insert or update group
  @$pb.TagNumber(2)
  $core.bool get isUpsertGroup => $_getBF(1);
  @$pb.TagNumber(2)
  set isUpsertGroup($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIsUpsertGroup() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsUpsertGroup() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get upsertGroupId => $_getSZ(2);
  @$pb.TagNumber(3)
  set upsertGroupId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUpsertGroupId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUpsertGroupId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get upsertGroupIdClient => $_getSZ(3);
  @$pb.TagNumber(4)
  set upsertGroupIdClient($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUpsertGroupIdClient() => $_has(3);
  @$pb.TagNumber(4)
  void clearUpsertGroupIdClient() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get upsertGroupName => $_getSZ(4);
  @$pb.TagNumber(5)
  set upsertGroupName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasUpsertGroupName() => $_has(4);
  @$pb.TagNumber(5)
  void clearUpsertGroupName() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get upsertGroupIsGroupChat => $_getBF(5);
  @$pb.TagNumber(6)
  set upsertGroupIsGroupChat($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasUpsertGroupIsGroupChat() => $_has(5);
  @$pb.TagNumber(6)
  void clearUpsertGroupIsGroupChat() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<$core.String> get upsertGroupMemberUuids => $_getList(6);

  /// Feature3: SendMessage - client initiated
  @$pb.TagNumber(8)
  $core.bool get isSendMessage => $_getBF(7);
  @$pb.TagNumber(8)
  set isSendMessage($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasIsSendMessage() => $_has(7);
  @$pb.TagNumber(8)
  void clearIsSendMessage() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get sendMessageGroupId => $_getSZ(8);
  @$pb.TagNumber(9)
  set sendMessageGroupId($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasSendMessageGroupId() => $_has(8);
  @$pb.TagNumber(9)
  void clearSendMessageGroupId() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get sendMessageContent => $_getSZ(9);
  @$pb.TagNumber(10)
  set sendMessageContent($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasSendMessageContent() => $_has(9);
  @$pb.TagNumber(10)
  void clearSendMessageContent() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get sendMessageType => $_getSZ(10);
  @$pb.TagNumber(11)
  set sendMessageType($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasSendMessageType() => $_has(10);
  @$pb.TagNumber(11)
  void clearSendMessageType() => clearField(11);

  /// Feature4: RewordMessage - client initiated
  @$pb.TagNumber(12)
  $core.bool get isRewordMessage => $_getBF(11);
  @$pb.TagNumber(12)
  set isRewordMessage($core.bool v) { $_setBool(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasIsRewordMessage() => $_has(11);
  @$pb.TagNumber(12)
  void clearIsRewordMessage() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get rewordMessageContent => $_getSZ(12);
  @$pb.TagNumber(13)
  set rewordMessageContent($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasRewordMessageContent() => $_has(12);
  @$pb.TagNumber(13)
  void clearRewordMessageContent() => clearField(13);
}

class UserGeneralResponse extends $pb.GeneratedMessage {
  factory UserGeneralResponse({
    $core.bool? isLogin,
    $5.User? user,
    $core.Iterable<$5.User>? friends,
    $core.Iterable<$3.LivechatGroup>? groups,
    $core.bool? isUpsertGroup,
    $3.LivechatGroup? newGroup,
    $core.String? newGroupClientId,
    $core.bool? isNewMessage,
    $3.LivechatMessage? newMessage,
    $core.bool? isRewordMessage,
    $3.LivechatMessage? rewordMessage,
  }) {
    final $result = create();
    if (isLogin != null) {
      $result.isLogin = isLogin;
    }
    if (user != null) {
      $result.user = user;
    }
    if (friends != null) {
      $result.friends.addAll(friends);
    }
    if (groups != null) {
      $result.groups.addAll(groups);
    }
    if (isUpsertGroup != null) {
      $result.isUpsertGroup = isUpsertGroup;
    }
    if (newGroup != null) {
      $result.newGroup = newGroup;
    }
    if (newGroupClientId != null) {
      $result.newGroupClientId = newGroupClientId;
    }
    if (isNewMessage != null) {
      $result.isNewMessage = isNewMessage;
    }
    if (newMessage != null) {
      $result.newMessage = newMessage;
    }
    if (isRewordMessage != null) {
      $result.isRewordMessage = isRewordMessage;
    }
    if (rewordMessage != null) {
      $result.rewordMessage = rewordMessage;
    }
    return $result;
  }
  UserGeneralResponse._() : super();
  factory UserGeneralResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserGeneralResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UserGeneralResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'isLogin')
    ..aOM<$5.User>(2, _omitFieldNames ? '' : 'user', subBuilder: $5.User.create)
    ..pc<$5.User>(3, _omitFieldNames ? '' : 'friends', $pb.PbFieldType.PM, subBuilder: $5.User.create)
    ..pc<$3.LivechatGroup>(4, _omitFieldNames ? '' : 'groups', $pb.PbFieldType.PM, subBuilder: $3.LivechatGroup.create)
    ..aOB(5, _omitFieldNames ? '' : 'isUpsertGroup')
    ..aOM<$3.LivechatGroup>(6, _omitFieldNames ? '' : 'newGroup', subBuilder: $3.LivechatGroup.create)
    ..aOS(7, _omitFieldNames ? '' : 'newGroupClientId')
    ..aOB(8, _omitFieldNames ? '' : 'isNewMessage')
    ..aOM<$3.LivechatMessage>(9, _omitFieldNames ? '' : 'newMessage', subBuilder: $3.LivechatMessage.create)
    ..aOB(10, _omitFieldNames ? '' : 'isRewordMessage')
    ..aOM<$3.LivechatMessage>(11, _omitFieldNames ? '' : 'rewordMessage', subBuilder: $3.LivechatMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserGeneralResponse clone() => UserGeneralResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserGeneralResponse copyWith(void Function(UserGeneralResponse) updates) => super.copyWith((message) => updates(message as UserGeneralResponse)) as UserGeneralResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserGeneralResponse create() => UserGeneralResponse._();
  UserGeneralResponse createEmptyInstance() => create();
  static $pb.PbList<UserGeneralResponse> createRepeated() => $pb.PbList<UserGeneralResponse>();
  @$core.pragma('dart2js:noInline')
  static UserGeneralResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserGeneralResponse>(create);
  static UserGeneralResponse? _defaultInstance;

  /// Feature1: Login, get user details, friends, and groups belonged to
  @$pb.TagNumber(1)
  $core.bool get isLogin => $_getBF(0);
  @$pb.TagNumber(1)
  set isLogin($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIsLogin() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsLogin() => clearField(1);

  @$pb.TagNumber(2)
  $5.User get user => $_getN(1);
  @$pb.TagNumber(2)
  set user($5.User v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasUser() => $_has(1);
  @$pb.TagNumber(2)
  void clearUser() => clearField(2);
  @$pb.TagNumber(2)
  $5.User ensureUser() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.List<$5.User> get friends => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<$3.LivechatGroup> get groups => $_getList(3);

  /// Feature2: UpsertGroup
  @$pb.TagNumber(5)
  $core.bool get isUpsertGroup => $_getBF(4);
  @$pb.TagNumber(5)
  set isUpsertGroup($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIsUpsertGroup() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsUpsertGroup() => clearField(5);

  @$pb.TagNumber(6)
  $3.LivechatGroup get newGroup => $_getN(5);
  @$pb.TagNumber(6)
  set newGroup($3.LivechatGroup v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasNewGroup() => $_has(5);
  @$pb.TagNumber(6)
  void clearNewGroup() => clearField(6);
  @$pb.TagNumber(6)
  $3.LivechatGroup ensureNewGroup() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.String get newGroupClientId => $_getSZ(6);
  @$pb.TagNumber(7)
  set newGroupClientId($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasNewGroupClientId() => $_has(6);
  @$pb.TagNumber(7)
  void clearNewGroupClientId() => clearField(7);

  /// Feature3: DistributeMessage - server initiated
  @$pb.TagNumber(8)
  $core.bool get isNewMessage => $_getBF(7);
  @$pb.TagNumber(8)
  set isNewMessage($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasIsNewMessage() => $_has(7);
  @$pb.TagNumber(8)
  void clearIsNewMessage() => clearField(8);

  @$pb.TagNumber(9)
  $3.LivechatMessage get newMessage => $_getN(8);
  @$pb.TagNumber(9)
  set newMessage($3.LivechatMessage v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasNewMessage() => $_has(8);
  @$pb.TagNumber(9)
  void clearNewMessage() => clearField(9);
  @$pb.TagNumber(9)
  $3.LivechatMessage ensureNewMessage() => $_ensure(8);

  /// Feature4: DistributeRewordMessage - server initiated
  @$pb.TagNumber(10)
  $core.bool get isRewordMessage => $_getBF(9);
  @$pb.TagNumber(10)
  set isRewordMessage($core.bool v) { $_setBool(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasIsRewordMessage() => $_has(9);
  @$pb.TagNumber(10)
  void clearIsRewordMessage() => clearField(10);

  @$pb.TagNumber(11)
  $3.LivechatMessage get rewordMessage => $_getN(10);
  @$pb.TagNumber(11)
  set rewordMessage($3.LivechatMessage v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasRewordMessage() => $_has(10);
  @$pb.TagNumber(11)
  void clearRewordMessage() => clearField(11);
  @$pb.TagNumber(11)
  $3.LivechatMessage ensureRewordMessage() => $_ensure(10);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
