import 'package:expense_project/core/models/transaction_model.dart';
import 'package:expense_project/core/theme/app_colors.dart';
import 'package:expense_project/core/theme/app_sizes.dart';
import 'package:expense_project/core/utils/formatters.dart';
import 'package:expense_project/core/utils/transaction_utils.dart';
import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  final List<TransactionModel> transactions;

  const BalanceCard({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final income = TransactionUtils.totalIncome(transactions);
    final expenses = TransactionUtils.totalExpense(transactions);
    final balance = income - expenses;

    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final textSecondary = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.p24),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(AppSizes.r20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: (balance >= 0 ? AppColors.income : AppColors.expense)
              .withOpacity(0.1),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            Formatters.currency(balance.abs()),
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w300,
              color: balance >= 0 ? AppColors.income : AppColors.expense,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            balance >= 0 ? 'Total Balance' : 'Over Budget',
            style: TextStyle(fontSize: 14, color: textSecondary),
          ),
          const SizedBox(height: AppSizes.p20),
          Row(
            children: [
              _AmountColumn(
                label: 'Income',
                value: income,
                color: AppColors.income,
              ),
              Container(
                width: 1,
                height: 28,
                color: textSecondary.withOpacity(0.2),
              ),
              _AmountColumn(
                label: 'Expenses',
                value: expenses,
                color: AppColors.expense,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// ✅ PRIVATE helper widget (MUST be in same file)
class _AmountColumn extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const _AmountColumn({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textSecondary = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    return Expanded(
      child: Column(
        children: [
          Text(
            Formatters.currency(value),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(fontSize: 12, color: textSecondary)),
        ],
      ),
    );
  }
}
