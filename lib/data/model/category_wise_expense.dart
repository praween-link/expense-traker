import 'package:equatable/equatable.dart';

class CategoryExpense extends Equatable {
  final String category;
  final double amount;
  final int id;

  const CategoryExpense(
      {required this.id, required this.amount, required this.category});

  @override
  List<Object?> get props => [id];
}
