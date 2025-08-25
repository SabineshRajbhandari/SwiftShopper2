import 'package:intl/intl.dart';

class Formatters {
  /// Formats a DateTime object into a readable string, e.g. "Aug 24, 2025"
  static String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('MMM dd, yyyy');
    return formatter.format(date);
  }

  /// Formats a double amount into localized currency string with symbol, e.g. "$12.34"
  static String formatCurrency(
    double amount, {
    String locale = 'en_US',
    String symbol = '\$',
  }) {
    final NumberFormat currencyFormatter = NumberFormat.currency(
      locale: locale,
      symbol: symbol,
    );
    return currencyFormatter.format(amount);
  }

  /// Formats a phone number (basic US format), returns original if cannot format
  static String formatPhoneNumber(String phone) {
    final cleaned = phone.replaceAll(RegExp(r'\D'), '');
    if (cleaned.length == 10) {
      return '(${cleaned.substring(0, 3)}) ${cleaned.substring(3, 6)}-${cleaned.substring(6)}';
    }
    return phone;
  }

  /// Formats a Duration into mm:ss format, e.g. "03:45"
  static String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
