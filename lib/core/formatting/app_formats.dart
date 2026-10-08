import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

abstract final class AppFormats {
  static const String locale = 'de_DE';

  static Future<void> initialize() async {
    Intl.defaultLocale = locale;
    await initializeDateFormatting(locale);
  }

  static final DateFormat _date = DateFormat('dd.MM.yyyy', locale);
  static final DateFormat _dateTime = DateFormat('dd.MM.yyyy HH:mm', locale);
  static final NumberFormat _currency = NumberFormat.currency(
    locale: locale,
    symbol: 'Euro',
    decimalDigits: 2,
  );

  static String date(DateTime value) => _date.format(value.toLocal());

  static String dateTime(DateTime value) => _dateTime.format(value.toLocal());

  static String currency(num value) => _currency.format(value).trim();

  static String currencyFromCents(int cents) => currency(cents / 100);
}
