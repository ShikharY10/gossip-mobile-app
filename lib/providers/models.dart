import '../database/hive_handler.dart';

class DynamicList {
  List<Chat> _list = [];
  DynamicList(this._list);

  List get list => _list;
}