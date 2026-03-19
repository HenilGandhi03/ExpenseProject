import 'package:expense_project/core/constants/app_strings.dart';
import 'package:expense_project/core/models/transaction_model.dart';
import 'package:expense_project/core/theme/app_colors.dart';
import 'package:expense_project/core/theme/app_sizes.dart';
import 'package:expense_project/features/dashboard/widgets/transaction_row.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RecentTransactionsSection extends StatelessWidget {
  final List<TransactionModel> transactions;

  const RecentTransactionsSection({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textPrimary = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;
    final textSecondary = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;

    final recent = transactions.take(5).toList();
    final hasMore = transactions.length > 5;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSizes.p20),
      padding: const EdgeInsets.only(top: AppSizes.p16),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(AppSizes.r20),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.p20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.recentTransactions,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: textPrimary,
                      ),
                    ),
                    Text(
                      AppStrings.latestActivity,
                      style: TextStyle(fontSize: 13, color: textSecondary),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.p16),
          if (recent.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(AppSizes.p24),
                child: Text(AppStrings.noTransactions),
              ),
            )
          else
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.p20),
                itemCount: recent.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: AppSizes.p12),
                itemBuilder: (_, index) =>
                    TransactionRow(transaction: recent[index]),
              ),
            ),
          if (hasMore)
            TextButton(
              onPressed: () => context.push('/transactions'),
              child: Text(
                'View all ${transactions.length}',
                style: const TextStyle(color: AppColors.accent),
              ),
            ),
        ],
      ),
    );
  }
}
