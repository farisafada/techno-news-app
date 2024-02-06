import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReadMore extends StatefulWidget {
  final String link;

  const ReadMore({
    super.key, 
    required this.link,
  });

  @override
  State<ReadMore> createState() => _ReadMore();
}

class _ReadMore extends State<ReadMore> {
  
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse(widget.link),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}