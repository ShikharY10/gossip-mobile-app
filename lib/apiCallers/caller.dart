import 'dart:convert';
import 'package:http/http.dart' as http;

class Caller {
  static Future<http.Response> getCall(String path, {Map<String,String>? header}) async {
    http.Response response = await http.get(
      Uri.parse(path),
      headers: header,
    );
    return response;
  }

  static Future<http.Response> postCall(String path, Map<String, dynamic> body, {Map<String,String>? header}) async {
    String jsonBody = json.encode(body);
    http.Response response = await http.post(
      Uri.parse(path),
      headers: header,
      body: jsonBody
    );
    print("============= Response Received =============");
    return response;
  }
}
