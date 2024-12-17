//
//  Generated code. Do not modify.
//  source: rpc_services_user_general.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use userGeneralRequestDescriptor instead')
const UserGeneralRequest$json = {
  '1': 'UserGeneralRequest',
  '2': [
    {'1': 'is_login', '3': 1, '4': 1, '5': 8, '10': 'isLogin'},
    {'1': 'is_upsert_group', '3': 2, '4': 1, '5': 8, '10': 'isUpsertGroup'},
    {'1': 'upsert_group_id', '3': 3, '4': 1, '5': 9, '10': 'upsertGroupId'},
    {'1': 'upsert_group_id_client', '3': 4, '4': 1, '5': 9, '10': 'upsertGroupIdClient'},
    {'1': 'upsert_group_name', '3': 5, '4': 1, '5': 9, '10': 'upsertGroupName'},
    {'1': 'upsert_group_is_group_chat', '3': 6, '4': 1, '5': 8, '10': 'upsertGroupIsGroupChat'},
    {'1': 'upsert_group_member_uuids', '3': 7, '4': 3, '5': 9, '10': 'upsertGroupMemberUuids'},
    {'1': 'is_send_message', '3': 8, '4': 1, '5': 8, '10': 'isSendMessage'},
    {'1': 'send_message_group_id', '3': 9, '4': 1, '5': 9, '10': 'sendMessageGroupId'},
    {'1': 'send_message_content', '3': 10, '4': 1, '5': 9, '10': 'sendMessageContent'},
    {'1': 'send_message_type', '3': 11, '4': 1, '5': 9, '10': 'sendMessageType'},
    {'1': 'is_reword_message', '3': 12, '4': 1, '5': 8, '10': 'isRewordMessage'},
    {'1': 'reword_message_content', '3': 13, '4': 1, '5': 9, '10': 'rewordMessageContent'},
  ],
};

/// Descriptor for `UserGeneralRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userGeneralRequestDescriptor = $convert.base64Decode(
    'ChJVc2VyR2VuZXJhbFJlcXVlc3QSGQoIaXNfbG9naW4YASABKAhSB2lzTG9naW4SJgoPaXNfdX'
    'BzZXJ0X2dyb3VwGAIgASgIUg1pc1Vwc2VydEdyb3VwEiYKD3Vwc2VydF9ncm91cF9pZBgDIAEo'
    'CVINdXBzZXJ0R3JvdXBJZBIzChZ1cHNlcnRfZ3JvdXBfaWRfY2xpZW50GAQgASgJUhN1cHNlcn'
    'RHcm91cElkQ2xpZW50EioKEXVwc2VydF9ncm91cF9uYW1lGAUgASgJUg91cHNlcnRHcm91cE5h'
    'bWUSOgoadXBzZXJ0X2dyb3VwX2lzX2dyb3VwX2NoYXQYBiABKAhSFnVwc2VydEdyb3VwSXNHcm'
    '91cENoYXQSOQoZdXBzZXJ0X2dyb3VwX21lbWJlcl91dWlkcxgHIAMoCVIWdXBzZXJ0R3JvdXBN'
    'ZW1iZXJVdWlkcxImCg9pc19zZW5kX21lc3NhZ2UYCCABKAhSDWlzU2VuZE1lc3NhZ2USMQoVc2'
    'VuZF9tZXNzYWdlX2dyb3VwX2lkGAkgASgJUhJzZW5kTWVzc2FnZUdyb3VwSWQSMAoUc2VuZF9t'
    'ZXNzYWdlX2NvbnRlbnQYCiABKAlSEnNlbmRNZXNzYWdlQ29udGVudBIqChFzZW5kX21lc3NhZ2'
    'VfdHlwZRgLIAEoCVIPc2VuZE1lc3NhZ2VUeXBlEioKEWlzX3Jld29yZF9tZXNzYWdlGAwgASgI'
    'Ug9pc1Jld29yZE1lc3NhZ2USNAoWcmV3b3JkX21lc3NhZ2VfY29udGVudBgNIAEoCVIUcmV3b3'
    'JkTWVzc2FnZUNvbnRlbnQ=');

@$core.Deprecated('Use userGeneralResponseDescriptor instead')
const UserGeneralResponse$json = {
  '1': 'UserGeneralResponse',
  '2': [
    {'1': 'is_login', '3': 1, '4': 1, '5': 8, '10': 'isLogin'},
    {'1': 'user', '3': 2, '4': 1, '5': 11, '6': '.pb.User', '10': 'user'},
    {'1': 'friends', '3': 3, '4': 3, '5': 11, '6': '.pb.User', '10': 'friends'},
    {'1': 'groups', '3': 4, '4': 3, '5': 11, '6': '.pb.LivechatGroup', '10': 'groups'},
    {'1': 'is_upsert_group', '3': 5, '4': 1, '5': 8, '10': 'isUpsertGroup'},
    {'1': 'new_group', '3': 6, '4': 1, '5': 11, '6': '.pb.LivechatGroup', '10': 'newGroup'},
    {'1': 'new_group_client_id', '3': 7, '4': 1, '5': 9, '10': 'newGroupClientId'},
    {'1': 'is_new_message', '3': 8, '4': 1, '5': 8, '10': 'isNewMessage'},
    {'1': 'new_message', '3': 9, '4': 1, '5': 11, '6': '.pb.LivechatMessage', '10': 'newMessage'},
    {'1': 'is_reword_message', '3': 10, '4': 1, '5': 8, '10': 'isRewordMessage'},
    {'1': 'reword_message', '3': 11, '4': 1, '5': 11, '6': '.pb.LivechatMessage', '10': 'rewordMessage'},
  ],
};

/// Descriptor for `UserGeneralResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userGeneralResponseDescriptor = $convert.base64Decode(
    'ChNVc2VyR2VuZXJhbFJlc3BvbnNlEhkKCGlzX2xvZ2luGAEgASgIUgdpc0xvZ2luEhwKBHVzZX'
    'IYAiABKAsyCC5wYi5Vc2VyUgR1c2VyEiIKB2ZyaWVuZHMYAyADKAsyCC5wYi5Vc2VyUgdmcmll'
    'bmRzEikKBmdyb3VwcxgEIAMoCzIRLnBiLkxpdmVjaGF0R3JvdXBSBmdyb3VwcxImCg9pc191cH'
    'NlcnRfZ3JvdXAYBSABKAhSDWlzVXBzZXJ0R3JvdXASLgoJbmV3X2dyb3VwGAYgASgLMhEucGIu'
    'TGl2ZWNoYXRHcm91cFIIbmV3R3JvdXASLQoTbmV3X2dyb3VwX2NsaWVudF9pZBgHIAEoCVIQbm'
    'V3R3JvdXBDbGllbnRJZBIkCg5pc19uZXdfbWVzc2FnZRgIIAEoCFIMaXNOZXdNZXNzYWdlEjQK'
    'C25ld19tZXNzYWdlGAkgASgLMhMucGIuTGl2ZWNoYXRNZXNzYWdlUgpuZXdNZXNzYWdlEioKEW'
    'lzX3Jld29yZF9tZXNzYWdlGAogASgIUg9pc1Jld29yZE1lc3NhZ2USOgoOcmV3b3JkX21lc3Nh'
    'Z2UYCyABKAsyEy5wYi5MaXZlY2hhdE1lc3NhZ2VSDXJld29yZE1lc3NhZ2U=');

