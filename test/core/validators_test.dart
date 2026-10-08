import 'package:anhaenger_verwaltungssystem/core/constants/app_strings.dart';
import 'package:anhaenger_verwaltungssystem/core/formatting/csv.dart';
import 'package:anhaenger_verwaltungssystem/core/validation/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Pflichtfeld und E-Mail', () {
    expect(Validators.required('  '), AppStrings.validationRequired);
    expect(Validators.required('x'), isNull);
    expect(Validators.email('max@example.de'), isNull);
    expect(Validators.email('max@'), AppStrings.validationEmail);
  });

  test('Betraege werden in Cent umgerechnet', () {
    expect(Validators.parseCents('49,90'), 4990);
    expect(Validators.parseCents('49.9'), 4990);
    expect(Validators.parseCents('1.234,50'), 123450);
    expect(Validators.parseCents('12'), 1200);
    expect(Validators.parseCents('abc'), isNull);
    expect(Validators.parseCents('-5'), isNull);
    expect(Validators.money(''), AppStrings.validationRequired);
    expect(Validators.money('', isRequired: false), isNull);
    expect(Validators.centsToInput(4990), '49,90');
    expect(Validators.centsToInput(5), '0,05');
  });

  test('Koordinaten', () {
    expect(Validators.coordinate('', limit: 90), isNull);
    expect(Validators.coordinate('51,05', limit: 90), isNull);
    expect(
      Validators.coordinate('91', limit: 90),
      AppStrings.validationCoordinate,
    );
    expect(Validators.parseDecimal('13,74'), 13.74);
  });

  test('CSV mit Semikolon, BOM und Quoting', () {
    final String csv = Csv.encode(<List<String>>[
      <String>['a', 'b;c'],
      <String>['"x"', 'y'],
    ]);

    expect(csv, '﻿a;"b;c"\r\n"""x""";y\r\n');
  });
}
