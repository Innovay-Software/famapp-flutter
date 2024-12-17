//
//  Generated code. Do not modify.
//  source: message_livechat.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use livechatGroupDescriptor instead')
const LivechatGroup$json = {
  '1': 'LivechatGroup',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'owner', '3': 3, '4': 1, '5': 9, '10': 'owner'},
    {'1': 'members', '3': 4, '4': 3, '5': 11, '6': '.pb.UserInGroup', '10': 'members'},
    {'1': 'metadata', '3': 5, '4': 3, '5': 11, '6': '.pb.LivechatGroup.MetadataEntry', '10': 'metadata'},
    {'1': 'is_group_chat', '3': 6, '4': 1, '5': 8, '10': 'isGroupChat'},
    {'1': 'last_message', '3': 7, '4': 1, '5': 9, '10': 'lastMessage'},
    {'1': 'last_message_time', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastMessageTime'},
    {'1': 'created_at', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
  '3': [LivechatGroup_MetadataEntry$json],
};

@$core.Deprecated('Use livechatGroupDescriptor instead')
const LivechatGroup_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `LivechatGroup`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List livechatGroupDescriptor = $convert.base64Decode(
    'Cg1MaXZlY2hhdEdyb3VwEg4KAmlkGAEgASgJUgJpZBIUCgV0aXRsZRgCIAEoCVIFdGl0bGUSFA'
    'oFb3duZXIYAyABKAlSBW93bmVyEikKB21lbWJlcnMYBCADKAsyDy5wYi5Vc2VySW5Hcm91cFIH'
    'bWVtYmVycxI7CghtZXRhZGF0YRgFIAMoCzIfLnBiLkxpdmVjaGF0R3JvdXAuTWV0YWRhdGFFbn'
    'RyeVIIbWV0YWRhdGESIgoNaXNfZ3JvdXBfY2hhdBgGIAEoCFILaXNHcm91cENoYXQSIQoMbGFz'
    'dF9tZXNzYWdlGAcgASgJUgtsYXN0TWVzc2FnZRJGChFsYXN0X21lc3NhZ2VfdGltZRgIIAEoCz'
    'IaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSD2xhc3RNZXNzYWdlVGltZRI5CgpjcmVhdGVk'
    'X2F0GAkgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0GjsKDU1ldG'
    'FkYXRhRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use livechatMessageDescriptor instead')
const LivechatMessage$json = {
  '1': 'LivechatMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'group_id', '3': 2, '4': 1, '5': 9, '10': 'groupId'},
    {'1': 'type', '3': 3, '4': 1, '5': 9, '10': 'type'},
    {'1': 'owner', '3': 4, '4': 1, '5': 9, '10': 'owner'},
    {'1': 'content', '3': 5, '4': 1, '5': 9, '10': 'content'},
    {'1': 'created_at', '3': 6, '4': 1, '5': 3, '10': 'createdAt'},
    {'1': 'updated_at', '3': 7, '4': 1, '5': 3, '10': 'updatedAt'},
  ],
};

/// Descriptor for `LivechatMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List livechatMessageDescriptor = $convert.base64Decode(
    'Cg9MaXZlY2hhdE1lc3NhZ2USDgoCaWQYASABKAlSAmlkEhkKCGdyb3VwX2lkGAIgASgJUgdncm'
    '91cElkEhIKBHR5cGUYAyABKAlSBHR5cGUSFAoFb3duZXIYBCABKAlSBW93bmVyEhgKB2NvbnRl'
    'bnQYBSABKAlSB2NvbnRlbnQSHQoKY3JlYXRlZF9hdBgGIAEoA1IJY3JlYXRlZEF0Eh0KCnVwZG'
    'F0ZWRfYXQYByABKANSCXVwZGF0ZWRBdA==');

