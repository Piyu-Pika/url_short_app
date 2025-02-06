import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/url.dart';

class Api {
  static String baseUrl = dotenv.env['BASEURL'] ?? 'http://localhost:3000/api';
  final http.Client client;

  Api({http.Client? client}) : client = client ?? http.Client();

  Future<List<UrlModel>> getUrls() async {
    try {
      final response = await client
          .get(Uri.parse('$baseUrl/urls'))
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => UrlModel.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to load URLs. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching URLs: $e');
    }
  }

  Future<UrlModel> createShortUrl(String originalUrl) async {
    try {
      final response = await client
          .post(
            Uri.parse('$baseUrl/shorten'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({'originalUrl': originalUrl}),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return UrlModel.fromJson(jsonData);
      } else {
        throw Exception(
            'Failed to create short URL. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating short URL: $e');
    }
  }
  Future<void> deleteUrl(String urlId) async {
    try {
      final response = await client
          .delete(
            Uri.parse('$baseUrl/$urlId'),
          )
          .timeout(const Duration(seconds: 10));
          if (response.statusCode == 200) {
            return;
          } else {
            throw Exception(
                'Failed to delete URL. Status code: ${response.statusCode}');
          }
    } catch (e) {
      throw Exception('Error deleting URL: $e');
    }
  }

  void close() {
    client.close();
  }
}
