///
//  Generated code. Do not modify.
//  source: gbProto.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class MsgFormat extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MsgFormat', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'main'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Sid', protoName: 'Sid')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Msg', protoName: 'Msg')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Mloc', protoName: 'Mloc')
    ..hasRequiredFields = false
  ;

  MsgFormat._() : super();
  factory MsgFormat({
    $core.String? sid,
    $core.String? msg,
    $core.String? mloc,
  }) {
    final _result = create();
    if (sid != null) {
      _result.sid = sid;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    if (mloc != null) {
      _result.mloc = mloc;
    }
    return _result;
  }
  factory MsgFormat.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MsgFormat.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MsgFormat clone() => MsgFormat()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MsgFormat copyWith(void Function(MsgFormat) updates) => super.copyWith((message) => updates(message as MsgFormat)) as MsgFormat; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MsgFormat create() => MsgFormat._();
  MsgFormat createEmptyInstance() => create();
  static $pb.PbList<MsgFormat> createRepeated() => $pb.PbList<MsgFormat>();
  @$core.pragma('dart2js:noInline')
  static MsgFormat getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MsgFormat>(create);
  static MsgFormat? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sid => $_getSZ(0);
  @$pb.TagNumber(1)
  set sid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSid() => $_has(0);
  @$pb.TagNumber(1)
  void clearSid() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get mloc => $_getSZ(2);
  @$pb.TagNumber(3)
  set mloc($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMloc() => $_has(2);
  @$pb.TagNumber(3)
  void clearMloc() => clearField(3);
}

class ChatPayload extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ChatPayload', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'main'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Tid', protoName: 'Tid')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Sid', protoName: 'Sid')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Msg', protoName: 'Msg')
    ..hasRequiredFields = false
  ;

  ChatPayload._() : super();
  factory ChatPayload({
    $core.String? tid,
    $core.String? sid,
    $core.String? msg,
  }) {
    final _result = create();
    if (tid != null) {
      _result.tid = tid;
    }
    if (sid != null) {
      _result.sid = sid;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory ChatPayload.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChatPayload.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChatPayload clone() => ChatPayload()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChatPayload copyWith(void Function(ChatPayload) updates) => super.copyWith((message) => updates(message as ChatPayload)) as ChatPayload; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ChatPayload create() => ChatPayload._();
  ChatPayload createEmptyInstance() => create();
  static $pb.PbList<ChatPayload> createRepeated() => $pb.PbList<ChatPayload>();
  @$core.pragma('dart2js:noInline')
  static ChatPayload getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChatPayload>(create);
  static ChatPayload? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get tid => $_getSZ(0);
  @$pb.TagNumber(1)
  set tid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTid() => $_has(0);
  @$pb.TagNumber(1)
  void clearTid() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get sid => $_getSZ(1);
  @$pb.TagNumber(2)
  set sid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSid() => $_has(1);
  @$pb.TagNumber(2)
  void clearSid() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => clearField(3);
}

class Transport extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Transport', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'main'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Msg', $pb.PbFieldType.OY, protoName: 'Msg')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Id', protoName: 'Id')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Tp', $pb.PbFieldType.O3, protoName: 'Tp')
    ..hasRequiredFields = false
  ;

  Transport._() : super();
  factory Transport({
    $core.List<$core.int>? msg,
    $core.String? id,
    $core.int? tp,
  }) {
    final _result = create();
    if (msg != null) {
      _result.msg = msg;
    }
    if (id != null) {
      _result.id = id;
    }
    if (tp != null) {
      _result.tp = tp;
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
  $core.List<$core.int> get msg => $_getN(0);
  @$pb.TagNumber(1)
  set msg($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMsg() => $_has(0);
  @$pb.TagNumber(1)
  void clearMsg() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get id => $_getSZ(1);
  @$pb.TagNumber(2)
  set id($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasId() => $_has(1);
  @$pb.TagNumber(2)
  void clearId() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get tp => $_getIZ(2);
  @$pb.TagNumber(3)
  set tp($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTp() => $_has(2);
  @$pb.TagNumber(3)
  void clearTp() => clearField(3);
}

class Notify extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Notify', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'main'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tp', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  Notify._() : super();
  factory Notify({
    $core.String? id,
    $core.int? tp,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (tp != null) {
      _result.tp = tp;
    }
    return _result;
  }
  factory Notify.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Notify.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Notify clone() => Notify()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Notify copyWith(void Function(Notify) updates) => super.copyWith((message) => updates(message as Notify)) as Notify; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Notify create() => Notify._();
  Notify createEmptyInstance() => create();
  static $pb.PbList<Notify> createRepeated() => $pb.PbList<Notify>();
  @$core.pragma('dart2js:noInline')
  static Notify getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Notify>(create);
  static Notify? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get tp => $_getIZ(1);
  @$pb.TagNumber(2)
  set tp($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTp() => $_has(1);
  @$pb.TagNumber(2)
  void clearTp() => clearField(2);
}

class ClientName extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ClientName', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'main'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'UId', protoName: 'UId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'MId', protoName: 'MId')
    ..hasRequiredFields = false
  ;

  ClientName._() : super();
  factory ClientName({
    $core.String? uId,
    $core.String? mId,
  }) {
    final _result = create();
    if (uId != null) {
      _result.uId = uId;
    }
    if (mId != null) {
      _result.mId = mId;
    }
    return _result;
  }
  factory ClientName.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ClientName.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ClientName clone() => ClientName()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ClientName copyWith(void Function(ClientName) updates) => super.copyWith((message) => updates(message as ClientName)) as ClientName; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ClientName create() => ClientName._();
  ClientName createEmptyInstance() => create();
  static $pb.PbList<ClientName> createRepeated() => $pb.PbList<ClientName>();
  @$core.pragma('dart2js:noInline')
  static ClientName getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClientName>(create);
  static ClientName? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uId => $_getSZ(0);
  @$pb.TagNumber(1)
  set uId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get mId => $_getSZ(1);
  @$pb.TagNumber(2)
  set mId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMId() => clearField(2);
}

class ChatAck extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ChatAck', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'main'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'MId', protoName: 'MId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'MLoc', protoName: 'MLoc')
    ..hasRequiredFields = false
  ;

  ChatAck._() : super();
  factory ChatAck({
    $core.String? mId,
    $core.String? mLoc,
  }) {
    final _result = create();
    if (mId != null) {
      _result.mId = mId;
    }
    if (mLoc != null) {
      _result.mLoc = mLoc;
    }
    return _result;
  }
  factory ChatAck.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChatAck.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChatAck clone() => ChatAck()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChatAck copyWith(void Function(ChatAck) updates) => super.copyWith((message) => updates(message as ChatAck)) as ChatAck; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ChatAck create() => ChatAck._();
  ChatAck createEmptyInstance() => create();
  static $pb.PbList<ChatAck> createRepeated() => $pb.PbList<ChatAck>();
  @$core.pragma('dart2js:noInline')
  static ChatAck getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChatAck>(create);
  static ChatAck? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get mId => $_getSZ(0);
  @$pb.TagNumber(1)
  set mId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get mLoc => $_getSZ(1);
  @$pb.TagNumber(2)
  set mLoc($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMLoc() => $_has(1);
  @$pb.TagNumber(2)
  void clearMLoc() => clearField(2);
}

class HandShackP1 extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HandShackP1', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'main'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'TargetMobile', protoName: 'TargetMobile')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'SenderMID', protoName: 'SenderMID')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'PublicKey', protoName: 'PublicKey')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Hsid', protoName: 'Hsid')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Mloc', protoName: 'Mloc')
    ..hasRequiredFields = false
  ;

  HandShackP1._() : super();
  factory HandShackP1({
    $core.String? targetMobile,
    $core.String? senderMID,
    $core.String? publicKey,
    $core.String? hsid,
    $core.String? mloc,
  }) {
    final _result = create();
    if (targetMobile != null) {
      _result.targetMobile = targetMobile;
    }
    if (senderMID != null) {
      _result.senderMID = senderMID;
    }
    if (publicKey != null) {
      _result.publicKey = publicKey;
    }
    if (hsid != null) {
      _result.hsid = hsid;
    }
    if (mloc != null) {
      _result.mloc = mloc;
    }
    return _result;
  }
  factory HandShackP1.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HandShackP1.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HandShackP1 clone() => HandShackP1()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HandShackP1 copyWith(void Function(HandShackP1) updates) => super.copyWith((message) => updates(message as HandShackP1)) as HandShackP1; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HandShackP1 create() => HandShackP1._();
  HandShackP1 createEmptyInstance() => create();
  static $pb.PbList<HandShackP1> createRepeated() => $pb.PbList<HandShackP1>();
  @$core.pragma('dart2js:noInline')
  static HandShackP1 getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HandShackP1>(create);
  static HandShackP1? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get targetMobile => $_getSZ(0);
  @$pb.TagNumber(1)
  set targetMobile($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTargetMobile() => $_has(0);
  @$pb.TagNumber(1)
  void clearTargetMobile() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get senderMID => $_getSZ(1);
  @$pb.TagNumber(2)
  set senderMID($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSenderMID() => $_has(1);
  @$pb.TagNumber(2)
  void clearSenderMID() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get publicKey => $_getSZ(2);
  @$pb.TagNumber(3)
  set publicKey($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPublicKey() => $_has(2);
  @$pb.TagNumber(3)
  void clearPublicKey() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get hsid => $_getSZ(3);
  @$pb.TagNumber(4)
  set hsid($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasHsid() => $_has(3);
  @$pb.TagNumber(4)
  void clearHsid() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get mloc => $_getSZ(4);
  @$pb.TagNumber(5)
  set mloc($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMloc() => $_has(4);
  @$pb.TagNumber(5)
  void clearMloc() => clearField(5);
}

class HandShackP2 extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HandShackP2', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'main'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'EncryptedData', protoName: 'EncryptedData')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'TargetMID', protoName: 'TargetMID')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'SenderMID', protoName: 'SenderMID')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Hsid', protoName: 'Hsid')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Mloc', protoName: 'Mloc')
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Permit', $pb.PbFieldType.O3, protoName: 'Permit')
    ..hasRequiredFields = false
  ;

  HandShackP2._() : super();
  factory HandShackP2({
    $core.String? encryptedData,
    $core.String? targetMID,
    $core.String? senderMID,
    $core.String? hsid,
    $core.String? mloc,
    $core.int? permit,
  }) {
    final _result = create();
    if (encryptedData != null) {
      _result.encryptedData = encryptedData;
    }
    if (targetMID != null) {
      _result.targetMID = targetMID;
    }
    if (senderMID != null) {
      _result.senderMID = senderMID;
    }
    if (hsid != null) {
      _result.hsid = hsid;
    }
    if (mloc != null) {
      _result.mloc = mloc;
    }
    if (permit != null) {
      _result.permit = permit;
    }
    return _result;
  }
  factory HandShackP2.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HandShackP2.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HandShackP2 clone() => HandShackP2()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HandShackP2 copyWith(void Function(HandShackP2) updates) => super.copyWith((message) => updates(message as HandShackP2)) as HandShackP2; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HandShackP2 create() => HandShackP2._();
  HandShackP2 createEmptyInstance() => create();
  static $pb.PbList<HandShackP2> createRepeated() => $pb.PbList<HandShackP2>();
  @$core.pragma('dart2js:noInline')
  static HandShackP2 getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HandShackP2>(create);
  static HandShackP2? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get encryptedData => $_getSZ(0);
  @$pb.TagNumber(1)
  set encryptedData($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEncryptedData() => $_has(0);
  @$pb.TagNumber(1)
  void clearEncryptedData() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get targetMID => $_getSZ(1);
  @$pb.TagNumber(2)
  set targetMID($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTargetMID() => $_has(1);
  @$pb.TagNumber(2)
  void clearTargetMID() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get senderMID => $_getSZ(2);
  @$pb.TagNumber(3)
  set senderMID($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSenderMID() => $_has(2);
  @$pb.TagNumber(3)
  void clearSenderMID() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get hsid => $_getSZ(3);
  @$pb.TagNumber(4)
  set hsid($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasHsid() => $_has(3);
  @$pb.TagNumber(4)
  void clearHsid() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get mloc => $_getSZ(4);
  @$pb.TagNumber(5)
  set mloc($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMloc() => $_has(4);
  @$pb.TagNumber(5)
  void clearMloc() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get permit => $_getIZ(5);
  @$pb.TagNumber(6)
  set permit($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPermit() => $_has(5);
  @$pb.TagNumber(6)
  void clearPermit() => clearField(6);
}

class ConnDataTransfer extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ConnDataTransfer', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'main'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Name', protoName: 'Name')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Number', protoName: 'Number')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'MID', protoName: 'MID')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ProfilePic', protoName: 'ProfilePic')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Hsid', protoName: 'Hsid')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Mloc', protoName: 'Mloc')
    ..hasRequiredFields = false
  ;

  ConnDataTransfer._() : super();
  factory ConnDataTransfer({
    $core.String? name,
    $core.String? number,
    $core.String? mID,
    $core.String? profilePic,
    $core.String? hsid,
    $core.String? mloc,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (number != null) {
      _result.number = number;
    }
    if (mID != null) {
      _result.mID = mID;
    }
    if (profilePic != null) {
      _result.profilePic = profilePic;
    }
    if (hsid != null) {
      _result.hsid = hsid;
    }
    if (mloc != null) {
      _result.mloc = mloc;
    }
    return _result;
  }
  factory ConnDataTransfer.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConnDataTransfer.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConnDataTransfer clone() => ConnDataTransfer()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConnDataTransfer copyWith(void Function(ConnDataTransfer) updates) => super.copyWith((message) => updates(message as ConnDataTransfer)) as ConnDataTransfer; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ConnDataTransfer create() => ConnDataTransfer._();
  ConnDataTransfer createEmptyInstance() => create();
  static $pb.PbList<ConnDataTransfer> createRepeated() => $pb.PbList<ConnDataTransfer>();
  @$core.pragma('dart2js:noInline')
  static ConnDataTransfer getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConnDataTransfer>(create);
  static ConnDataTransfer? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get number => $_getSZ(1);
  @$pb.TagNumber(2)
  set number($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearNumber() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get mID => $_getSZ(2);
  @$pb.TagNumber(3)
  set mID($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMID() => $_has(2);
  @$pb.TagNumber(3)
  void clearMID() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get profilePic => $_getSZ(3);
  @$pb.TagNumber(4)
  set profilePic($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasProfilePic() => $_has(3);
  @$pb.TagNumber(4)
  void clearProfilePic() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get hsid => $_getSZ(4);
  @$pb.TagNumber(5)
  set hsid($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasHsid() => $_has(4);
  @$pb.TagNumber(5)
  void clearHsid() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get mloc => $_getSZ(5);
  @$pb.TagNumber(6)
  set mloc($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMloc() => $_has(5);
  @$pb.TagNumber(6)
  void clearMloc() => clearField(6);
}

class HandshakeDeleteNotify extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HandshakeDeleteNotify', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'main'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'SenderMID', protoName: 'SenderMID')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'TargetMID', protoName: 'TargetMID')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Number', protoName: 'Number')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Mloc', protoName: 'Mloc')
    ..hasRequiredFields = false
  ;

  HandshakeDeleteNotify._() : super();
  factory HandshakeDeleteNotify({
    $core.String? senderMID,
    $core.String? targetMID,
    $core.String? number,
    $core.String? mloc,
  }) {
    final _result = create();
    if (senderMID != null) {
      _result.senderMID = senderMID;
    }
    if (targetMID != null) {
      _result.targetMID = targetMID;
    }
    if (number != null) {
      _result.number = number;
    }
    if (mloc != null) {
      _result.mloc = mloc;
    }
    return _result;
  }
  factory HandshakeDeleteNotify.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HandshakeDeleteNotify.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HandshakeDeleteNotify clone() => HandshakeDeleteNotify()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HandshakeDeleteNotify copyWith(void Function(HandshakeDeleteNotify) updates) => super.copyWith((message) => updates(message as HandshakeDeleteNotify)) as HandshakeDeleteNotify; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HandshakeDeleteNotify create() => HandshakeDeleteNotify._();
  HandshakeDeleteNotify createEmptyInstance() => create();
  static $pb.PbList<HandshakeDeleteNotify> createRepeated() => $pb.PbList<HandshakeDeleteNotify>();
  @$core.pragma('dart2js:noInline')
  static HandshakeDeleteNotify getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HandshakeDeleteNotify>(create);
  static HandshakeDeleteNotify? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get senderMID => $_getSZ(0);
  @$pb.TagNumber(1)
  set senderMID($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSenderMID() => $_has(0);
  @$pb.TagNumber(1)
  void clearSenderMID() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get targetMID => $_getSZ(1);
  @$pb.TagNumber(2)
  set targetMID($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTargetMID() => $_has(1);
  @$pb.TagNumber(2)
  void clearTargetMID() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get number => $_getSZ(2);
  @$pb.TagNumber(3)
  set number($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearNumber() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get mloc => $_getSZ(3);
  @$pb.TagNumber(4)
  set mloc($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMloc() => $_has(3);
  @$pb.TagNumber(4)
  void clearMloc() => clearField(4);
}

class ChangeProfilePayload extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ChangeProfilePayload', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'main'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'PicData', protoName: 'PicData')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'SenderMID', protoName: 'SenderMID')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'TargetMID', protoName: 'TargetMID')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Mloc', protoName: 'Mloc')
    ..hasRequiredFields = false
  ;

  ChangeProfilePayload._() : super();
  factory ChangeProfilePayload({
    $core.String? picData,
    $core.String? senderMID,
    $core.String? targetMID,
    $core.String? mloc,
  }) {
    final _result = create();
    if (picData != null) {
      _result.picData = picData;
    }
    if (senderMID != null) {
      _result.senderMID = senderMID;
    }
    if (targetMID != null) {
      _result.targetMID = targetMID;
    }
    if (mloc != null) {
      _result.mloc = mloc;
    }
    return _result;
  }
  factory ChangeProfilePayload.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChangeProfilePayload.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChangeProfilePayload clone() => ChangeProfilePayload()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChangeProfilePayload copyWith(void Function(ChangeProfilePayload) updates) => super.copyWith((message) => updates(message as ChangeProfilePayload)) as ChangeProfilePayload; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ChangeProfilePayload create() => ChangeProfilePayload._();
  ChangeProfilePayload createEmptyInstance() => create();
  static $pb.PbList<ChangeProfilePayload> createRepeated() => $pb.PbList<ChangeProfilePayload>();
  @$core.pragma('dart2js:noInline')
  static ChangeProfilePayload getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChangeProfilePayload>(create);
  static ChangeProfilePayload? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get picData => $_getSZ(0);
  @$pb.TagNumber(1)
  set picData($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPicData() => $_has(0);
  @$pb.TagNumber(1)
  void clearPicData() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get senderMID => $_getSZ(1);
  @$pb.TagNumber(2)
  set senderMID($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSenderMID() => $_has(1);
  @$pb.TagNumber(2)
  void clearSenderMID() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get targetMID => $_getSZ(2);
  @$pb.TagNumber(3)
  set targetMID($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTargetMID() => $_has(2);
  @$pb.TagNumber(3)
  void clearTargetMID() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get mloc => $_getSZ(3);
  @$pb.TagNumber(4)
  set mloc($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMloc() => $_has(3);
  @$pb.TagNumber(4)
  void clearMloc() => clearField(4);
}

class ConnectionKey extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ConnectionKey', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'main'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Number', protoName: 'Number')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Key', protoName: 'Key')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'SenderMid', protoName: 'SenderMid')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Mloc', protoName: 'Mloc')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'TargetMid', protoName: 'TargetMid')
    ..hasRequiredFields = false
  ;

  ConnectionKey._() : super();
  factory ConnectionKey({
    $core.String? number,
    $core.String? key,
    $core.String? senderMid,
    $core.String? mloc,
    $core.String? targetMid,
  }) {
    final _result = create();
    if (number != null) {
      _result.number = number;
    }
    if (key != null) {
      _result.key = key;
    }
    if (senderMid != null) {
      _result.senderMid = senderMid;
    }
    if (mloc != null) {
      _result.mloc = mloc;
    }
    if (targetMid != null) {
      _result.targetMid = targetMid;
    }
    return _result;
  }
  factory ConnectionKey.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConnectionKey.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConnectionKey clone() => ConnectionKey()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConnectionKey copyWith(void Function(ConnectionKey) updates) => super.copyWith((message) => updates(message as ConnectionKey)) as ConnectionKey; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ConnectionKey create() => ConnectionKey._();
  ConnectionKey createEmptyInstance() => create();
  static $pb.PbList<ConnectionKey> createRepeated() => $pb.PbList<ConnectionKey>();
  @$core.pragma('dart2js:noInline')
  static ConnectionKey getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConnectionKey>(create);
  static ConnectionKey? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get number => $_getSZ(0);
  @$pb.TagNumber(1)
  set number($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearNumber() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get key => $_getSZ(1);
  @$pb.TagNumber(2)
  set key($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearKey() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get senderMid => $_getSZ(2);
  @$pb.TagNumber(3)
  set senderMid($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSenderMid() => $_has(2);
  @$pb.TagNumber(3)
  void clearSenderMid() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get mloc => $_getSZ(3);
  @$pb.TagNumber(4)
  set mloc($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMloc() => $_has(3);
  @$pb.TagNumber(4)
  void clearMloc() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get targetMid => $_getSZ(4);
  @$pb.TagNumber(5)
  set targetMid($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTargetMid() => $_has(4);
  @$pb.TagNumber(5)
  void clearTargetMid() => clearField(5);
}

class LKeyShareRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LKeyShareRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'main'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'SenderMid', protoName: 'SenderMid')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'TargetMid', protoName: 'TargetMid')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'PublicKey', protoName: 'PublicKey')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Mloc', protoName: 'Mloc')
    ..hasRequiredFields = false
  ;

  LKeyShareRequest._() : super();
  factory LKeyShareRequest({
    $core.String? senderMid,
    $core.String? targetMid,
    $core.String? publicKey,
    $core.String? mloc,
  }) {
    final _result = create();
    if (senderMid != null) {
      _result.senderMid = senderMid;
    }
    if (targetMid != null) {
      _result.targetMid = targetMid;
    }
    if (publicKey != null) {
      _result.publicKey = publicKey;
    }
    if (mloc != null) {
      _result.mloc = mloc;
    }
    return _result;
  }
  factory LKeyShareRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LKeyShareRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LKeyShareRequest clone() => LKeyShareRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LKeyShareRequest copyWith(void Function(LKeyShareRequest) updates) => super.copyWith((message) => updates(message as LKeyShareRequest)) as LKeyShareRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LKeyShareRequest create() => LKeyShareRequest._();
  LKeyShareRequest createEmptyInstance() => create();
  static $pb.PbList<LKeyShareRequest> createRepeated() => $pb.PbList<LKeyShareRequest>();
  @$core.pragma('dart2js:noInline')
  static LKeyShareRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LKeyShareRequest>(create);
  static LKeyShareRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get senderMid => $_getSZ(0);
  @$pb.TagNumber(1)
  set senderMid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSenderMid() => $_has(0);
  @$pb.TagNumber(1)
  void clearSenderMid() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get targetMid => $_getSZ(1);
  @$pb.TagNumber(2)
  set targetMid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTargetMid() => $_has(1);
  @$pb.TagNumber(2)
  void clearTargetMid() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get publicKey => $_getSZ(2);
  @$pb.TagNumber(3)
  set publicKey($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPublicKey() => $_has(2);
  @$pb.TagNumber(3)
  void clearPublicKey() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get mloc => $_getSZ(3);
  @$pb.TagNumber(4)
  set mloc($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMloc() => $_has(3);
  @$pb.TagNumber(4)
  void clearMloc() => clearField(4);
}

class Response extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Response', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'main'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Status', protoName: 'Status')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Disc', protoName: 'Disc')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Data', protoName: 'Data')
    ..hasRequiredFields = false
  ;

  Response._() : super();
  factory Response({
    $core.bool? status,
    $core.String? disc,
    $core.String? data,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    if (disc != null) {
      _result.disc = disc;
    }
    if (data != null) {
      _result.data = data;
    }
    return _result;
  }
  factory Response.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Response.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Response clone() => Response()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Response copyWith(void Function(Response) updates) => super.copyWith((message) => updates(message as Response)) as Response; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Response create() => Response._();
  Response createEmptyInstance() => create();
  static $pb.PbList<Response> createRepeated() => $pb.PbList<Response>();
  @$core.pragma('dart2js:noInline')
  static Response getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Response>(create);
  static Response? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get status => $_getBF(0);
  @$pb.TagNumber(1)
  set status($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get disc => $_getSZ(1);
  @$pb.TagNumber(2)
  set disc($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDisc() => $_has(1);
  @$pb.TagNumber(2)
  void clearDisc() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get data => $_getSZ(2);
  @$pb.TagNumber(3)
  set data($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasData() => $_has(2);
  @$pb.TagNumber(3)
  void clearData() => clearField(3);
}

