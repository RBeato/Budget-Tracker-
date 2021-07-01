import 'dart:convert';
import 'dart:io';

import 'package:budget_tracker/failure_model.dart';
import 'package:budget_tracker/item_model.dart';
import 'package:http/http.dart' as http;

import 'env/env.dart';

class BudgetRepository {
  static const String _baseUrl = 'https://api.notion.com/v1/';

  final http.Client _client;

  BudgetRepository({http.Client? client}) : _client = client ?? http.Client();

  void dispose() {
    _client.close();
  }

  Future<List<Item>> getItems() async {
    try {
      final url = '${_baseUrl}databases/${Env.notionDatabaseKey}/query';
      final response = await _client.post(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${Env.notionApiKey}',
          'Notion-Version': '2021-05-13',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        var result = (data['results'] as List)
            .map((e) => Item.fromMap(e))
            .toList()
              ..sort((a, b) => b.date.compareTo(a.date));
        return result;
      } else {
        throw const Failure(message: 'Something went wrong!');
      }
    } catch (_) {
      throw const Failure(message: 'Something went wrong!');
    }
  }
}
