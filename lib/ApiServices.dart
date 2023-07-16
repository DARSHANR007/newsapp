import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/secrets.dart';

import 'models.dart';

class ApiServices {
  Future<List<Article>> getData() async {
    const url = "https://newsapi.org/v2/everything?q=bitcoin&apiKey=$key";

    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
       List articles = body['articles'];

      List<Article> x = [];

      for (var articleData in articles) {
        var author = articleData['author'];
        var title = articleData['title'];
        var description = articleData['description'];
        var url = articleData['url'];
        var urlToImage = articleData['urlToImage'];
        var publishedAt = DateTime.parse(articleData['publishedAt']);
        var content = articleData['content'];

        final article = Article(
          author: author,
          title: title,
          description: description,
          url: url,
          urlToImage: urlToImage,
          publishedAt: publishedAt,
          content: content,
        );

        x.add(article);
      }

      return x;
    } else {
      throw Exception("ERROR STATUS MESSAGE ${res.statusCode}");
    }
  }
}
