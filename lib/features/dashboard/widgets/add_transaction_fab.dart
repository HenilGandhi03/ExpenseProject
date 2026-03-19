import 'package:expense_project/core/theme/app_colors.dart';
import 'package:expense_project/core/theme/app_sizes.dart';
import 'package:expense_project/core/constants/app_strings.dart';
import 'package:expense_project/features/transactions/transaction_add_page.dart';
import 'package:flutter/material.dart';

class AddTransactionFab extends StatelessWidget {
  const AddTransactionFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => const AddTransactionPage(),
        );
      },
      backgroundColor: AppColors.accent,
      elevation: 6,
      extendedPadding: const EdgeInsets.symmetric(horizontal: AppSizes.p20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.r24),
      ),
      icon: const Icon(Icons.add_rounded, color: Colors.white, size: 22),
      label: const Text(
        AppStrings.addTransaction,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
