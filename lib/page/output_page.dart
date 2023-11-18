import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class OutPutPage extends StatefulWidget {
  const OutPutPage({super.key});

  @override
  State<OutPutPage> createState() => _OutPutPageState();
}

class _OutPutPageState extends State<OutPutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse("https://www.youtube.com/watch?v=RMRgATTlNrM")
        ),
        initialOptions: InAppWebViewGroupOptions(
          ios: IOSInAppWebViewOptions(useOnNavigationResponse: true)
        ),
      ),
    );
  }
}