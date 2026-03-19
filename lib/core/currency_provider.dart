// core/currency_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Currency {
  final String code;
  final String symbol;
  final String name;

  const Currency({
    required this.code,
    required this.symbol,
    required this.name,
  });
}

class CurrencyNotifier extends StateNotifier<Currency> {
  static const _defaultCurrency = Currency(
    code: 'INR',
    symbol: '₹',
    name: 'Indian Rupee',
  );

  CurrencyNotifier() : super(_defaultCurrency) {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString('currency_code') ?? _defaultCurrency.code;
    final symbol =
        prefs.getString('currency_symbol') ?? _defaultCurrency.symbol;
    final name = prefs.getString('currency_name') ?? _defaultCurrency.name;
    state = Currency(code: code, symbol: symbol, name: name);
  }

  Future<void> setCurrency(Currency newCurrency) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('currency_code', newCurrency.code);
    await prefs.setString('currency_symbol', newCurrency.symbol);
    await prefs.setString('currency_name', newCurrency.name);
    state = newCurrency; // Notify listeners
  }
}

final currencyProvider = StateNotifierProvider<CurrencyNotifier, Currency>((
  ref,
) {
  return CurrencyNotifier();
});
