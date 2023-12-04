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
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(
              url: Uri.parse("https://p.scdn.co/mp3-preview/08bce738f91707117193ead9c31e846519955ea7?cid=9519c3a0242b447db512032b93286813")
            ),
            initialOptions: InAppWebViewGroupOptions(
              ios: IOSInAppWebViewOptions(useOnNavigationResponse: true)
            ),
          ),
          Positioned(
            bottom: 200,
            right:  30,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.turn_left),
            ),
          )
        ], 
      )
    );
  }
}