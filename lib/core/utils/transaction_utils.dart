import 'package:expense_project/core/models/transaction_model.dart';

class TransactionUtils {
  static List<TransactionModel> sortByDateDesc(
    List<TransactionModel> transactions,
  ) {
    final list = [...transactions];
    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  static double totalIncome(List<TransactionModel> transactions) {
    return transactions
        .where((t) => t.type == TransactionType.income)
        .fold(0, (sum, t) => sum + t.amount);
  }

  static double totalExpense(List<TransactionModel> transactions) {
    return transactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0, (sum, t) => sum + t.amount);
  }
}
