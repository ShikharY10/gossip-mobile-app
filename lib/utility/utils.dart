import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:yaml/yaml.dart';

import '../apiCallers/routes.dart';
import '../database/config.dart';

Future<Routes> getDynamicRoutes() async {
  DataBase db = getDataBase();
  Routes routes = Routes();

  try {
    String path = "https://raw.githubusercontent.com/ShikharY10/gossip/master/config/routes.yaml";
    http.Response response = await http.get(Uri.parse(path));
    if (response.statusCode == 200) {
      String fileContent = String.fromCharCodes(response.bodyBytes);
      Map yaml = loadYaml(fileContent);
      String jsonData = json.encode(yaml);
      db.set("tempBox", "configurations", jsonData);
      await routes.loadPath();
    } else {
      routes.loadDefault();
    }
  } catch (e) {
    routes.loadDefault();
  }
  GetIt.I.registerSingleton<Routes>(routes, instanceName: "routes");
  return routes;
}

Future<Routes> loadDynamicRoutes() async {
  Routes routes = Routes();
  await routes.loadPath();
  GetIt.I.registerSingleton<Routes>(routes, instanceName: "routes");
  return routes;
}
