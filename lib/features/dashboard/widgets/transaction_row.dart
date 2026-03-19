// import 'package:expense_project/app/app_theme.dart';
// import 'package:expense_project/features/dashboard/widgets/getCategoryIcon.dart';
// import 'package:expense_project/features/settings/modern_settings_page.dart';
// import 'package:expense_project/features/transactions/transaction_add_page.dart';
// import 'package:flutter/material.dart';
// import 'package:expense_project/core/models/transaction_model.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Widget transactionRow(
//   WidgetRef ref,
//   TransactionModel transaction,
//   Color text1,
//   Color text2,
//   Color green,
//   Color red, {
//   VoidCallback? onDelete,
//   VoidCallback? onEdit,
// }) {
//   final isExpense = transaction.type == TransactionType.expense;
//   final amountColor = isExpense ? red : green;
//   final isDark = ref.watch(themeProvider);
//   final themeData = isDark
//       ? AppTheme.darkTheme(null)
//       : AppTheme.lightTheme(null);
//   final surface = themeData.colorScheme.surface;
//   final accent = const Color(0xFF007AFF);

//   String capitalize(String? text) {
//     if (text == null || text.isEmpty) return '';
//     return text[0].toUpperCase() + text.substring(1);
//   }

//   return Dismissible(
//     key: Key(transaction.id),
//     direction: DismissDirection.endToStart,
//     background: Container(
//       alignment: Alignment.centerRight,
//       padding: const EdgeInsets.only(right: 20),
//       margin: const EdgeInsets.symmetric(vertical: 6),
//       decoration: BoxDecoration(
//         color: const Color(0xFFFF3B30),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: const Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Icon(Icons.delete_outline, color: Colors.white, size: 22),
//           SizedBox(width: 6),
//           Text(
//             'Delete',
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.w500,
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     ),
//     confirmDismiss: (direction) async {
//       return await showDialog<bool>(
//             context: ref.context,
//             barrierColor: Colors.black.withOpacity(0.3),
//             builder: (context) => AlertDialog(
//               backgroundColor: surface,
//               elevation: 8,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               title: Text(
//                 'Delete Transaction',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: text1,
//                 ),
//               ),
//               content: Text(
//                 'Are you sure you want to delete "${transaction.title}"? This action cannot be undone.',
//                 style: TextStyle(fontSize: 14, color: text2),
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.of(context).pop(false),
//                   child: Text(
//                     'Cancel',
//                     style: TextStyle(color: text2, fontWeight: FontWeight.w500),
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () => Navigator.of(context).pop(true),
//                   child: Text(
//                     'Delete',
//                     style: TextStyle(
//                       color: const Color(0xFFFF3B30),
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ) ??
//           false;
//     },
//     onDismissed: (direction) => onDelete?.call(),
//     child: GestureDetector(
//       onTap: onEdit,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 6),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         decoration: BoxDecoration(
//           color: surface.withOpacity(0.3),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: amountColor.withOpacity(0.1), width: 0.5),
//         ),
//         child: Row(
//           children: [
//             // Brand/Category Icon
//             Container(
//               width: 36,
//               height: 36,
//               decoration: BoxDecoration(
//                 color: amountColor.withOpacity(0.12),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Center(
//                 child: FaIcon(
//                   getCategoryIcon(transaction.category, transaction.title),
//                   size: 18,
//                   color: amountColor,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 14),

//             // Transaction Title & Category
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     capitalize(transaction.title),
//                     style: TextStyle(
//                       fontSize: 15,
//                       color: text1,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   const SizedBox(height: 2),
//                   Row(
//                     children: [
//                       if (transaction.category != null) ...[
//                         Text(
//                           capitalize(transaction.category),
//                           style: TextStyle(fontSize: 12, color: text2),
//                         ),
//                         if (transaction.account != null) ...[
//                           Text(
//                             ' • ',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: text2.withOpacity(0.5),
//                             ),
//                           ),
//                           Text(
//                             transaction.account!,
//                             style: TextStyle(fontSize: 12, color: text2),
//                           ),
//                         ],
//                       ] else if (transaction.account != null) ...[
//                         Text(
//                           transaction.account!,
//                           style: TextStyle(fontSize: 12, color: text2),
//                         ),
//                       ],
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             // Amount & Date
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Text(
//                   '${isExpense ? '-' : '+'}₹${transaction.amount.toStringAsFixed(0)}',
//                   style: TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w600,
//                     color: amountColor,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   formatSimpleDate(transaction.date),
//                   style: TextStyle(fontSize: 11, color: text2),
//                 ),
//               ],
//             ),

//             // Edit hint arrow
//             const SizedBox(width: 8),
//             Icon(
//               Icons.keyboard_arrow_right,
//               color: text2.withOpacity(0.3),
//               size: 16,
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }

// String formatSimpleDate(DateTime date) {
//   final now = DateTime.now();
//   final diff = now.difference(date).inDays;

//   if (diff == 0) return 'Today';
//   if (diff == 1) return 'Yesterday';
//   if (diff < 7) return '${diff}d';

//   return '${date.day}/${date.month}';
// }

import 'package:expense_project/core/models/transaction_model.dart';
import 'package:expense_project/core/theme/app_colors.dart';
import 'package:expense_project/core/theme/app_sizes.dart';
import 'package:expense_project/core/utils/date_utils.dart';
import 'package:expense_project/core/utils/formatters.dart';
import 'package:flutter/material.dart';

class TransactionRow extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionRow({super.key, required this.transaction});

  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  String _buildSubtitle() {
    final parts = <String>[];

    if (transaction.category != null && transaction.category!.isNotEmpty) {
      parts.add(_capitalize(transaction.category!));
    }

    if (transaction.account != null && transaction.account!.isNotEmpty) {
      parts.add(transaction.account!);
    }

    return parts.join(' • ');
  }

  @override
  Widget build(BuildContext context) {
    final isExpense = transaction.type == TransactionType.expense;
    final color = isExpense ? AppColors.expense : AppColors.income;

    return Container(
      padding: const EdgeInsets.all(AppSizes.p16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.r16),
        color: color.withOpacity(0.05),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.15),
            child: Icon(
              isExpense
                  ? Icons.arrow_downward_rounded
                  : Icons.arrow_upward_rounded,
              color: color,
            ),
          ),
          const SizedBox(width: AppSizes.p16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _capitalize(transaction.title),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                if (_buildSubtitle().isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    _buildSubtitle(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: AppSizes.p12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isExpense ? '-' : '+'}${Formatters.currency(transaction.amount)}',
                style: TextStyle(fontWeight: FontWeight.w700, color: color),
              ),
              const SizedBox(height: 4),
              Text(
                DateUtilsX.formatRelative(transaction.date),
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
