import 'package:finance_digest/data/api.dart';
import 'package:finance_digest/model/news_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class MockClient extends Mock implements http.Client {}

void main() {
  group('NewsData', () {
    test('returns news articles if the http call completes successfully', () async {
      final client = MockClient();
      final newsData = NewsData();

      // Mock successful API response
      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('[{"headline": "Test News"}]', 200));

      List<NewsArticleModel> articles = await newsData.getNewsArticles();

      expect(articles, isA<List<NewsArticleModel>>());
      expect(articles.first.headline, "Test News");
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();
      final newsData = NewsData();

      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(newsData.getNewsArticles(), throwsException);
    });
  });
}
