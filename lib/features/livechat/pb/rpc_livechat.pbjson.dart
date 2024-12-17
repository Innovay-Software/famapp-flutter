//
//  Generated code. Do not modify.
//  source: rpc_livechat.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use sendMessageRequestDescriptor instead')
const SendMessageRequest$json = {
  '1': 'SendMessageRequest',
  '2': [
    {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    {'1': 'content', '3': 2, '4': 1, '5': 9, '10': 'content'},
    {'1': 'type', '3': 3, '4': 1, '5': 9, '10': 'type'},
  ],
};

/// Descriptor for `SendMessageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendMessageRequestDescriptor = $convert.base64Decode(
    'ChJTZW5kTWVzc2FnZVJlcXVlc3QSGQoIZ3JvdXBfaWQYASABKAlSB2dyb3VwSWQSGAoHY29udG'
    'VudBgCIAEoCVIHY29udGVudBISCgR0eXBlGAMgASgJUgR0eXBl');

@$core.Deprecated('Use getLatestMessagesRequestDescriptor instead')
const GetLatestMessagesRequest$json = {
  '1': 'GetLatestMessagesRequest',
  '2': [
    {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    {'1': 'pivot_datetime', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'pivotDatetime'},
  ],
};

/// Descriptor for `GetLatestMessagesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLatestMessagesRequestDescriptor = $convert.base64Decode(
    'ChhHZXRMYXRlc3RNZXNzYWdlc1JlcXVlc3QSGQoIZ3JvdXBfaWQYASABKAlSB2dyb3VwSWQSQQ'
    'oOcGl2b3RfZGF0ZXRpbWUYAiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUg1waXZv'
    'dERhdGV0aW1l');

@$core.Deprecated('Use getLatestMessagesResponseDescriptor instead')
const GetLatestMessagesResponse$json = {
  '1': 'GetLatestMessagesResponse',
  '2': [
    {'1': 'messages', '3': 1, '4': 3, '5': 11, '6': '.pb.LivechatMessage', '10': 'messages'},
  ],
};

/// Descriptor for `GetLatestMessagesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLatestMessagesResponseDescriptor = $convert.base64Decode(
    'ChlHZXRMYXRlc3RNZXNzYWdlc1Jlc3BvbnNlEi8KCG1lc3NhZ2VzGAEgAygLMhMucGIuTGl2ZW'
    'NoYXRNZXNzYWdlUghtZXNzYWdlcw==');

@$core.Deprecated('Use createLivechatGroupRequestDescriptor instead')
const CreateLivechatGroupRequest$json = {
  '1': 'CreateLivechatGroupRequest',
  '2': [
    {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    {'1': 'members', '3': 2, '4': 3, '5': 9, '10': 'members'},
  ],
};

/// Descriptor for `CreateLivechatGroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createLivechatGroupRequestDescriptor = $convert.base64Decode(
    'ChpDcmVhdGVMaXZlY2hhdEdyb3VwUmVxdWVzdBIUCgV0aXRsZRgBIAEoCVIFdGl0bGUSGAoHbW'
    'VtYmVycxgCIAMoCVIHbWVtYmVycw==');

@$core.Deprecated('Use createLivechatGroupResponseDescriptor instead')
const CreateLivechatGroupResponse$json = {
  '1': 'CreateLivechatGroupResponse',
  '2': [
    {'1': 'livechat_group', '3': 1, '4': 1, '5': 11, '6': '.pb.LivechatGroup', '10': 'livechatGroup'},
  ],
};

/// Descriptor for `CreateLivechatGroupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createLivechatGroupResponseDescriptor = $convert.base64Decode(
    'ChtDcmVhdGVMaXZlY2hhdEdyb3VwUmVzcG9uc2USOAoObGl2ZWNoYXRfZ3JvdXAYASABKAsyES'
    '5wYi5MaXZlY2hhdEdyb3VwUg1saXZlY2hhdEdyb3Vw');

@$core.Deprecated('Use updateLivechatGroupRequestDescriptor instead')
const UpdateLivechatGroupRequest$json = {
  '1': 'UpdateLivechatGroupRequest',
  '2': [
    {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'members', '3': 3, '4': 3, '5': 9, '10': 'members'},
  ],
};

/// Descriptor for `UpdateLivechatGroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateLivechatGroupRequestDescriptor = $convert.base64Decode(
    'ChpVcGRhdGVMaXZlY2hhdEdyb3VwUmVxdWVzdBIZCghncm91cF9pZBgBIAEoCVIHZ3JvdXBJZB'
    'IUCgV0aXRsZRgCIAEoCVIFdGl0bGUSGAoHbWVtYmVycxgDIAMoCVIHbWVtYmVycw==');

@$core.Deprecated('Use updateLivechatGroupResponseDescriptor instead')
const UpdateLivechatGroupResponse$json = {
  '1': 'UpdateLivechatGroupResponse',
  '2': [
    {'1': 'livechat_group', '3': 1, '4': 1, '5': 11, '6': '.pb.LivechatGroup', '10': 'livechatGroup'},
  ],
};

/// Descriptor for `UpdateLivechatGroupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateLivechatGroupResponseDescriptor = $convert.base64Decode(
    'ChtVcGRhdGVMaXZlY2hhdEdyb3VwUmVzcG9uc2USOAoObGl2ZWNoYXRfZ3JvdXAYASABKAsyES'
    '5wYi5MaXZlY2hhdEdyb3VwUg1saXZlY2hhdEdyb3Vw');

