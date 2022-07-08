///
//  Generated code. Do not modify.
//  source: internalProto.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use recentGossipsDescriptor instead')
const RecentGossips$json = const {
  '1': 'RecentGossips',
  '2': const [
    const {'1': 'Name', '3': 1, '4': 1, '5': 9, '10': 'Name'},
    const {'1': 'LastMsg', '3': 2, '4': 1, '5': 9, '10': 'LastMsg'},
    const {'1': 'SenderMID', '3': 3, '4': 1, '5': 9, '10': 'SenderMID'},
    const {'1': 'DateTime', '3': 4, '4': 1, '5': 9, '10': 'DateTime'},
    const {'1': 'UnSeenMsgCount', '3': 5, '4': 1, '5': 5, '10': 'UnSeenMsgCount'},
    const {'1': 'ProfilePic', '3': 6, '4': 1, '5': 9, '10': 'ProfilePic'},
  ],
};

/// Descriptor for `RecentGossips`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recentGossipsDescriptor = $convert.base64Decode('Cg1SZWNlbnRHb3NzaXBzEhIKBE5hbWUYASABKAlSBE5hbWUSGAoHTGFzdE1zZxgCIAEoCVIHTGFzdE1zZxIcCglTZW5kZXJNSUQYAyABKAlSCVNlbmRlck1JRBIaCghEYXRlVGltZRgEIAEoCVIIRGF0ZVRpbWUSJgoOVW5TZWVuTXNnQ291bnQYBSABKAVSDlVuU2Vlbk1zZ0NvdW50Eh4KClByb2ZpbGVQaWMYBiABKAlSClByb2ZpbGVQaWM=');
@$core.Deprecated('Use contactDescriptor instead')
const Contact$json = const {
  '1': 'Contact',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'number', '3': 2, '4': 1, '5': 9, '10': 'number'},
    const {'1': 'done', '3': 3, '4': 1, '5': 8, '10': 'done'},
    const {'1': 'inProcess', '3': 4, '4': 1, '5': 8, '10': 'inProcess'},
    const {'1': 'blocked', '3': 5, '4': 1, '5': 8, '10': 'blocked'},
    const {'1': 'intoggleblock', '3': 6, '4': 1, '5': 8, '10': 'intoggleblock'},
  ],
};

/// Descriptor for `Contact`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contactDescriptor = $convert.base64Decode('CgdDb250YWN0EhIKBG5hbWUYASABKAlSBG5hbWUSFgoGbnVtYmVyGAIgASgJUgZudW1iZXISEgoEZG9uZRgDIAEoCFIEZG9uZRIcCglpblByb2Nlc3MYBCABKAhSCWluUHJvY2VzcxIYCgdibG9ja2VkGAUgASgIUgdibG9ja2VkEiQKDWludG9nZ2xlYmxvY2sYBiABKAhSDWludG9nZ2xlYmxvY2s=');
@$core.Deprecated('Use contactsDescriptor instead')
const Contacts$json = const {
  '1': 'Contacts',
  '2': const [
    const {'1': 'all', '3': 1, '4': 3, '5': 11, '6': '.main.Contact', '10': 'all'},
  ],
};

/// Descriptor for `Contacts`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contactsDescriptor = $convert.base64Decode('CghDb250YWN0cxIfCgNhbGwYASADKAsyDS5tYWluLkNvbnRhY3RSA2FsbA==');
@$core.Deprecated('Use blocksDescriptor instead')
const Blocks$json = const {
  '1': 'Blocks',
  '2': const [
    const {'1': 'all', '3': 1, '4': 3, '5': 9, '10': 'all'},
  ],
};

/// Descriptor for `Blocks`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blocksDescriptor = $convert.base64Decode('CgZCbG9ja3MSEAoDYWxsGAEgAygJUgNhbGw=');
