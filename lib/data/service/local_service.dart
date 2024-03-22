import 'dart:convert';

import 'package:get_storage/get_storage.dart';

class DbHelper {
  static GetStorage box = GetStorage();

  static writeData(String key, dynamic value) async {
    await box.write(key, value);
  }

  static readData(String key) {
    return box.read(key);
  }

  static deleteData(String key) async {
    await box.remove(key);
  }

  static eraseData() async {
    await box.erase();
  }

  //===================
  /// Save Data Map
  static saveMap(
      {required String key, required Map<String, dynamic> data}) async {
    await writeData(key, jsonEncode(data));
  }

  /// Get Map Data
  static Map<String, dynamic>? getMap(String key) {
    String? data = readData(key);
    return data == null || data == '' ? null : jsonDecode(data);
  }
}

class LocalKeys {
  static String expenses = "expense_list";
  static String lastItemId = "last_item_id";
}
