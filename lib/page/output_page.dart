import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'dart:math';

class OutPutPage extends StatelessWidget {
  const OutPutPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> urlList = Get.arguments ?? []; //null 일경우 [](빈 리스트)를 사용

    String randomUrl = urlList.isEmpty     //random으로 추출한 url을 randomUrl에 담아서 사용
    ? 'https://www.youtube.com/?bp=wgUCEAE%3D' 
    : urlList[Random().nextInt(urlList.length)];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/start'),
        child: const Icon(Icons.turn_left),
      ),

      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(
              url: WebUri(randomUrl)
            ),
          )
        ],
      )
    );
  }
}