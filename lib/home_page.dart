import 'package:flutter/material.dart';
import 'package:news/ApiServices.dart';

import 'models.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ApiServices apiServices = ApiServices();
  List<Article>? article;

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
        children: [
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

                return ListTile(
                  title: Text(title),
                  subtitle: Text(description),
                  trailing: Text('Author: ${author ?? ''}'),
                  onTap: () {
                    // Handle tap on article item
                    // You can navigate to a detailed view or do something else here
                  },
                );
              },
              itemCount: article?.length ?? 0, // Use the null-coalescing operator to handle a null article list.
            ),
          ),
        ],
      ),
    );
  }
}
