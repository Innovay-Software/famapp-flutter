//
//  Generated code. Do not modify.
//  source: rpc_login.proto
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

class AccessTokenLoginResponse extends $pb.GeneratedMessage {
  factory AccessTokenLoginResponse({
    $5.User? user,
    $core.Iterable<$5.User>? friends,
    $core.Iterable<$3.LivechatGroup>? groups,
  }) {
    final $result = create();
    if (user != null) {
      $result.user = user;
    }
    if (friends != null) {
      $result.friends.addAll(friends);
    }
    if (groups != null) {
      $result.groups.addAll(groups);
    }
    return $result;
  }
  AccessTokenLoginResponse._() : super();
  factory AccessTokenLoginResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AccessTokenLoginResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AccessTokenLoginResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<$5.User>(1, _omitFieldNames ? '' : 'user', subBuilder: $5.User.create)
    ..pc<$5.User>(2, _omitFieldNames ? '' : 'friends', $pb.PbFieldType.PM, subBuilder: $5.User.create)
    ..pc<$3.LivechatGroup>(3, _omitFieldNames ? '' : 'groups', $pb.PbFieldType.PM, subBuilder: $3.LivechatGroup.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AccessTokenLoginResponse clone() => AccessTokenLoginResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AccessTokenLoginResponse copyWith(void Function(AccessTokenLoginResponse) updates) => super.copyWith((message) => updates(message as AccessTokenLoginResponse)) as AccessTokenLoginResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AccessTokenLoginResponse create() => AccessTokenLoginResponse._();
  AccessTokenLoginResponse createEmptyInstance() => create();
  static $pb.PbList<AccessTokenLoginResponse> createRepeated() => $pb.PbList<AccessTokenLoginResponse>();
  @$core.pragma('dart2js:noInline')
  static AccessTokenLoginResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AccessTokenLoginResponse>(create);
  static AccessTokenLoginResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $5.User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user($5.User v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => clearField(1);
  @$pb.TagNumber(1)
  $5.User ensureUser() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<$5.User> get friends => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<$3.LivechatGroup> get groups => $_getList(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
