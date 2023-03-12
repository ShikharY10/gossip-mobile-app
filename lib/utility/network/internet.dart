import 'package:flutter/services.dart';

/// For checking the internet connection status.
/// It will return true if internet connection is awailable in any 
/// form whether it be Mobile Internet or Wifi Connection.
/// If non of the internet connection is awailable it will show return false.
class Connectivity {
  static const platform = MethodChannel('samples.flutter.dev/network-connectivity');

  // Get Internet Connectivity Status
  Future<bool> getInternetConnectivityStatus() async {
    try {
      final bool status = await platform.invokeMethod("getInternetConnectivityStatus");
      return status;
    } on PlatformException catch (e) {
      return false;
    }
  }

  // Get battery level.
  Future<String> getBatteryLevel() async {
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      return 'Battery level at $result % .';
    } on PlatformException catch (e) {
      return "Failed to get battery level: '${e.message}'.";
    }
  }
}