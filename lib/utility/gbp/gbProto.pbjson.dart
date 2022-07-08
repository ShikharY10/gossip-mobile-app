///
//  Generated code. Do not modify.
//  source: gbProto.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use msgFormatDescriptor instead')
const MsgFormat$json = const {
  '1': 'MsgFormat',
  '2': const [
    const {'1': 'Sid', '3': 1, '4': 1, '5': 9, '10': 'Sid'},
    const {'1': 'Msg', '3': 2, '4': 1, '5': 9, '10': 'Msg'},
    const {'1': 'Mloc', '3': 3, '4': 1, '5': 9, '10': 'Mloc'},
  ],
};

/// Descriptor for `MsgFormat`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List msgFormatDescriptor = $convert.base64Decode('CglNc2dGb3JtYXQSEAoDU2lkGAEgASgJUgNTaWQSEAoDTXNnGAIgASgJUgNNc2cSEgoETWxvYxgDIAEoCVIETWxvYw==');
@$core.Deprecated('Use chatPayloadDescriptor instead')
const ChatPayload$json = const {
  '1': 'ChatPayload',
  '2': const [
    const {'1': 'Tid', '3': 1, '4': 1, '5': 9, '10': 'Tid'},
    const {'1': 'Sid', '3': 2, '4': 1, '5': 9, '10': 'Sid'},
    const {'1': 'Msg', '3': 3, '4': 1, '5': 9, '10': 'Msg'},
  ],
};

/// Descriptor for `ChatPayload`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatPayloadDescriptor = $convert.base64Decode('CgtDaGF0UGF5bG9hZBIQCgNUaWQYASABKAlSA1RpZBIQCgNTaWQYAiABKAlSA1NpZBIQCgNNc2cYAyABKAlSA01zZw==');
@$core.Deprecated('Use transportDescriptor instead')
const Transport$json = const {
  '1': 'Transport',
  '2': const [
    const {'1': 'Msg', '3': 1, '4': 1, '5': 12, '10': 'Msg'},
    const {'1': 'Id', '3': 2, '4': 1, '5': 9, '10': 'Id'},
    const {'1': 'Tp', '3': 3, '4': 1, '5': 5, '10': 'Tp'},
  ],
};

/// Descriptor for `Transport`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transportDescriptor = $convert.base64Decode('CglUcmFuc3BvcnQSEAoDTXNnGAEgASgMUgNNc2cSDgoCSWQYAiABKAlSAklkEg4KAlRwGAMgASgFUgJUcA==');
@$core.Deprecated('Use notifyDescriptor instead')
const Notify$json = const {
  '1': 'Notify',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'tp', '3': 2, '4': 1, '5': 5, '10': 'tp'},
  ],
};

/// Descriptor for `Notify`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List notifyDescriptor = $convert.base64Decode('CgZOb3RpZnkSDgoCaWQYASABKAlSAmlkEg4KAnRwGAIgASgFUgJ0cA==');
@$core.Deprecated('Use clientNameDescriptor instead')
const ClientName$json = const {
  '1': 'ClientName',
  '2': const [
    const {'1': 'UId', '3': 1, '4': 1, '5': 9, '10': 'UId'},
    const {'1': 'MId', '3': 2, '4': 1, '5': 9, '10': 'MId'},
  ],
};

/// Descriptor for `ClientName`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clientNameDescriptor = $convert.base64Decode('CgpDbGllbnROYW1lEhAKA1VJZBgBIAEoCVIDVUlkEhAKA01JZBgCIAEoCVIDTUlk');
@$core.Deprecated('Use chatAckDescriptor instead')
const ChatAck$json = const {
  '1': 'ChatAck',
  '2': const [
    const {'1': 'MId', '3': 1, '4': 1, '5': 9, '10': 'MId'},
    const {'1': 'MLoc', '3': 2, '4': 1, '5': 9, '10': 'MLoc'},
  ],
};

/// Descriptor for `ChatAck`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatAckDescriptor = $convert.base64Decode('CgdDaGF0QWNrEhAKA01JZBgBIAEoCVIDTUlkEhIKBE1Mb2MYAiABKAlSBE1Mb2M=');
@$core.Deprecated('Use handShackP1Descriptor instead')
const HandShackP1$json = const {
  '1': 'HandShackP1',
  '2': const [
    const {'1': 'TargetMobile', '3': 1, '4': 1, '5': 9, '10': 'TargetMobile'},
    const {'1': 'SenderMID', '3': 2, '4': 1, '5': 9, '10': 'SenderMID'},
    const {'1': 'PublicKey', '3': 3, '4': 1, '5': 9, '10': 'PublicKey'},
    const {'1': 'Hsid', '3': 4, '4': 1, '5': 9, '10': 'Hsid'},
    const {'1': 'Mloc', '3': 5, '4': 1, '5': 9, '10': 'Mloc'},
  ],
};

