// lib/core/services/database_service.dart
import 'package:hive_flutter/hive_flutter.dart';
import '../models/transaction_model.dart';
import '../models/account_model.dart';
import '../models/category_model.dart';
import '../models/bill_model.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  late Box<TransactionModel> _transactionsBox;
  late Box<Account> _accountsBox;
  late Box<ExpenseCategory> _expenseCategoriesBox;
  late Box<IncomeCategory> _incomeCategoriesBox;
  late Box<BillModel> _billsBox;

  Box<TransactionModel> get transactionsBox => _transactionsBox;
  Box<Account> get accountsBox => _accountsBox;
  Box<ExpenseCategory> get expenseCategoriesBox => _expenseCategoriesBox;
  Box<IncomeCategory> get incomeCategoriesBox => _incomeCategoriesBox;
  Box<BillModel> get billsBox => _billsBox;

  Future<void> init() async {
    await Hive.initFlutter();

    // Register adapters
    Hive.registerAdapter(TransactionModelAdapter());
    Hive.registerAdapter(TransactionTypeAdapter());
    Hive.registerAdapter(AccountAdapter());
    Hive.registerAdapter(AccountRoleAdapter());
    Hive.registerAdapter(ExpenseCategoryAdapter());
    Hive.registerAdapter(IncomeCategoryAdapter());
    Hive.registerAdapter(BillModelAdapter());

    // Open boxes
    _transactionsBox = await Hive.openBox<TransactionModel>('transactions');
    _accountsBox = await Hive.openBox<Account>('accounts');
    _expenseCategoriesBox = await Hive.openBox<ExpenseCategory>(
      'expense_categories',
    );
    _incomeCategoriesBox = await Hive.openBox<IncomeCategory>(
      'income_categories',
    );
    _billsBox = await Hive.openBox<BillModel>('bills');

    // Seed ONLY categories (no accounts)
    await _seedDefaultCategories();
  }

  Future<void> _seedDefaultCategories() async {
    // Seed default expense categories if empty
    if (_expenseCategoriesBox.isEmpty) {
      final categories = [
        ExpenseCategory(
          name: 'Food & Dining',
          subcategories: ['Restaurant', 'Groceries', 'Coffee'],
        ),
        ExpenseCategory(
          name: 'Transportation',
          subcategories: ['Fuel', 'Public Transport', 'Taxi'],
        ),
        ExpenseCategory(
          name: 'Shopping',
          subcategories: ['Clothing', 'Electronics', 'Books'],
        ),
        ExpenseCategory(
          name: 'Bills & Utilities',
          subcategories: ['Electricity', 'Internet', 'Phone'],
        ),
        ExpenseCategory(
          name: 'Entertainment',
          subcategories: ['Movies', 'Games', 'Sports'],
        ),
        ExpenseCategory(
          name: 'Healthcare',
          subcategories: ['Doctor', 'Pharmacy', 'Insurance'],
        ),
        ExpenseCategory(
          name: 'Education',
          subcategories: ['Books', 'Courses', 'Fees'],
        ),
        ExpenseCategory(name: 'Other', subcategories: ['Miscellaneous']),
      ];

      for (var category in categories) {
        await _expenseCategoriesBox.put(category.name, category);
      }
    }

    // Seed default income categories if empty
    if (_incomeCategoriesBox.isEmpty) {
      final categories = [
        IncomeCategory(
          name: 'Salary',
          subcategories: ['Base Salary', 'Bonus', 'Overtime'],
        ),
        IncomeCategory(
          name: 'Business',
          subcategories: ['Sales', 'Consulting', 'Freelance'],
        ),
        IncomeCategory(
          name: 'Investments',
          subcategories: ['Dividends', 'Interest', 'Capital Gains'],
        ),
        IncomeCategory(
          name: 'Side Income',
          subcategories: ['Part-time', 'Gig Work', 'Rent'],
        ),
        IncomeCategory(
          name: 'Other',
          subcategories: ['Gifts', 'Refunds', 'Cashback'],
        ),
      ];

      for (var category in categories) {
        await _incomeCategoriesBox.put(category.name, category);
      }
    }
  }

  Future<void> close() async {
    await _transactionsBox.close();
    await _accountsBox.close();
    await _expenseCategoriesBox.close();
    await _incomeCategoriesBox.close();
    await _billsBox.close();
  }
}
