import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final startButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25)
          ),
          padding: const EdgeInsets.all(15),
          backgroundColor: const Color.fromARGB(255, 205, 127, 196)
        ),
        onPressed: () => Get.toNamed('/select'),
        child: const Text('시작하기', style: TextStyle(color: Colors.black)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 50.5, right: 50.5),
          children: [
            const SizedBox(height: 50),
            const Text('data',
            style:  TextStyle(fontSize: 35.0, fontWeight: FontWeight.w600)),
            const SizedBox(height: 550.0),
            startButton
          ],
        ),
      ),
    );
  }
}