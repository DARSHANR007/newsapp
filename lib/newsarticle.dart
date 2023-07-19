import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class NewsArticle extends StatefulWidget {
  const NewsArticle({Key? key, required this.urlLink, required this.dateTime}) : super(key: key);
  final String urlLink;
   final DateTime dateTime;

  @override
  State<NewsArticle> createState() => _NewsArticleState();
}

class _NewsArticleState extends State<NewsArticle> {

  late WebViewController controller;


  @override
  void initState() {
    super.initState();
     controller  = WebViewController()
      ..loadRequest(Uri.parse(widget.urlLink));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Published On:${widget.dateTime}"
      ),),

      body: WebViewWidget(controller:controller,)
    );
  }
}

