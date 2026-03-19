class DateUtilsX {
  static String formatRelative(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date).inDays;

    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    if (diff < 7) return '${diff}d ago';

    return '${date.day}/${date.month}';
  }
}
