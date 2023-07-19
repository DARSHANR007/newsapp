import 'package:flutter/material.dart';
import 'package:news/category_newsAPI.dart';
import 'categorial_news.dart';

class NewsCategories extends StatefulWidget {
  @override
  State<NewsCategories> createState() => _NewsCategoriesState();
}

class _NewsCategoriesState extends State<NewsCategories> {
  CategoryNews categoryNews = CategoryNews();

  final List<String> newsCategories = [
    'General',
    'Business',
    'Sports',
    'Science',
    'Technology',
  ];



  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50, // You can adjust the height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: newsCategories.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              onPressed: () {
                String selectedCategory = newsCategories[index];
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryNewsPage(category: selectedCategory),
                  ),
                );
              },
              child: Text(newsCategories[index]),
            ),
          );
        },
      ),
    );
  }
}
