///
//  Generated code. Do not modify.
//  source: internalProto.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class RecentGossips extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RecentGossips', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'main'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Name', protoName: 'Name')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'LastMsg', protoName: 'LastMsg')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'SenderMID', protoName: 'SenderMID')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'DateTime', protoName: 'DateTime')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'UnSeenMsgCount', $pb.PbFieldType.O3, protoName: 'UnSeenMsgCount')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ProfilePic', protoName: 'ProfilePic')
    ..hasRequiredFields = false
  ;

  RecentGossips._() : super();
  factory RecentGossips({
    $core.String? name,
    $core.String? lastMsg,
    $core.String? senderMID,
    $core.String? dateTime,
    $core.int? unSeenMsgCount,
    $core.String? profilePic,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (lastMsg != null) {
      _result.lastMsg = lastMsg;
    }
    if (senderMID != null) {
      _result.senderMID = senderMID;
    }
    if (dateTime != null) {
      _result.dateTime = dateTime;
    }
    if (unSeenMsgCount != null) {
      _result.unSeenMsgCount = unSeenMsgCount;
    }
    if (profilePic != null) {
      _result.profilePic = profilePic;
    }
    return _result;
  }
  factory RecentGossips.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RecentGossips.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RecentGossips clone() => RecentGossips()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RecentGossips copyWith(void Function(RecentGossips) updates) => super.copyWith((message) => updates(message as RecentGossips)) as RecentGossips; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RecentGossips create() => RecentGossips._();
  RecentGossips createEmptyInstance() => create();
  static $pb.PbList<RecentGossips> createRepeated() => $pb.PbList<RecentGossips>();
  @$core.pragma('dart2js:noInline')
  static RecentGossips getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RecentGossips>(create);
  static RecentGossips? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get lastMsg => $_getSZ(1);
  @$pb.TagNumber(2)
  set lastMsg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLastMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearLastMsg() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get senderMID => $_getSZ(2);
  @$pb.TagNumber(3)
  set senderMID($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSenderMID() => $_has(2);
  @$pb.TagNumber(3)
  void clearSenderMID() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get dateTime => $_getSZ(3);
  @$pb.TagNumber(4)
  set dateTime($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDateTime() => $_has(3);
  @$pb.TagNumber(4)
  void clearDateTime() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get unSeenMsgCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set unSeenMsgCount($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasUnSeenMsgCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearUnSeenMsgCount() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get profilePic => $_getSZ(5);
  @$pb.TagNumber(6)
  set profilePic($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasProfilePic() => $_has(5);
  @$pb.TagNumber(6)
  void clearProfilePic() => clearField(6);
}

class Contact extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Contact', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'main'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'number')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'done')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'inProcess', protoName: 'inProcess')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'blocked')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'intoggleblock')
    ..aOB(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'inlogin')
    ..hasRequiredFields = false
  ;

  Contact._() : super();
  factory Contact({
    $core.String? name,
    $core.String? number,
    $core.bool? done,
    $core.bool? inProcess,
    $core.bool? blocked,
    $core.bool? intoggleblock,
    $core.bool? inlogin,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (number != null) {
      _result.number = number;
    }
    if (done != null) {
      _result.done = done;
    }
    if (inProcess != null) {
      _result.inProcess = inProcess;
    }
    if (blocked != null) {
      _result.blocked = blocked;
    }
    if (intoggleblock != null) {
      _result.intoggleblock = intoggleblock;
    }
    if (inlogin != null) {
      _result.inlogin = inlogin;
    }
    return _result;
  }
  factory Contact.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Contact.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Contact clone() => Contact()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Contact copyWith(void Function(Contact) updates) => super.copyWith((message) => updates(message as Contact)) as Contact; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Contact create() => Contact._();
  Contact createEmptyInstance() => create();
  static $pb.PbList<Contact> createRepeated() => $pb.PbList<Contact>();
  @$core.pragma('dart2js:noInline')
  static Contact getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Contact>(create);
  static Contact? _defaultInstance;

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
  $core.bool get done => $_getBF(2);
  @$pb.TagNumber(3)
  set done($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDone() => $_has(2);
  @$pb.TagNumber(3)
  void clearDone() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get inProcess => $_getBF(3);
  @$pb.TagNumber(4)
  set inProcess($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasInProcess() => $_has(3);
  @$pb.TagNumber(4)
  void clearInProcess() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get blocked => $_getBF(4);
  @$pb.TagNumber(5)
  set blocked($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasBlocked() => $_has(4);
  @$pb.TagNumber(5)
  void clearBlocked() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get intoggleblock => $_getBF(5);
  @$pb.TagNumber(6)
  set intoggleblock($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIntoggleblock() => $_has(5);
  @$pb.TagNumber(6)
  void clearIntoggleblock() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get inlogin => $_getBF(6);
  @$pb.TagNumber(7)
  set inlogin($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasInlogin() => $_has(6);
  @$pb.TagNumber(7)
  void clearInlogin() => clearField(7);
}

class Contacts extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Contacts', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'main'), createEmptyInstance: create)
    ..pc<Contact>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'all', $pb.PbFieldType.PM, subBuilder: Contact.create)
    ..hasRequiredFields = false
  ;

  Contacts._() : super();
  factory Contacts({
    $core.Iterable<Contact>? all,
  }) {
    final _result = create();
    if (all != null) {
      _result.all.addAll(all);
    }
    return _result;
  }
  factory Contacts.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Contacts.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Contacts clone() => Contacts()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Contacts copyWith(void Function(Contacts) updates) => super.copyWith((message) => updates(message as Contacts)) as Contacts; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Contacts create() => Contacts._();
  Contacts createEmptyInstance() => create();
  static $pb.PbList<Contacts> createRepeated() => $pb.PbList<Contacts>();
  @$core.pragma('dart2js:noInline')
  static Contacts getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Contacts>(create);
  static Contacts? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Contact> get all => $_getList(0);
}

class Blocks extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Blocks', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'main'), createEmptyInstance: create)
    ..pPS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'all')
    ..hasRequiredFields = false
  ;

  Blocks._() : super();
  factory Blocks({
    $core.Iterable<$core.String>? all,
  }) {
    final _result = create();
    if (all != null) {
      _result.all.addAll(all);
    }
    return _result;
  }
  factory Blocks.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Blocks.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Blocks clone() => Blocks()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Blocks copyWith(void Function(Blocks) updates) => super.copyWith((message) => updates(message as Blocks)) as Blocks; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Blocks create() => Blocks._();
  Blocks createEmptyInstance() => create();
  static $pb.PbList<Blocks> createRepeated() => $pb.PbList<Blocks>();
  @$core.pragma('dart2js:noInline')
  static Blocks getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Blocks>(create);
  static Blocks? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get all => $_getList(0);
}

class UserData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UserData', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'main'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Name', protoName: 'Name')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Dob', protoName: 'Dob')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Gender', protoName: 'Gender')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Number', protoName: 'Number')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Email', protoName: 'Email')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Mid', protoName: 'Mid')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'MainKey', protoName: 'MainKey')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ProfilePic', protoName: 'ProfilePic')
    ..hasRequiredFields = false
  ;

  UserData._() : super();
  factory UserData({
    $core.String? name,
    $core.String? dob,
    $core.String? gender,
    $core.String? number,
    $core.String? email,
    $core.String? mid,
    $core.String? mainKey,
    $core.String? profilePic,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (dob != null) {
      _result.dob = dob;
    }
    if (gender != null) {
      _result.gender = gender;
    }
    if (number != null) {
      _result.number = number;
    }
    if (email != null) {
      _result.email = email;
    }
    if (mid != null) {
      _result.mid = mid;
    }
    if (mainKey != null) {
      _result.mainKey = mainKey;
    }
    if (profilePic != null) {
      _result.profilePic = profilePic;
    }
    return _result;
  }
  factory UserData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserData clone() => UserData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserData copyWith(void Function(UserData) updates) => super.copyWith((message) => updates(message as UserData)) as UserData; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserData create() => UserData._();
  UserData createEmptyInstance() => create();
  static $pb.PbList<UserData> createRepeated() => $pb.PbList<UserData>();
  @$core.pragma('dart2js:noInline')
  static UserData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserData>(create);
  static UserData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get dob => $_getSZ(1);
  @$pb.TagNumber(2)
  set dob($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDob() => $_has(1);
  @$pb.TagNumber(2)
  void clearDob() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get gender => $_getSZ(2);
  @$pb.TagNumber(3)
  set gender($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasGender() => $_has(2);
  @$pb.TagNumber(3)
  void clearGender() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get number => $_getSZ(3);
  @$pb.TagNumber(4)
  set number($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearNumber() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get email => $_getSZ(4);
  @$pb.TagNumber(5)
  set email($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasEmail() => $_has(4);
  @$pb.TagNumber(5)
  void clearEmail() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get mid => $_getSZ(5);
  @$pb.TagNumber(6)
  set mid($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMid() => $_has(5);
  @$pb.TagNumber(6)
  void clearMid() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get mainKey => $_getSZ(6);
  @$pb.TagNumber(7)
  set mainKey($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMainKey() => $_has(6);
  @$pb.TagNumber(7)
  void clearMainKey() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get profilePic => $_getSZ(7);
  @$pb.TagNumber(8)
  set profilePic($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasProfilePic() => $_has(7);
  @$pb.TagNumber(8)
  void clearProfilePic() => clearField(8);
}

class ConnectionData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ConnectionData', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'main'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Name', protoName: 'Name')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Number', protoName: 'Number')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Mid', protoName: 'Mid')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ProfilePic', protoName: 'ProfilePic')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'logout')
    ..hasRequiredFields = false
  ;

  ConnectionData._() : super();
  factory ConnectionData({
    $core.String? name,
    $core.String? number,
    $core.String? mid,
    $core.String? profilePic,
    $core.bool? logout,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (number != null) {
      _result.number = number;
    }
    if (mid != null) {
      _result.mid = mid;
    }
    if (profilePic != null) {
      _result.profilePic = profilePic;
    }
    if (logout != null) {
      _result.logout = logout;
    }
    return _result;
  }
  factory ConnectionData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConnectionData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConnectionData clone() => ConnectionData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConnectionData copyWith(void Function(ConnectionData) updates) => super.copyWith((message) => updates(message as ConnectionData)) as ConnectionData; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ConnectionData create() => ConnectionData._();
  ConnectionData createEmptyInstance() => create();
  static $pb.PbList<ConnectionData> createRepeated() => $pb.PbList<ConnectionData>();
  @$core.pragma('dart2js:noInline')
  static ConnectionData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConnectionData>(create);
  static ConnectionData? _defaultInstance;

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
  $core.String get mid => $_getSZ(2);
  @$pb.TagNumber(3)
  set mid($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMid() => $_has(2);
  @$pb.TagNumber(3)
  void clearMid() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get profilePic => $_getSZ(3);
  @$pb.TagNumber(4)
  set profilePic($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasProfilePic() => $_has(3);
  @$pb.TagNumber(4)
  void clearProfilePic() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get logout => $_getBF(4);
  @$pb.TagNumber(5)
  set logout($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLogout() => $_has(4);
  @$pb.TagNumber(5)
  void clearLogout() => clearField(5);
}

class LoginResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LoginResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'main'), createEmptyInstance: create)
    ..aOM<UserData>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'MyData', protoName: 'MyData', subBuilder: UserData.create)
    ..pc<ConnectionData>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ConnData', $pb.PbFieldType.PM, protoName: 'ConnData', subBuilder: ConnectionData.create)
    ..hasRequiredFields = false
  ;

  LoginResponse._() : super();
  factory LoginResponse({
    UserData? myData,
    $core.Iterable<ConnectionData>? connData,
  }) {
    final _result = create();
    if (myData != null) {
      _result.myData = myData;
    }
    if (connData != null) {
      _result.connData.addAll(connData);
    }
    return _result;
  }
  factory LoginResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LoginResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LoginResponse clone() => LoginResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LoginResponse copyWith(void Function(LoginResponse) updates) => super.copyWith((message) => updates(message as LoginResponse)) as LoginResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LoginResponse create() => LoginResponse._();
  LoginResponse createEmptyInstance() => create();
  static $pb.PbList<LoginResponse> createRepeated() => $pb.PbList<LoginResponse>();
  @$core.pragma('dart2js:noInline')
  static LoginResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LoginResponse>(create);
  static LoginResponse? _defaultInstance;

  @$pb.TagNumber(1)
  UserData get myData => $_getN(0);
  @$pb.TagNumber(1)
  set myData(UserData v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasMyData() => $_has(0);
  @$pb.TagNumber(1)
  void clearMyData() => clearField(1);
  @$pb.TagNumber(1)
  UserData ensureMyData() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<ConnectionData> get connData => $_getList(1);
}

