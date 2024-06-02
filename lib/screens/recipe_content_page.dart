import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipeContentPage extends StatefulWidget {
  final String appRecipeContentUrl;

  const RecipeContentPage({
    super.key,
    required this.appRecipeContentUrl,
  });

  @override
  State<RecipeContentPage> createState() => _RecipeContentPageState();
}

class _RecipeContentPageState extends State<RecipeContentPage> {
  late WebViewController webViewController;

  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..loadRequest(Uri.parse(widget.appRecipeContentUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WebView"),
      ),
      body: WebViewWidget(
        controller: webViewController,
      ),
    );
  }
}
