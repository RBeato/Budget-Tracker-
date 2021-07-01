import 'dart:io';

import 'package:budget_tracker/budget_repository.dart';
import 'package:budget_tracker/env/env.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'budget_repository_test.mocks.dart';
import 'dart:io' show Platform;

@GenerateMocks([http.Client])
void main() {
  group('get items', () {
    test('returns the items if the http call completes successfully', () async {
      final client = MockClient();
      final budgetRepository = BudgetRepository();

      String url =
          'https://api.notion.com/v1/databases/${Env.notionDatabaseKey}/query';

      when(client.post(
        Uri.parse(url),
      )).thenAnswer((_) async =>
          http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200));

      expect(await budgetRepository.getItems(), isA<List>());
    });
  });
}
