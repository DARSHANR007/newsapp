import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/category_newsAPI.dart';
import 'models.dart';
import 'newsarticle.dart';

class CategoryNewsPage extends StatefulWidget {
  final String category;

  const CategoryNewsPage({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryNewsPage> createState() => _CategoryNewsPageState();
}

class _CategoryNewsPageState extends State<CategoryNewsPage> {
  CategoryNews categoryNews = CategoryNews();
  List<Article>? articles;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final List<Article> data = await categoryNews.getData(widget.category);
      setState(() {
        articles = data;
      });
    } catch (e) {
      throw Exception("Error in receiving data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: ListView.builder(
        itemCount: articles?.length ?? 0,
        itemBuilder: (context, index) {
          var x = articles?[index];
          if (x == null) {
            return Container(); // Return an empty container or a loading widget when the article is null.
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ExpansionTile(
              title: Text(
                x.title,
                style: GoogleFonts.rubik(fontSize: 20),
              ),
              children: [
                Container(
                  width: 400,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Image.network(x.urlToImage!),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        x.description,
                        style: GoogleFonts.rubik(fontSize: 15),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewsArticle(
                              urlLink: x.url,
                              dateTime: x.publishedAt,
                            ),
                          ),
                        );
                      },
                      child: const Text("Read post"),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
