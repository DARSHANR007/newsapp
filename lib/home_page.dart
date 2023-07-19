import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/ApiServices.dart';
import 'package:news/categories.dart';
import 'package:news/category_newsAPI.dart';
import 'package:news/newsarticle.dart';

import 'models.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ApiServices apiServices = ApiServices();
  CategoryNews categoryNews = CategoryNews();
  List<Article>? article;

  // List of news categories
  List<String> newsCategories = [
    'General',
    'Business',
    'Sports',
    'Health',
    'Technology'
  ];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final List<Article> data = await apiServices.getData();
      setState(() {
        article = data;
      });
    } catch (e) {
      throw Exception("Error in receiving data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "N e w s",
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          NewsCategories(),
          // Horizontal ListView of news categories

          const SizedBox(height: 30),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                var x = article?[index];
                if (x == null) {
                  return Container(); // Return an empty container or a loading widget when the article is null.
                }
                var author = x.author;
                var title = x.title;
                var description = x.description;
                var url = x.url;
                var urlToImage = x.urlToImage;
                var publishedAt = x.publishedAt;
                var content = x.content;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: ExpansionTile(
                    title: Text(
                      title,
                      style: GoogleFonts.rubik(fontSize: 20),
                    ),
                    children: [
                      Container(
                        width: 400,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Image.network(urlToImage!),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              description,
                              style: GoogleFonts.rubik(fontSize: 15),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewsArticle(
                                            urlLink: url,
                                            dateTime: publishedAt,
                                          )));
                            },
                            child: const Text("Read post"),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              itemCount: article?.length ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}
