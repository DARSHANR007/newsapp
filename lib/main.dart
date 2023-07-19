import 'package:flutter/material.dart';
import 'package:news/category_newsAPI.dart';

import 'categories.dart';
import 'home_page.dart';



void main()=> runApp(MyApp());



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Home(),
      debugShowCheckedModeBanner:false,
      theme: ThemeData.dark(useMaterial3:true),
    );
  }
}
