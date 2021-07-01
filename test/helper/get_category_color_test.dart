import 'package:budget_tracker/helper/get_category_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GetColor', () {
    test('getCategoryColor return blue when category is Personal.', () {
      expect(getCategoryColor('Personal'), Colors.blue[400]);
    });
    test('getCategoryColor return red when category is Entertainment.', () {
      expect(getCategoryColor('Entertainment'), Colors.red[400]);
    });
    test('getCategoryColor return purple when category is Food.', () {
      expect(getCategoryColor('Food'), Colors.green[400]);
    });
    test('getCategoryColor return red when category is Transportation.', () {
      expect(getCategoryColor('Transportation'), Colors.purple[400]);
    });
    test('getCategoryColor return orange as default', () {
      expect(getCategoryColor(''), Colors.orange[400]);
    });
  });
}
