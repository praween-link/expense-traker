import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppToast {
  static show(String msg, {Color? bgColor}) {
    if (msg != "null") {
      var snackBar = SnackBar(content: Text(msg));
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    }
  }
}
