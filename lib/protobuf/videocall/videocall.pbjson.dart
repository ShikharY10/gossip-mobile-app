///
//  Generated code. Do not modify.
//  source: lib/protobuf/videocall/videocall.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use transportDescriptor instead')
const Transport$json = const {
  '1': 'Transport',
  '2': const [
    const {'1': 'Type', '3': 1, '4': 1, '5': 5, '10': 'Type'},
    const {'1': 'Mid', '3': 2, '4': 1, '5': 9, '10': 'Mid'},
    const {'1': 'Data', '3': 3, '4': 1, '5': 12, '10': 'Data'},
  ],
};

/// Descriptor for `Transport`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transportDescriptor = $convert.base64Decode('CglUcmFuc3BvcnQSEgoEVHlwZRgBIAEoBVIEVHlwZRIQCgNNaWQYAiABKAlSA01pZBISCgREYXRhGAMgASgMUgREYXRh');
@$core.Deprecated('Use callPacketDescriptor instead')
const CallPacket$json = const {
  '1': 'CallPacket',
  '2': const [
    const {'1': 'Type', '3': 1, '4': 1, '5': 5, '10': 'Type'},
    const {'1': 'Data', '3': 2, '4': 1, '5': 12, '10': 'Data'},
  ],
};

/// Descriptor for `CallPacket`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List callPacketDescriptor = $convert.base64Decode('CgpDYWxsUGFja2V0EhIKBFR5cGUYASABKAVSBFR5cGUSEgoERGF0YRgCIAEoDFIERGF0YQ==');
@$core.Deprecated('Use notifyPaylaodDescriptor instead')
const NotifyPaylaod$json = const {
  '1': 'NotifyPaylaod',
  '2': const [
    const {'1': 'TargetMid', '3': 1, '4': 1, '5': 9, '10': 'TargetMid'},
    const {'1': 'initiaterMid', '3': 2, '4': 1, '5': 9, '10': 'initiaterMid'},
    const {'1': 'PollName', '3': 3, '4': 1, '5': 9, '10': 'PollName'},
  ],
};

/// Descriptor for `NotifyPaylaod`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List notifyPaylaodDescriptor = $convert.base64Decode('Cg1Ob3RpZnlQYXlsYW9kEhwKCVRhcmdldE1pZBgBIAEoCVIJVGFyZ2V0TWlkEiIKDGluaXRpYXRlck1pZBgCIAEoCVIMaW5pdGlhdGVyTWlkEhoKCFBvbGxOYW1lGAMgASgJUghQb2xsTmFtZQ==');
@$core.Deprecated('Use callNotifierDescriptor instead')
const CallNotifier$json = const {
  '1': 'CallNotifier',
  '2': const [
    const {'1': 'TargetMid', '3': 1, '4': 1, '5': 9, '10': 'TargetMid'},
    const {'1': 'initiaterMid', '3': 2, '4': 1, '5': 9, '10': 'initiaterMid'},
    const {'1': 'PollName', '3': 3, '4': 1, '5': 9, '10': 'PollName'},
  ],
};

/// Descriptor for `CallNotifier`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List callNotifierDescriptor = $convert.base64Decode('CgxDYWxsTm90aWZpZXISHAoJVGFyZ2V0TWlkGAEgASgJUglUYXJnZXRNaWQSIgoMaW5pdGlhdGVyTWlkGAIgASgJUgxpbml0aWF0ZXJNaWQSGgoIUG9sbE5hbWUYAyABKAlSCFBvbGxOYW1l');
