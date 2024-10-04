import 'dart:convert';
import '../model/news_model.dart';
import 'package:http/http.dart' as http;


class NewsData{
  final String apiUrl = 'https://finnhub.io/api/v1/news?category=general';
  final String apiKey = 'crals9pr01qhk4bqotb0crals9pr01qhk4bqotbg';

  Future <List<NewsArticleModel>> getNewsArticles()async{
   
    try {
     final response = await http.get(
         Uri.parse(apiUrl),
         headers: {
           'X-Finnhub-Token': apiKey,
         }
     );

     print('Response status: ${response.statusCode}');

     if (response.statusCode == 200) {

       print('Response data: ${response.body}');

        List<dynamic> jsonData = json.decode(response.body);

        return jsonData.map((article) => NewsArticleModel.fromJson(article)).toList();
     }else{
       throw Exception('Failed to load news articles');
     }
    }catch (e){
      throw Exception('Error fetching News: $e');
    }
  }
}