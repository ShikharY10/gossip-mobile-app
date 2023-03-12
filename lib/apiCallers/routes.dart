
import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:safe_device/safe_device.dart';
import '../database/config.dart';

Routes getRoutes() {
  return GetIt.I.get<Routes>(instanceName: "routes");
}

/// A class that contains the path for the APIs.
class Routes {

  late String _path;
  String _apiAddress = "";
  String _websocketAddress = "";
  String _host = "";
  String _version = "";

  bool _isDefault = false;
  bool get isDefault => _isDefault;
  
  Future<void> loadPath() async {
    DataBase db = getDataBase();
    String? jsonEncoded = db.get("tempBox", "domain");
    if (jsonEncoded != null) {
      Map<String,dynamic> data = json.decode(jsonEncoded);
      _version = data["VERSION"];

      bool isRealDevice = await SafeDevice.isRealDevice;
      if (isRealDevice) {
        _host = data["REAL_DEVICE_HOST"]; 
      } else {
        _host = data["VIRTUAL_DEVICE_HOST"];
      }
      _apiAddress = "http://$_host:10221/api/$_version";
      _websocketAddress = "ws://$_host/secure/connect";
    }
  }

  loadDefault() {
    _isDefault = true;
    _path = "http://127.0.0.1:10221/api/v3";
  }

  String get webSocketConnect => _websocketAddress;

  Future<String?> get webSocket async {
    DataBase db = getDataBase();
    String? jsonEncoded = db.get("tempBox", "domain");
    if (jsonEncoded != null) {
      Map<String,dynamic> data = json.decode(jsonEncoded);
      bool isRealDevice = await SafeDevice.isRealDevice;
      if (isRealDevice) {
        _path = "ws://${data["GATEWAY_DOMAIN"]}/secure/connect";
      } else {
        _path = "ws://${data["GATEWAY_EMULATOR_DOMAIN"]}/secure/connect";
      }
      return _path;
    }
    return null;
  }

  String get requestSignupOTP {
    return _apiAddress + "/requestsignupotp";
  }

  String get varifySignupOTP {
    return _apiAddress + "/varifysignupotp";
  }

  /// Returns the path for signup API. 
  /// Method: POST
  String get signup {
    return _apiAddress + "/signup";
  }

  String get requestLoginOTP {
    return _apiAddress + "requestloginotp";
  }

  /// Returns the path for login API.
  /// Method: POST
  String get login {
    return _apiAddress + "/login";
  }

  String searchUsername(String username) {
    // /api/v3/a/searchusername
    return _apiAddress + "/a/searchusername?q=" + username;
  }

  String isUsernameAwailable(String username) {
    return _apiAddress + "/isusernameawailable?username=" + username;
  }
 
  String getUserDetails(String id) {
    // /api/v3/a/getuserdetails
    return _apiAddress + "/a/getuserdetails?id=" + id;
  }

  String get logout {
    return _apiAddress + "/a/logout";
  }

  String get updateAvatar {
    return _apiAddress + "/a/updateavatar";
  }

  String get updateName {
    return _apiAddress + "/a/updatename";
  }

  String get updateUsername {
    return _apiAddress + "/a/updateusername";
  }

  String get varifyUsernameOTP {
    return _apiAddress + "/a/varifyusernameotp";
  }

  String get updateEmail {
    return _apiAddress + "/a/updateemail";
  }

  String get varifyEmailOTP {
    return _apiAddress + "/a/varifyemailotp";
  }

  String get partnerRequest {
    return _apiAddress + "/a/partnerrequest";
  }

  String get partnerResponse {
    return _apiAddress + "/a/partnerresponse";
  }

  String getavatar(String id) {
    return "$_apiAddress/a/getuseravatar/$id";
  }


  /// Returns the base path for the API.
  @override
  String toString() {
    return _path;
  }
}

