//로딩 화면 https://pub.dev/packages/flutter_spinkit
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitCircle(
          color: Colors.purple,
          size: 50,
          duration: Duration(seconds: 2),
        ),
      )
    );
  }
}