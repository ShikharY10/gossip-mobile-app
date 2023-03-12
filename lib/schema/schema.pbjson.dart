///
//  Generated code. Do not modify.
//  source: lib/schema/schema.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use payloadDescriptor instead')
const Payload$json = const {
  '1': 'Payload',
  '2': const [
    const {'1': 'Data', '3': 1, '4': 1, '5': 12, '10': 'Data'},
    const {'1': 'Type', '3': 2, '4': 1, '5': 9, '10': 'Type'},
  ],
};

/// Descriptor for `Payload`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payloadDescriptor = $convert.base64Decode('CgdQYXlsb2FkEhIKBERhdGEYASABKAxSBERhdGESEgoEVHlwZRgCIAEoCVIEVHlwZQ==');
@$core.Deprecated('Use deliveryPacketDescriptor instead')
const DeliveryPacket$json = const {
  '1': 'DeliveryPacket',
  '2': const [
    const {'1': 'Payload', '3': 1, '4': 1, '5': 12, '10': 'Payload'},
    const {'1': 'TargetId', '3': 2, '4': 1, '5': 9, '10': 'TargetId'},
  ],
};

/// Descriptor for `DeliveryPacket`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deliveryPacketDescriptor = $convert.base64Decode('Cg5EZWxpdmVyeVBhY2tldBIYCgdQYXlsb2FkGAEgASgMUgdQYXlsb2FkEhoKCFRhcmdldElkGAIgASgJUghUYXJnZXRJZA==');
