import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class SelectPage extends StatefulWidget {
  const SelectPage({super.key});

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  final ImagePicker picker = ImagePicker();
  XFile? image;
  final List<XFile> multiImage = [];
  List<XFile>? images = [];
  
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.13),
              _area(),
              SizedBox(height: screenHeight * 0.3),
              bodyWidget()
            ],
          )
        )
      ),
    );
  }

  Widget _area() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        shrinkWrap: true,
        itemCount: images!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, //1개의 행에 보여줄 사진의 개수
          childAspectRatio: 1/1, //사진 가로세로 비율
          mainAxisSpacing: 10, //수평
          crossAxisSpacing: 10, //수직
        ),

        itemBuilder: (BuildContext context, int index){
          return Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    fit: BoxFit.cover,   //사진 크기를 Container 크기에 맞춤
                    image: FileImage(File(images![index].path)) //images 리스트안에 있는 사진들을 순서대로 표시
                  ),
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),
                ),
                //삭제버튼
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.close,
                  color: Colors.white,
                  size: 15
                  ),
                  onPressed: (){
                    setState(() {
                      images!.remove(images![index]);
                    });
                  }
                ),
              )
            ],
          );
        },
      ),
    );
  }
  
  Widget bodyWidget () {
    return Column(
      children: [
        _cameraButton(),
          const SizedBox(height: 10),
          _photoButton(),
      ],
    );
  }

  Widget _cameraButton() {
    return Column(
      children: [
        FloatingActionButton(
          onPressed: () async {
           final image = await picker.pickImage(source: ImageSource.camera);
           if (image != null) {
             setState(() {
               images!.add(image);
             });
           }
          },
          heroTag: 'image0',
          child: const Icon(Icons.camera),
        ),
      ],
    );
  }
  
  Widget _photoButton() {
    return Column(
      children: [
        FloatingActionButton(
          onPressed: () async {
            final multiImage = await picker.pickMultiImage();
            setState(() {
              images!.addAll(multiImage);
            });
          },
          heroTag: 'image1',
          child: const Icon(Icons.photo_album),
        ),
      ],
    );
  }
}