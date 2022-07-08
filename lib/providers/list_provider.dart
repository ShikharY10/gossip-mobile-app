import 'package:flutter/foundation.dart';

import '../database/hive_handler.dart';

class ListProvider with ChangeNotifier {
  List<Chat> list = [];
  void addItem(Chat item) {
    list.add(item);
    notifyListeners();
  }

  void deleteItem(int index) {
    list.removeAt(index);
    notifyListeners();
  }
}