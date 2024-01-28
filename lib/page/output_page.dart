import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:coco_music_app/page/start_page.dart';
//import 'package:coco_music_app/page/select_page.dart';

class OutPutPage extends StatefulWidget {
  const OutPutPage(List<String> urlList, {super.key});

  @override
  State<OutPutPage> createState() => _OutPutPageState();
}

class _OutPutPageState extends State<OutPutPage> {
  //final List<String> urlList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushReplacement(
          context, MaterialPageRoute(
            builder: (context) => const StartPage()
          ));
      },
      child: const Icon(Icons.turn_left)),

      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(
              url: WebUri('https://www.youtube.com/watch?v=25GKbFqKQAI')
            ),
          )
        ],
      )
          // Expanded(  
          //   child:InAppWebView(
          //   initialUrlRequest: URLRequest(
          //     url: WebUri('https://www.youtube.com/watch?v=25GKbFqKQAI')
          //   ),
          //   ),
          // )
    );
  }
}