/// Descriptor for `HandShackP1`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List handShackP1Descriptor = $convert.base64Decode('CgtIYW5kU2hhY2tQMRIiCgxUYXJnZXRNb2JpbGUYASABKAlSDFRhcmdldE1vYmlsZRIcCglTZW5kZXJNSUQYAiABKAlSCVNlbmRlck1JRBIcCglQdWJsaWNLZXkYAyABKAlSCVB1YmxpY0tleRISCgRIc2lkGAQgASgJUgRIc2lkEhIKBE1sb2MYBSABKAlSBE1sb2M=');
@$core.Deprecated('Use handShackP2Descriptor instead')
const HandShackP2$json = const {
  '1': 'HandShackP2',
  '2': const [
    const {'1': 'EncryptedData', '3': 1, '4': 1, '5': 9, '10': 'EncryptedData'},
    const {'1': 'TargetMID', '3': 2, '4': 1, '5': 9, '10': 'TargetMID'},
    const {'1': 'SenderMID', '3': 3, '4': 1, '5': 9, '10': 'SenderMID'},
    const {'1': 'Hsid', '3': 4, '4': 1, '5': 9, '10': 'Hsid'},
    const {'1': 'Mloc', '3': 5, '4': 1, '5': 9, '10': 'Mloc'},
    const {'1': 'Permit', '3': 6, '4': 1, '5': 5, '10': 'Permit'},
  ],
};

/// Descriptor for `HandShackP2`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List handShackP2Descriptor = $convert.base64Decode('CgtIYW5kU2hhY2tQMhIkCg1FbmNyeXB0ZWREYXRhGAEgASgJUg1FbmNyeXB0ZWREYXRhEhwKCVRhcmdldE1JRBgCIAEoCVIJVGFyZ2V0TUlEEhwKCVNlbmRlck1JRBgDIAEoCVIJU2VuZGVyTUlEEhIKBEhzaWQYBCABKAlSBEhzaWQSEgoETWxvYxgFIAEoCVIETWxvYxIWCgZQZXJtaXQYBiABKAVSBlBlcm1pdA==');
@$core.Deprecated('Use connDataTransferDescriptor instead')
const ConnDataTransfer$json = const {
  '1': 'ConnDataTransfer',
  '2': const [
    const {'1': 'Name', '3': 1, '4': 1, '5': 9, '10': 'Name'},
    const {'1': 'Number', '3': 2, '4': 1, '5': 9, '10': 'Number'},
    const {'1': 'MID', '3': 3, '4': 1, '5': 9, '10': 'MID'},
    const {'1': 'ProfilePic', '3': 4, '4': 1, '5': 9, '10': 'ProfilePic'},
    const {'1': 'Hsid', '3': 5, '4': 1, '5': 9, '10': 'Hsid'},
    const {'1': 'Mloc', '3': 6, '4': 1, '5': 9, '10': 'Mloc'},
  ],
};

/// Descriptor for `ConnDataTransfer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connDataTransferDescriptor = $convert.base64Decode('ChBDb25uRGF0YVRyYW5zZmVyEhIKBE5hbWUYASABKAlSBE5hbWUSFgoGTnVtYmVyGAIgASgJUgZOdW1iZXISEAoDTUlEGAMgASgJUgNNSUQSHgoKUHJvZmlsZVBpYxgEIAEoCVIKUHJvZmlsZVBpYxISCgRIc2lkGAUgASgJUgRIc2lkEhIKBE1sb2MYBiABKAlSBE1sb2M=');
@$core.Deprecated('Use handshakeDeleteNotifyDescriptor instead')
const HandshakeDeleteNotify$json = const {
  '1': 'HandshakeDeleteNotify',
  '2': const [
    const {'1': 'SenderMID', '3': 1, '4': 1, '5': 9, '10': 'SenderMID'},
    const {'1': 'TargetMID', '3': 2, '4': 1, '5': 9, '10': 'TargetMID'},
    const {'1': 'Number', '3': 3, '4': 1, '5': 9, '10': 'Number'},
    const {'1': 'Mloc', '3': 4, '4': 1, '5': 9, '10': 'Mloc'},
  ],
};

/// Descriptor for `HandshakeDeleteNotify`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List handshakeDeleteNotifyDescriptor = $convert.base64Decode('ChVIYW5kc2hha2VEZWxldGVOb3RpZnkSHAoJU2VuZGVyTUlEGAEgASgJUglTZW5kZXJNSUQSHAoJVGFyZ2V0TUlEGAIgASgJUglUYXJnZXRNSUQSFgoGTnVtYmVyGAMgASgJUgZOdW1iZXISEgoETWxvYxgEIAEoCVIETWxvYw==');
@$core.Deprecated('Use changeProfilePayloadDescriptor instead')
const ChangeProfilePayload$json = const {
  '1': 'ChangeProfilePayload',
  '2': const [
    const {'1': 'PicData', '3': 1, '4': 1, '5': 9, '10': 'PicData'},
    const {'1': 'SenderMID', '3': 2, '4': 1, '5': 9, '10': 'SenderMID'},
    const {'1': 'TargetMID', '3': 3, '4': 1, '5': 9, '10': 'TargetMID'},
    const {'1': 'Mloc', '3': 4, '4': 1, '5': 9, '10': 'Mloc'},
  ],
};

/// Descriptor for `ChangeProfilePayload`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List changeProfilePayloadDescriptor = $convert.base64Decode('ChRDaGFuZ2VQcm9maWxlUGF5bG9hZBIYCgdQaWNEYXRhGAEgASgJUgdQaWNEYXRhEhwKCVNlbmRlck1JRBgCIAEoCVIJU2VuZGVyTUlEEhwKCVRhcmdldE1JRBgDIAEoCVIJVGFyZ2V0TUlEEhIKBE1sb2MYBCABKAlSBE1sb2M=');
