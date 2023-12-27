import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:coco_music_app/page/start_page.dart';
//import 'package:get/get_navigation/src/root/parse_route.dart';

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
              url: WebUri.uri(Uri.parse("https://github.com"))
              //url: Uri.parse("https://p.scdn.co/mp3-preview/08bce738f91707117193ead9c31e846519955ea7?cid=9519c3a0242b447db512032b93286813")
            ),
            initialSettings: InAppWebViewSettings(
              useOnNavigationResponse: true
            ),
            // initialOptions: InAppWebViewGroupOptions(
            //   ios: IOSInAppWebViewOptions(useOnNavigationResponse: true)
            ),

          Positioned(
            bottom: 200,  //위치조절 우측하단 배치
            right:  30,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushReplacement( //현재page를 stack에서 제거하고 페이지 이동
                context,
                MaterialPageRoute(
                  builder: (context) => const StartPage()
                ),
              );
              },
              child: const Icon(Icons.turn_left),
            ),
          )
        ], 
      )
    );
  }
}