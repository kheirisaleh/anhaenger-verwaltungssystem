import 'package:anhaenger_verwaltungssystem/core/formatting/app_formats.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(AppFormats.initialize);

  test('Datum im Format TT.MM.JJJJ', () {
    expect(AppFormats.date(DateTime(2026, 3, 7)), '07.03.2026');
    expect(AppFormats.dateTime(DateTime(2026, 3, 7, 9, 5)), '07.03.2026 09:05');
  });

  test('Betrag aus Cent im deutschen Format', () {
    String normalize(String value) => value.replaceAll(' ', ' ');

    expect(normalize(AppFormats.currencyFromCents(123450)), '1.234,50 Euro');
    expect(normalize(AppFormats.currencyFromCents(0)), '0,00 Euro');
  });
}
