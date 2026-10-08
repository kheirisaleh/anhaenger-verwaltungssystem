abstract final class Csv {
  static const String separator = ';';

  static String encode(List<List<String>> rows) {
    final StringBuffer buffer = StringBuffer('﻿');
    for (final List<String> row in rows) {
      buffer.write(row.map(_escape).join(separator));
      buffer.write('\r\n');
    }
    return buffer.toString();
  }

  static String _escape(String value) {
    final bool needsQuotes =
        value.contains(separator) ||
        value.contains('"') ||
        value.contains('\n') ||
        value.contains('\r');
    if (!needsQuotes) {
      return value;
    }
    return '"${value.replaceAll('"', '""')}"';
  }
}
