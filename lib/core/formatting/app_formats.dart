import 'package:intl/intl.dart';

abstract final class AppFormats {
  static final DateFormat _date = DateFormat('dd.MM.yyyy', 'de_DE');
  static final DateFormat _dateTime = DateFormat('dd.MM.yyyy HH:mm', 'de_DE');
  static final NumberFormat _currency =
      NumberFormat.currency(locale: 'de_DE', symbol: 'Euro', decimalDigits: 2);

  static String date(DateTime value) => _date.format(value);

  static String dateTime(DateTime value) => _dateTime.format(value);

  static String currency(num value) => _currency.format(value).trim();
}
