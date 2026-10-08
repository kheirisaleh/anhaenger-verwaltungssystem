import '../constants/app_strings.dart';

abstract final class Validators {
  static final RegExp _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  static final RegExp _money = RegExp(r'^\d{1,9}([.,]\d{1,2})?$');

  static String? required(String value) {
    return value.trim().isEmpty ? AppStrings.validationRequired : null;
  }

  static String? email(String value) {
    final String trimmed = value.trim();
    if (trimmed.isEmpty) {
      return AppStrings.validationRequired;
    }
    return _email.hasMatch(trimmed) ? null : AppStrings.validationEmail;
  }

  static String? money(String value, {bool isRequired = true}) {
    final String trimmed = value.trim();
    if (trimmed.isEmpty) {
      return isRequired ? AppStrings.validationRequired : null;
    }
    return parseCents(trimmed) == null ? AppStrings.validationMoney : null;
  }

  static String? coordinate(String value, {required double limit}) {
    final String trimmed = value.trim();
    if (trimmed.isEmpty) {
      return null;
    }
    final double? parsed = parseDecimal(trimmed);
    if (parsed == null || parsed.abs() > limit) {
      return AppStrings.validationCoordinate;
    }
    return null;
  }

  static int? parseCents(String value) {
    final String trimmed = value.trim().replaceAll(' ', '');
    final String withoutThousands = trimmed.contains(',')
        ? trimmed.replaceAll('.', '')
        : trimmed;
    if (!_money.hasMatch(withoutThousands)) {
      return null;
    }
    final List<String> parts = withoutThousands
        .replaceAll(',', '.')
        .split('.');
    final int euros = int.parse(parts[0]);
    final int cents = parts.length == 1 ? 0 : int.parse(parts[1].padRight(2, '0'));
    return euros * 100 + cents;
  }

  static double? parseDecimal(String value) {
    return double.tryParse(value.trim().replaceAll(',', '.'));
  }

  static String centsToInput(int cents) {
    final String euros = (cents ~/ 100).toString();
    final String rest = (cents % 100).toString().padLeft(2, '0');
    return '$euros,$rest';
  }
}
