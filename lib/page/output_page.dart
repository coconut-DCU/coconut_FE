import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:coco_music_app/page/start_page.dart';
//import 'dart:math';

class OutPutPage extends StatefulWidget {
  const OutPutPage({super.key});

  @override
  State<OutPutPage> createState() => _OutPutPageState();
}

class _OutPutPageState extends State<OutPutPage> {
 // List<String> url = urlList;

  //late List<String> selectUrlList = [];
  //var selectUrlList = widget.urlList.isNotEmpty; //
  //List<String> urlList = widget.urlList;

  // @override
  // void initState() {
  //   super.initState();
  //   // 초기에는 urlList가 비어있을 수 있으므로 예외 처리
  //   var selectedUrl = widget.urlList.isNotEmpty
  //       ? widget.urlList[Random().nextInt(widget.urlList.length)]
  //       : 'https://www.youtube.com/watch?v=25GKbFqKQAI';
  // }

 // var outUrl = urlList[Random().nextInt(5)];

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