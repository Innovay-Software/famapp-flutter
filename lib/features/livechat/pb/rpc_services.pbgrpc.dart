//
//  Generated code. Do not modify.
//  source: rpc_services.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'message_livechat.pb.dart' as $3;
import 'rpc_livechat.pb.dart' as $2;
import 'rpc_login.pb.dart' as $1;
import 'rpc_services.pb.dart' as $0;
import 'rpc_services_user_general.pb.dart' as $4;

export 'rpc_services.pb.dart';

@$pb.GrpcServiceName('pb.GrpcServerService')
class GrpcServerServiceClient extends $grpc.Client {
  static final _$accessTokenLogin = $grpc.ClientMethod<$0.EmptyRequest, $1.AccessTokenLoginResponse>(
      '/pb.GrpcServerService/AccessTokenLogin',
      ($0.EmptyRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.AccessTokenLoginResponse.fromBuffer(value));
  static final _$getLatestMessages = $grpc.ClientMethod<$2.GetLatestMessagesRequest, $2.GetLatestMessagesResponse>(
      '/pb.GrpcServerService/GetLatestMessages',
      ($2.GetLatestMessagesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.GetLatestMessagesResponse.fromBuffer(value));
  static final _$createLivechatGroup = $grpc.ClientMethod<$2.CreateLivechatGroupRequest, $2.CreateLivechatGroupResponse>(
      '/pb.GrpcServerService/CreateLivechatGroup',
      ($2.CreateLivechatGroupRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.CreateLivechatGroupResponse.fromBuffer(value));
  static final _$updateLivechatGroup = $grpc.ClientMethod<$2.UpdateLivechatGroupRequest, $2.UpdateLivechatGroupResponse>(
      '/pb.GrpcServerService/UpdateLivechatGroup',
      ($2.UpdateLivechatGroupRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.UpdateLivechatGroupResponse.fromBuffer(value));
  static final _$sendMessage = $grpc.ClientMethod<$2.SendMessageRequest, $3.LivechatMessage>(
      '/pb.GrpcServerService/SendMessage',
      ($2.SendMessageRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.LivechatMessage.fromBuffer(value));
  static final _$userGeneral = $grpc.ClientMethod<$4.UserGeneralRequest, $4.UserGeneralResponse>(
      '/pb.GrpcServerService/UserGeneral',
      ($4.UserGeneralRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.UserGeneralResponse.fromBuffer(value));

  GrpcServerServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$1.AccessTokenLoginResponse> accessTokenLogin($0.EmptyRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$accessTokenLogin, request, options: options);
  }

  $grpc.ResponseFuture<$2.GetLatestMessagesResponse> getLatestMessages($2.GetLatestMessagesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLatestMessages, request, options: options);
  }

  $grpc.ResponseFuture<$2.CreateLivechatGroupResponse> createLivechatGroup($2.CreateLivechatGroupRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createLivechatGroup, request, options: options);
  }

  $grpc.ResponseFuture<$2.UpdateLivechatGroupResponse> updateLivechatGroup($2.UpdateLivechatGroupRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateLivechatGroup, request, options: options);
  }

  $grpc.ResponseStream<$3.LivechatMessage> sendMessage($async.Stream<$2.SendMessageRequest> request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$sendMessage, request, options: options);
  }

  $grpc.ResponseStream<$4.UserGeneralResponse> userGeneral($async.Stream<$4.UserGeneralRequest> request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$userGeneral, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.GrpcServerService')
abstract class GrpcServerServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.GrpcServerService';

  GrpcServerServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.EmptyRequest, $1.AccessTokenLoginResponse>(
        'AccessTokenLogin',
        accessTokenLogin_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.EmptyRequest.fromBuffer(value),
        ($1.AccessTokenLoginResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetLatestMessagesRequest, $2.GetLatestMessagesResponse>(
        'GetLatestMessages',
        getLatestMessages_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.GetLatestMessagesRequest.fromBuffer(value),
        ($2.GetLatestMessagesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.CreateLivechatGroupRequest, $2.CreateLivechatGroupResponse>(
        'CreateLivechatGroup',
        createLivechatGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.CreateLivechatGroupRequest.fromBuffer(value),
        ($2.CreateLivechatGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.UpdateLivechatGroupRequest, $2.UpdateLivechatGroupResponse>(
        'UpdateLivechatGroup',
        updateLivechatGroup_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.UpdateLivechatGroupRequest.fromBuffer(value),
        ($2.UpdateLivechatGroupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.SendMessageRequest, $3.LivechatMessage>(
        'SendMessage',
        sendMessage,
        true,
        true,
        ($core.List<$core.int> value) => $2.SendMessageRequest.fromBuffer(value),
        ($3.LivechatMessage value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.UserGeneralRequest, $4.UserGeneralResponse>(
        'UserGeneral',
        userGeneral,
        true,
        true,
        ($core.List<$core.int> value) => $4.UserGeneralRequest.fromBuffer(value),
        ($4.UserGeneralResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.AccessTokenLoginResponse> accessTokenLogin_Pre($grpc.ServiceCall call, $async.Future<$0.EmptyRequest> request) async {
    return accessTokenLogin(call, await request);
  }

  $async.Future<$2.GetLatestMessagesResponse> getLatestMessages_Pre($grpc.ServiceCall call, $async.Future<$2.GetLatestMessagesRequest> request) async {
    return getLatestMessages(call, await request);
  }

  $async.Future<$2.CreateLivechatGroupResponse> createLivechatGroup_Pre($grpc.ServiceCall call, $async.Future<$2.CreateLivechatGroupRequest> request) async {
    return createLivechatGroup(call, await request);
  }

  $async.Future<$2.UpdateLivechatGroupResponse> updateLivechatGroup_Pre($grpc.ServiceCall call, $async.Future<$2.UpdateLivechatGroupRequest> request) async {
    return updateLivechatGroup(call, await request);
  }

  $async.Future<$1.AccessTokenLoginResponse> accessTokenLogin($grpc.ServiceCall call, $0.EmptyRequest request);
  $async.Future<$2.GetLatestMessagesResponse> getLatestMessages($grpc.ServiceCall call, $2.GetLatestMessagesRequest request);
  $async.Future<$2.CreateLivechatGroupResponse> createLivechatGroup($grpc.ServiceCall call, $2.CreateLivechatGroupRequest request);
  $async.Future<$2.UpdateLivechatGroupResponse> updateLivechatGroup($grpc.ServiceCall call, $2.UpdateLivechatGroupRequest request);
  $async.Stream<$3.LivechatMessage> sendMessage($grpc.ServiceCall call, $async.Stream<$2.SendMessageRequest> request);
  $async.Stream<$4.UserGeneralResponse> userGeneral($grpc.ServiceCall call, $async.Stream<$4.UserGeneralRequest> request);
}
