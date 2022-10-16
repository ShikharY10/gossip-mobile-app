///
//  Generated code. Do not modify.
//  source: lib/protobuf/videocall/videocall.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Transport extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Transport', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'main'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Type', $pb.PbFieldType.O3, protoName: 'Type')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Mid', protoName: 'Mid')
    ..a<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Data', $pb.PbFieldType.OY, protoName: 'Data')
    ..hasRequiredFields = false
  ;

  Transport._() : super();
  factory Transport({
    $core.int? type,
    $core.String? mid,
    $core.List<$core.int>? data,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (mid != null) {
      _result.mid = mid;
    }
    if (data != null) {
      _result.data = data;
    }
    return _result;
  }
  factory Transport.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Transport.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Transport clone() => Transport()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Transport copyWith(void Function(Transport) updates) => super.copyWith((message) => updates(message as Transport)) as Transport; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Transport create() => Transport._();
  Transport createEmptyInstance() => create();
  static $pb.PbList<Transport> createRepeated() => $pb.PbList<Transport>();
  @$core.pragma('dart2js:noInline')
  static Transport getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Transport>(create);
  static Transport? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get type => $_getIZ(0);
  @$pb.TagNumber(1)
  set type($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get mid => $_getSZ(1);
  @$pb.TagNumber(2)
  set mid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMid() => $_has(1);
  @$pb.TagNumber(2)
  void clearMid() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get data => $_getN(2);
  @$pb.TagNumber(3)
  set data($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasData() => $_has(2);
  @$pb.TagNumber(3)
  void clearData() => clearField(3);
}

class CallPacket extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CallPacket', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'main'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Type', $pb.PbFieldType.O3, protoName: 'Type')
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Data', $pb.PbFieldType.OY, protoName: 'Data')
    ..hasRequiredFields = false
  ;

  CallPacket._() : super();
  factory CallPacket({
    $core.int? type,
    $core.List<$core.int>? data,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (data != null) {
      _result.data = data;
    }
    return _result;
  }
  factory CallPacket.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CallPacket.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CallPacket clone() => CallPacket()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CallPacket copyWith(void Function(CallPacket) updates) => super.copyWith((message) => updates(message as CallPacket)) as CallPacket; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CallPacket create() => CallPacket._();
  CallPacket createEmptyInstance() => create();
  static $pb.PbList<CallPacket> createRepeated() => $pb.PbList<CallPacket>();
  @$core.pragma('dart2js:noInline')
  static CallPacket getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CallPacket>(create);
  static CallPacket? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get type => $_getIZ(0);
  @$pb.TagNumber(1)
  set type($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get data => $_getN(1);
  @$pb.TagNumber(2)
  set data($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => clearField(2);
}

class NotifyPaylaod extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NotifyPaylaod', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'main'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'TargetMid', protoName: 'TargetMid')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'initiaterMid', protoName: 'initiaterMid')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'PollName', protoName: 'PollName')
    ..hasRequiredFields = false
  ;

  NotifyPaylaod._() : super();
  factory NotifyPaylaod({
    $core.String? targetMid,
    $core.String? initiaterMid,
    $core.String? pollName,
  }) {
    final _result = create();
    if (targetMid != null) {
      _result.targetMid = targetMid;
    }
    if (initiaterMid != null) {
      _result.initiaterMid = initiaterMid;
    }
    if (pollName != null) {
      _result.pollName = pollName;
    }
    return _result;
  }
  factory NotifyPaylaod.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NotifyPaylaod.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NotifyPaylaod clone() => NotifyPaylaod()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NotifyPaylaod copyWith(void Function(NotifyPaylaod) updates) => super.copyWith((message) => updates(message as NotifyPaylaod)) as NotifyPaylaod; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NotifyPaylaod create() => NotifyPaylaod._();
  NotifyPaylaod createEmptyInstance() => create();
  static $pb.PbList<NotifyPaylaod> createRepeated() => $pb.PbList<NotifyPaylaod>();
  @$core.pragma('dart2js:noInline')
  static NotifyPaylaod getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NotifyPaylaod>(create);
  static NotifyPaylaod? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get targetMid => $_getSZ(0);
  @$pb.TagNumber(1)
  set targetMid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTargetMid() => $_has(0);
  @$pb.TagNumber(1)
  void clearTargetMid() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get initiaterMid => $_getSZ(1);
  @$pb.TagNumber(2)
  set initiaterMid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasInitiaterMid() => $_has(1);
  @$pb.TagNumber(2)
  void clearInitiaterMid() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get pollName => $_getSZ(2);
  @$pb.TagNumber(3)
  set pollName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPollName() => $_has(2);
  @$pb.TagNumber(3)
  void clearPollName() => clearField(3);
}

class CallNotifier extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CallNotifier', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'main'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'TargetMid', protoName: 'TargetMid')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'initiaterMid', protoName: 'initiaterMid')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'PollName', protoName: 'PollName')
    ..hasRequiredFields = false
  ;

  CallNotifier._() : super();
  factory CallNotifier({
    $core.String? targetMid,
    $core.String? initiaterMid,
    $core.String? pollName,
  }) {
    final _result = create();
    if (targetMid != null) {
      _result.targetMid = targetMid;
    }
    if (initiaterMid != null) {
      _result.initiaterMid = initiaterMid;
    }
    if (pollName != null) {
      _result.pollName = pollName;
    }
    return _result;
  }
  factory CallNotifier.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CallNotifier.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CallNotifier clone() => CallNotifier()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CallNotifier copyWith(void Function(CallNotifier) updates) => super.copyWith((message) => updates(message as CallNotifier)) as CallNotifier; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CallNotifier create() => CallNotifier._();
  CallNotifier createEmptyInstance() => create();
  static $pb.PbList<CallNotifier> createRepeated() => $pb.PbList<CallNotifier>();
  @$core.pragma('dart2js:noInline')
  static CallNotifier getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CallNotifier>(create);
  static CallNotifier? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get targetMid => $_getSZ(0);
  @$pb.TagNumber(1)
  set targetMid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTargetMid() => $_has(0);
  @$pb.TagNumber(1)
  void clearTargetMid() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get initiaterMid => $_getSZ(1);
  @$pb.TagNumber(2)
  set initiaterMid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasInitiaterMid() => $_has(1);
  @$pb.TagNumber(2)
  void clearInitiaterMid() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get pollName => $_getSZ(2);
  @$pb.TagNumber(3)
  set pollName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPollName() => $_has(2);
  @$pb.TagNumber(3)
  void clearPollName() => clearField(3);
}

