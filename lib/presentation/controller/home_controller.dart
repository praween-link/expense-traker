import 'package:expense_tracker/core/app_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/model/expense_model.dart';
import '../../data/service/local_service.dart';

class HomeController extends GetxController {
  //
  var categories = [
    "Sopping",
    "Food",
    "Transportation",
    "Utilities",
  ];
  var categoryImgs = [
    "assets/shopping.png",
    "assets/food.png",
    "assets/transaction.png",
    "assets/utilities.png",
  ];
  TextEditingController title = TextEditingController(text: '');
  TextEditingController amount = TextEditingController(text: '');
  var category = 'Food'.obs;

  /// --- Services ---
  var expenses = <ExpenseModel>[].obs;
  var categoryWiseData = <String, (int, double)>{}.obs;

  saveNewExpense() {
    if (title.text.trim() == '') {
      AppToast.show("Please enter title");
      return;
    }
    if (amount.text.trim() == '') {
      AppToast.show("Please enter amount");
      return;
    }
    int lastItemId = (DbHelper.readData(LocalKeys.lastItemId) ?? 0) + 1;

    Map<String, dynamic> data = {
      "id": lastItemId,
      "title": title.text.trim(),
      "amount": amount.text.trim(),
      "category": category.value.trim(),
      "created_at": DateTime.now().toString(),
    };
    var listMap = DbHelper.getMap(LocalKeys.expenses);

    List<dynamic> temp = listMap != null ? listMap['list'] : [];
    temp.add(data);
    DbHelper.saveMap(key: LocalKeys.expenses, data: {"list": temp});
    DbHelper.writeData(LocalKeys.lastItemId, lastItemId);

    ExpenseModel added = ExpenseModel.fromJson(data);
    expenses.add(added);
    expenses.refresh();

    var cc = categoryWiseData[added.category.toString()];
    categoryWiseData.addAll({
      added.category.toString(): (
        ((cc?.$1 ?? 0) + 1),
        (cc?.$2 ?? 0) + (added.amount ?? 0.0)
      )
    });
    categoryWiseData.refresh();

    //clear fields
    title.clear();
    amount.clear();
    category.value = "Food";
    Get.back();
  }

  getExpenses() {
    var listMap = DbHelper.getMap(LocalKeys.expenses);

    if (listMap != null) {
      List<dynamic> temp = listMap['list'] ?? [];
      expenses.value = [];
      for (var v in categories) {
        categoryWiseData.addAll({v: (0, 0.0)});
      }
      for (var v in temp) {
        ExpenseModel exp = ExpenseModel.fromJson(v as Map<String, dynamic>);
        expenses.add(exp);
        var cc = categoryWiseData[exp.category.toString()];
        categoryWiseData.addAll({
          exp.category.toString(): (
            ((cc?.$1 ?? 0) + 1),
            (cc?.$2 ?? 0) + (exp.amount ?? 0.0)
          )
        });
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    getExpenses();
  }
}
