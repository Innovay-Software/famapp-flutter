//
//  Generated code. Do not modify.
//  source: message_user.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use userDescriptor instead')
const User$json = {
  '1': 'User',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'uuid', '3': 2, '4': 1, '5': 9, '10': 'uuid'},
    {'1': 'family_id', '3': 3, '4': 1, '5': 5, '10': 'familyId'},
    {'1': 'name', '3': 4, '4': 1, '5': 9, '10': 'name'},
    {'1': 'email', '3': 5, '4': 1, '5': 9, '10': 'email'},
    {'1': 'mobile', '3': 6, '4': 1, '5': 9, '10': 'mobile'},
    {'1': 'avatar', '3': 7, '4': 1, '5': 9, '10': 'avatar'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode(
    'CgRVc2VyEg4KAmlkGAEgASgJUgJpZBISCgR1dWlkGAIgASgJUgR1dWlkEhsKCWZhbWlseV9pZB'
    'gDIAEoBVIIZmFtaWx5SWQSEgoEbmFtZRgEIAEoCVIEbmFtZRIUCgVlbWFpbBgFIAEoCVIFZW1h'
    'aWwSFgoGbW9iaWxlGAYgASgJUgZtb2JpbGUSFgoGYXZhdGFyGAcgASgJUgZhdmF0YXI=');

@$core.Deprecated('Use userInGroupDescriptor instead')
const UserInGroup$json = {
  '1': 'UserInGroup',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'uuid', '3': 2, '4': 1, '5': 9, '10': 'uuid'},
    {'1': 'avatar', '3': 3, '4': 1, '5': 9, '10': 'avatar'},
  ],
};

/// Descriptor for `UserInGroup`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userInGroupDescriptor = $convert.base64Decode(
    'CgtVc2VySW5Hcm91cBISCgRuYW1lGAEgASgJUgRuYW1lEhIKBHV1aWQYAiABKAlSBHV1aWQSFg'
    'oGYXZhdGFyGAMgASgJUgZhdmF0YXI=');

