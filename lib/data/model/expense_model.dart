import 'package:equatable/equatable.dart';

class ExpenseModel extends Equatable {
  int? id;
  String? title;
  String? category;
  double? amount;
  String? createdAt;

  ExpenseModel({this.id, this.title, this.category, this.amount});

  ExpenseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    category = json['category'];
    if (json['amount'] != null) {
      amount = double.parse(json['amount'] ?? '0.0');
    }
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['category'] = category;
    data['amount'] = amount;
    data['created_at'] = createdAt;
    return data;
  }

  @override
  List<Object?> get props => [id];
}
