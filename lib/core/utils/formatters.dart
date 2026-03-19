class Formatters {
  static String currency(double value, {String symbol = '₹'}) {
    return '$symbol${value.toStringAsFixed(0)}';
  }
}
