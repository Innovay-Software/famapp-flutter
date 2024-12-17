//
//  Generated code. Do not modify.
//  source: rpc_livechat.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $6;
import 'message_livechat.pb.dart' as $3;

class SendMessageRequest extends $pb.GeneratedMessage {
  factory SendMessageRequest({
    $core.String? groupId,
    $core.String? content,
    $core.String? type,
  }) {
    final $result = create();
    if (groupId != null) {
      $result.groupId = groupId;
    }
    if (content != null) {
      $result.content = content;
    }
    if (type != null) {
      $result.type = type;
    }
    return $result;
  }
  SendMessageRequest._() : super();
  factory SendMessageRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendMessageRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SendMessageRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'groupId')
    ..aOS(2, _omitFieldNames ? '' : 'content')
    ..aOS(3, _omitFieldNames ? '' : 'type')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendMessageRequest clone() => SendMessageRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendMessageRequest copyWith(void Function(SendMessageRequest) updates) => super.copyWith((message) => updates(message as SendMessageRequest)) as SendMessageRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendMessageRequest create() => SendMessageRequest._();
  SendMessageRequest createEmptyInstance() => create();
  static $pb.PbList<SendMessageRequest> createRepeated() => $pb.PbList<SendMessageRequest>();
  @$core.pragma('dart2js:noInline')
  static SendMessageRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendMessageRequest>(create);
  static SendMessageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get content => $_getSZ(1);
  @$pb.TagNumber(2)
  set content($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasContent() => $_has(1);
  @$pb.TagNumber(2)
  void clearContent() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get type => $_getSZ(2);
  @$pb.TagNumber(3)
  set type($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => clearField(3);
}

class GetLatestMessagesRequest extends $pb.GeneratedMessage {
  factory GetLatestMessagesRequest({
    $core.String? groupId,
    $6.Timestamp? pivotDatetime,
  }) {
    final $result = create();
    if (groupId != null) {
      $result.groupId = groupId;
    }
    if (pivotDatetime != null) {
      $result.pivotDatetime = pivotDatetime;
    }
    return $result;
  }
  GetLatestMessagesRequest._() : super();
  factory GetLatestMessagesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetLatestMessagesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetLatestMessagesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'groupId')
    ..aOM<$6.Timestamp>(2, _omitFieldNames ? '' : 'pivotDatetime', subBuilder: $6.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetLatestMessagesRequest clone() => GetLatestMessagesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetLatestMessagesRequest copyWith(void Function(GetLatestMessagesRequest) updates) => super.copyWith((message) => updates(message as GetLatestMessagesRequest)) as GetLatestMessagesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetLatestMessagesRequest create() => GetLatestMessagesRequest._();
  GetLatestMessagesRequest createEmptyInstance() => create();
  static $pb.PbList<GetLatestMessagesRequest> createRepeated() => $pb.PbList<GetLatestMessagesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetLatestMessagesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetLatestMessagesRequest>(create);
  static GetLatestMessagesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => clearField(1);

  @$pb.TagNumber(2)
  $6.Timestamp get pivotDatetime => $_getN(1);
  @$pb.TagNumber(2)
  set pivotDatetime($6.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPivotDatetime() => $_has(1);
  @$pb.TagNumber(2)
  void clearPivotDatetime() => clearField(2);
  @$pb.TagNumber(2)
  $6.Timestamp ensurePivotDatetime() => $_ensure(1);
}

class GetLatestMessagesResponse extends $pb.GeneratedMessage {
  factory GetLatestMessagesResponse({
    $core.Iterable<$3.LivechatMessage>? messages,
  }) {
    final $result = create();
    if (messages != null) {
      $result.messages.addAll(messages);
    }
    return $result;
  }
  GetLatestMessagesResponse._() : super();
  factory GetLatestMessagesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetLatestMessagesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetLatestMessagesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<$3.LivechatMessage>(1, _omitFieldNames ? '' : 'messages', $pb.PbFieldType.PM, subBuilder: $3.LivechatMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetLatestMessagesResponse clone() => GetLatestMessagesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetLatestMessagesResponse copyWith(void Function(GetLatestMessagesResponse) updates) => super.copyWith((message) => updates(message as GetLatestMessagesResponse)) as GetLatestMessagesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetLatestMessagesResponse create() => GetLatestMessagesResponse._();
  GetLatestMessagesResponse createEmptyInstance() => create();
  static $pb.PbList<GetLatestMessagesResponse> createRepeated() => $pb.PbList<GetLatestMessagesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetLatestMessagesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetLatestMessagesResponse>(create);
  static GetLatestMessagesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$3.LivechatMessage> get messages => $_getList(0);
}

class CreateLivechatGroupRequest extends $pb.GeneratedMessage {
  factory CreateLivechatGroupRequest({
    $core.String? title,
    $core.Iterable<$core.String>? members,
  }) {
    final $result = create();
    if (title != null) {
      $result.title = title;
    }
    if (members != null) {
      $result.members.addAll(members);
    }
    return $result;
  }
  CreateLivechatGroupRequest._() : super();
  factory CreateLivechatGroupRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateLivechatGroupRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateLivechatGroupRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'title')
    ..pPS(2, _omitFieldNames ? '' : 'members')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateLivechatGroupRequest clone() => CreateLivechatGroupRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateLivechatGroupRequest copyWith(void Function(CreateLivechatGroupRequest) updates) => super.copyWith((message) => updates(message as CreateLivechatGroupRequest)) as CreateLivechatGroupRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateLivechatGroupRequest create() => CreateLivechatGroupRequest._();
  CreateLivechatGroupRequest createEmptyInstance() => create();
  static $pb.PbList<CreateLivechatGroupRequest> createRepeated() => $pb.PbList<CreateLivechatGroupRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateLivechatGroupRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateLivechatGroupRequest>(create);
  static CreateLivechatGroupRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.String> get members => $_getList(1);
}

class CreateLivechatGroupResponse extends $pb.GeneratedMessage {
  factory CreateLivechatGroupResponse({
    $3.LivechatGroup? livechatGroup,
  }) {
    final $result = create();
    if (livechatGroup != null) {
      $result.livechatGroup = livechatGroup;
    }
    return $result;
  }
  CreateLivechatGroupResponse._() : super();
  factory CreateLivechatGroupResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateLivechatGroupResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateLivechatGroupResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<$3.LivechatGroup>(1, _omitFieldNames ? '' : 'livechatGroup', subBuilder: $3.LivechatGroup.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateLivechatGroupResponse clone() => CreateLivechatGroupResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateLivechatGroupResponse copyWith(void Function(CreateLivechatGroupResponse) updates) => super.copyWith((message) => updates(message as CreateLivechatGroupResponse)) as CreateLivechatGroupResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateLivechatGroupResponse create() => CreateLivechatGroupResponse._();
  CreateLivechatGroupResponse createEmptyInstance() => create();
  static $pb.PbList<CreateLivechatGroupResponse> createRepeated() => $pb.PbList<CreateLivechatGroupResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateLivechatGroupResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateLivechatGroupResponse>(create);
  static CreateLivechatGroupResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $3.LivechatGroup get livechatGroup => $_getN(0);
  @$pb.TagNumber(1)
  set livechatGroup($3.LivechatGroup v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasLivechatGroup() => $_has(0);
  @$pb.TagNumber(1)
  void clearLivechatGroup() => clearField(1);
  @$pb.TagNumber(1)
  $3.LivechatGroup ensureLivechatGroup() => $_ensure(0);
}

class UpdateLivechatGroupRequest extends $pb.GeneratedMessage {
  factory UpdateLivechatGroupRequest({
    $core.String? groupId,
    $core.String? title,
    $core.Iterable<$core.String>? members,
  }) {
    final $result = create();
    if (groupId != null) {
      $result.groupId = groupId;
    }
    if (title != null) {
      $result.title = title;
    }
    if (members != null) {
      $result.members.addAll(members);
    }
    return $result;
  }
  UpdateLivechatGroupRequest._() : super();
  factory UpdateLivechatGroupRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateLivechatGroupRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateLivechatGroupRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'groupId')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..pPS(3, _omitFieldNames ? '' : 'members')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateLivechatGroupRequest clone() => UpdateLivechatGroupRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateLivechatGroupRequest copyWith(void Function(UpdateLivechatGroupRequest) updates) => super.copyWith((message) => updates(message as UpdateLivechatGroupRequest)) as UpdateLivechatGroupRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateLivechatGroupRequest create() => UpdateLivechatGroupRequest._();
  UpdateLivechatGroupRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateLivechatGroupRequest> createRepeated() => $pb.PbList<UpdateLivechatGroupRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateLivechatGroupRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateLivechatGroupRequest>(create);
  static UpdateLivechatGroupRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get members => $_getList(2);
}

class UpdateLivechatGroupResponse extends $pb.GeneratedMessage {
  factory UpdateLivechatGroupResponse({
    $3.LivechatGroup? livechatGroup,
  }) {
    final $result = create();
    if (livechatGroup != null) {
      $result.livechatGroup = livechatGroup;
    }
    return $result;
  }
  UpdateLivechatGroupResponse._() : super();
  factory UpdateLivechatGroupResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateLivechatGroupResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateLivechatGroupResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<$3.LivechatGroup>(1, _omitFieldNames ? '' : 'livechatGroup', subBuilder: $3.LivechatGroup.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateLivechatGroupResponse clone() => UpdateLivechatGroupResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateLivechatGroupResponse copyWith(void Function(UpdateLivechatGroupResponse) updates) => super.copyWith((message) => updates(message as UpdateLivechatGroupResponse)) as UpdateLivechatGroupResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateLivechatGroupResponse create() => UpdateLivechatGroupResponse._();
  UpdateLivechatGroupResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateLivechatGroupResponse> createRepeated() => $pb.PbList<UpdateLivechatGroupResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateLivechatGroupResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateLivechatGroupResponse>(create);
  static UpdateLivechatGroupResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $3.LivechatGroup get livechatGroup => $_getN(0);
  @$pb.TagNumber(1)
  set livechatGroup($3.LivechatGroup v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasLivechatGroup() => $_has(0);
  @$pb.TagNumber(1)
  void clearLivechatGroup() => clearField(1);
  @$pb.TagNumber(1)
  $3.LivechatGroup ensureLivechatGroup() => $_ensure(0);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
