import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

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
  late Dio dio = Dio();

  Future<void> uploadImages() async {
    for (var img in images!) {
      String filePath = img.path;
      String fileName = img.name;

      String url = '127.0.0.1:8000';
      FormData formData = FormData.fromMap({
        'images': await MultipartFile.fromFile(filePath, filename: fileName),
      });

      Response response = await dio.post(url, data: formData);

      try {

        if (response.statusCode == 200) {
          print('Image uploaded successfully');
        } else {
          print('Image upload failed');
        }
      } catch (e) {
        print('Error uploding image: $e');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    final uploadButton = Padding(       //upload button
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.all(15),
        backgroundColor: Colors.purple,
      ),
      onPressed: () {
        uploadImages();
      },
      child: const Text("UpLoad", style: TextStyle(color: Colors.white),),
    ),
  );

    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.13),
              _area(),
              uploadButton,
            ],
          ),
        ),
        floatingActionButton: Stack(
          children: [
            Align(
              alignment: Alignment(
                Alignment.bottomRight.x, Alignment.bottomRight.y - 0.18
              ),
              child: FloatingActionButton(    //camera button
                onPressed: () async {
                  final image = await picker.pickImage(
                    source: ImageSource.camera,
                    maxHeight: 75,
                    maxWidth: 75,
                    imageQuality: 30
                  );
                  if (image != null) {
                    setState(() {
                      images?.add(image);
                    });
                  }
                },
                heroTag: 'image0',
                child: const Icon(Icons.camera),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(    //photo button
                onPressed: () async {
                  final multiImage = await picker.pickMultiImage(
                    maxHeight: 75,
                    maxWidth: 75,
                    imageQuality: 30
                  );
                  setState(() {
                    images?.addAll(multiImage);
                  });
                },
                heroTag: 'image1',
                child: const Icon(Icons.photo_album),
              ),
            )
          ],
        ),

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
}