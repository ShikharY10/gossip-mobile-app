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
    const {'1': 'inlogin', '3': 7, '4': 1, '5': 8, '10': 'inlogin'},
  ],
};

/// Descriptor for `Contact`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contactDescriptor = $convert.base64Decode('CgdDb250YWN0EhIKBG5hbWUYASABKAlSBG5hbWUSFgoGbnVtYmVyGAIgASgJUgZudW1iZXISEgoEZG9uZRgDIAEoCFIEZG9uZRIcCglpblByb2Nlc3MYBCABKAhSCWluUHJvY2VzcxIYCgdibG9ja2VkGAUgASgIUgdibG9ja2VkEiQKDWludG9nZ2xlYmxvY2sYBiABKAhSDWludG9nZ2xlYmxvY2sSGAoHaW5sb2dpbhgHIAEoCFIHaW5sb2dpbg==');
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
@$core.Deprecated('Use userDataDescriptor instead')
const UserData$json = const {
  '1': 'UserData',
  '2': const [
    const {'1': 'Name', '3': 1, '4': 1, '5': 9, '10': 'Name'},
    const {'1': 'Dob', '3': 2, '4': 1, '5': 9, '10': 'Dob'},
    const {'1': 'Gender', '3': 3, '4': 1, '5': 9, '10': 'Gender'},
    const {'1': 'Number', '3': 4, '4': 1, '5': 9, '10': 'Number'},
    const {'1': 'Email', '3': 5, '4': 1, '5': 9, '10': 'Email'},
    const {'1': 'Mid', '3': 6, '4': 1, '5': 9, '10': 'Mid'},
    const {'1': 'MainKey', '3': 7, '4': 1, '5': 9, '10': 'MainKey'},
    const {'1': 'ProfilePic', '3': 8, '4': 1, '5': 9, '10': 'ProfilePic'},
  ],
};

/// Descriptor for `UserData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDataDescriptor = $convert.base64Decode('CghVc2VyRGF0YRISCgROYW1lGAEgASgJUgROYW1lEhAKA0RvYhgCIAEoCVIDRG9iEhYKBkdlbmRlchgDIAEoCVIGR2VuZGVyEhYKBk51bWJlchgEIAEoCVIGTnVtYmVyEhQKBUVtYWlsGAUgASgJUgVFbWFpbBIQCgNNaWQYBiABKAlSA01pZBIYCgdNYWluS2V5GAcgASgJUgdNYWluS2V5Eh4KClByb2ZpbGVQaWMYCCABKAlSClByb2ZpbGVQaWM=');
@$core.Deprecated('Use connectionDataDescriptor instead')
const ConnectionData$json = const {
  '1': 'ConnectionData',
  '2': const [
    const {'1': 'Name', '3': 1, '4': 1, '5': 9, '10': 'Name'},
    const {'1': 'Number', '3': 2, '4': 1, '5': 9, '10': 'Number'},
    const {'1': 'Mid', '3': 3, '4': 1, '5': 9, '10': 'Mid'},
    const {'1': 'ProfilePic', '3': 4, '4': 1, '5': 9, '10': 'ProfilePic'},
    const {'1': 'logout', '3': 5, '4': 1, '5': 8, '10': 'logout'},
  ],
};

/// Descriptor for `ConnectionData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connectionDataDescriptor = $convert.base64Decode('Cg5Db25uZWN0aW9uRGF0YRISCgROYW1lGAEgASgJUgROYW1lEhYKBk51bWJlchgCIAEoCVIGTnVtYmVyEhAKA01pZBgDIAEoCVIDTWlkEh4KClByb2ZpbGVQaWMYBCABKAlSClByb2ZpbGVQaWMSFgoGbG9nb3V0GAUgASgIUgZsb2dvdXQ=');
@$core.Deprecated('Use loginResponseDescriptor instead')
const LoginResponse$json = const {
  '1': 'LoginResponse',
  '2': const [
    const {'1': 'MyData', '3': 1, '4': 1, '5': 11, '6': '.main.UserData', '10': 'MyData'},
    const {'1': 'ConnData', '3': 2, '4': 3, '5': 11, '6': '.main.ConnectionData', '10': 'ConnData'},
  ],
};

/// Descriptor for `LoginResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginResponseDescriptor = $convert.base64Decode('Cg1Mb2dpblJlc3BvbnNlEiYKBk15RGF0YRgBIAEoCzIOLm1haW4uVXNlckRhdGFSBk15RGF0YRIwCghDb25uRGF0YRgCIAMoCzIULm1haW4uQ29ubmVjdGlvbkRhdGFSCENvbm5EYXRh');
