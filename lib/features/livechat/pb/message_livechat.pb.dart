//
//  Generated code. Do not modify.
//  source: message_livechat.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $6;
import 'message_user.pb.dart' as $5;

class LivechatGroup extends $pb.GeneratedMessage {
  factory LivechatGroup({
    $core.String? id,
    $core.String? title,
    $core.String? owner,
    $core.Iterable<$5.UserInGroup>? members,
    $core.Map<$core.String, $core.String>? metadata,
    $core.bool? isGroupChat,
    $core.String? lastMessage,
    $6.Timestamp? lastMessageTime,
    $6.Timestamp? createdAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (title != null) {
      $result.title = title;
    }
    if (owner != null) {
      $result.owner = owner;
    }
    if (members != null) {
      $result.members.addAll(members);
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    if (isGroupChat != null) {
      $result.isGroupChat = isGroupChat;
    }
    if (lastMessage != null) {
      $result.lastMessage = lastMessage;
    }
    if (lastMessageTime != null) {
      $result.lastMessageTime = lastMessageTime;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    return $result;
  }
  LivechatGroup._() : super();
  factory LivechatGroup.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LivechatGroup.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LivechatGroup', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'owner')
    ..pc<$5.UserInGroup>(4, _omitFieldNames ? '' : 'members', $pb.PbFieldType.PM, subBuilder: $5.UserInGroup.create)
    ..m<$core.String, $core.String>(5, _omitFieldNames ? '' : 'metadata', entryClassName: 'LivechatGroup.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..aOB(6, _omitFieldNames ? '' : 'isGroupChat')
    ..aOS(7, _omitFieldNames ? '' : 'lastMessage')
    ..aOM<$6.Timestamp>(8, _omitFieldNames ? '' : 'lastMessageTime', subBuilder: $6.Timestamp.create)
    ..aOM<$6.Timestamp>(9, _omitFieldNames ? '' : 'createdAt', subBuilder: $6.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LivechatGroup clone() => LivechatGroup()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LivechatGroup copyWith(void Function(LivechatGroup) updates) => super.copyWith((message) => updates(message as LivechatGroup)) as LivechatGroup;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LivechatGroup create() => LivechatGroup._();
  LivechatGroup createEmptyInstance() => create();
  static $pb.PbList<LivechatGroup> createRepeated() => $pb.PbList<LivechatGroup>();
  @$core.pragma('dart2js:noInline')
  static LivechatGroup getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LivechatGroup>(create);
  static LivechatGroup? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get owner => $_getSZ(2);
  @$pb.TagNumber(3)
  set owner($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasOwner() => $_has(2);
  @$pb.TagNumber(3)
  void clearOwner() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$5.UserInGroup> get members => $_getList(3);

  @$pb.TagNumber(5)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(4);

  @$pb.TagNumber(6)
  $core.bool get isGroupChat => $_getBF(5);
  @$pb.TagNumber(6)
  set isGroupChat($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIsGroupChat() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsGroupChat() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get lastMessage => $_getSZ(6);
  @$pb.TagNumber(7)
  set lastMessage($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasLastMessage() => $_has(6);
  @$pb.TagNumber(7)
  void clearLastMessage() => clearField(7);

  @$pb.TagNumber(8)
  $6.Timestamp get lastMessageTime => $_getN(7);
  @$pb.TagNumber(8)
  set lastMessageTime($6.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasLastMessageTime() => $_has(7);
  @$pb.TagNumber(8)
  void clearLastMessageTime() => clearField(8);
  @$pb.TagNumber(8)
  $6.Timestamp ensureLastMessageTime() => $_ensure(7);

  @$pb.TagNumber(9)
  $6.Timestamp get createdAt => $_getN(8);
  @$pb.TagNumber(9)
  set createdAt($6.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasCreatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearCreatedAt() => clearField(9);
  @$pb.TagNumber(9)
  $6.Timestamp ensureCreatedAt() => $_ensure(8);
}

class LivechatMessage extends $pb.GeneratedMessage {
  factory LivechatMessage({
    $core.String? id,
    $core.String? groupId,
    $core.String? type,
    $core.String? owner,
    $core.String? content,
    $fixnum.Int64? createdAt,
    $fixnum.Int64? updatedAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (groupId != null) {
      $result.groupId = groupId;
    }
    if (type != null) {
      $result.type = type;
    }
    if (owner != null) {
      $result.owner = owner;
    }
    if (content != null) {
      $result.content = content;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    return $result;
  }
  LivechatMessage._() : super();
  factory LivechatMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LivechatMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LivechatMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'groupId')
    ..aOS(3, _omitFieldNames ? '' : 'type')
    ..aOS(4, _omitFieldNames ? '' : 'owner')
    ..aOS(5, _omitFieldNames ? '' : 'content')
    ..aInt64(6, _omitFieldNames ? '' : 'createdAt')
    ..aInt64(7, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LivechatMessage clone() => LivechatMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LivechatMessage copyWith(void Function(LivechatMessage) updates) => super.copyWith((message) => updates(message as LivechatMessage)) as LivechatMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LivechatMessage create() => LivechatMessage._();
  LivechatMessage createEmptyInstance() => create();
  static $pb.PbList<LivechatMessage> createRepeated() => $pb.PbList<LivechatMessage>();
  @$core.pragma('dart2js:noInline')
  static LivechatMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LivechatMessage>(create);
  static LivechatMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get groupId => $_getSZ(1);
  @$pb.TagNumber(2)
  set groupId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasGroupId() => $_has(1);
  @$pb.TagNumber(2)
  void clearGroupId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get type => $_getSZ(2);
  @$pb.TagNumber(3)
  set type($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get owner => $_getSZ(3);
  @$pb.TagNumber(4)
  set owner($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasOwner() => $_has(3);
  @$pb.TagNumber(4)
  void clearOwner() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get content => $_getSZ(4);
  @$pb.TagNumber(5)
  set content($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasContent() => $_has(4);
  @$pb.TagNumber(5)
  void clearContent() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get createdAt => $_getI64(5);
  @$pb.TagNumber(6)
  set createdAt($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCreatedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearCreatedAt() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get updatedAt => $_getI64(6);
  @$pb.TagNumber(7)
  set updatedAt($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasUpdatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearUpdatedAt() => clearField(7);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
