import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/models.dart';

class CategoryNews {
  Future<List<Article>> getData(String category) async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=cbc56514c58d44378ca94005eb3ad488";
    var res = await http.get(Uri.parse(url));
    try {
      if (res.statusCode == 200) {
        List<Article> x = [];
        var body = jsonDecode(res.body);
        List articles = body['articles'];
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
        print(x);
      } else {
        throw Exception("error receiving data");
      }
    } catch (e) {
      throw Exception("error receiving data ${res.statusCode}");
    }
  }
}
