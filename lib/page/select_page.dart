import 'package:flutter/material.dart';
import 'dart:io';
//import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
//import 'package:coco_music_app/page/output_page.dart';

class SelectPage extends StatelessWidget {
  SelectPage({super.key});
  final ImagePicker picker = ImagePicker();
  final RxList<XFile> images = <XFile>[].obs; 
  late final XFile? image;
  //final Dio dio = Dio();
  //final List<String> urlList = []; // 변경된 부분: urlList를 RxList로 변경

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    final uploadButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          padding: const EdgeInsets.all(15),
          backgroundColor: Colors.purple,
        ),
        onPressed: () {
          //http
          //uploadImages();
        },
        child: const Text("Upload", style: TextStyle(color: Colors.white))
      ),
    );

    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView( //스크롤이 가능한 UI
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
            Align(      //카메라 버튼
              alignment: Alignment(Alignment.bottomRight.x, Alignment.bottomRight.y - 0.18),
              child: FloatingActionButton(
                onPressed: () async {
                  final image = await picker.pickImage(
                    source: ImageSource.camera,
                    maxHeight: 200,
                    maxWidth: 200,
                    imageQuality: 100
                  );
                  if(image != null) {
                    images.add(image);
                  //setState((){
                  //images?.add(image);
                  //});
                  }
                },
                heroTag: 'Image0',
                child: const Icon(Icons.camera),
              ),
            ),
            Align(      //앨범 버튼
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () async {
                  final multiImage = await picker.pickMultiImage(
                    maxHeight: 200,
                    maxWidth: 200,
                    imageQuality: 100
                  );
                  images.addAll(multiImage);
                  // Setstate((){
                  //   images?.addAll(multiImage);
                  // });
                },
                heroTag: 'image1',
                child: const Icon(Icons.photo_album),
              ),
            )
          ],
        )
      )
    );
  }

  Widget _area() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        shrinkWrap: true,
        itemCount: images.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1/1,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10
        ),
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    //이미지 띄우는 부분 작동 안함
                    //Obx적용 해야함
                    image: FileImage(File(images[index].path))
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.close, color: Colors.white, size: 15,),
                  onPressed: (){
                    images.remove(images[index]);
                    // setState((){
                    //   images!.remove(images![index]);
                    // });
                  },
                )
              )
            ],
          );
        },
      ),
    );
  }
}

// class SelectPage extends StatefulWidget {
//   const SelectPage({super.key});

//   @override
//   State<SelectPage> createState() => _SelectPageState();
// }

// class _SelectPageState extends State<SelectPage> {
//   final ImagePicker picker = ImagePicker();
//   XFile? image;
//   final List<XFile> multiImage = [];
//   List<XFile>? images = [];
//   late Dio dio = Dio();
//   List<String> urlList = [];

//   Future<void> uploadImages() async {

//     List<MultipartFile> imageFiles = []; //http를 사용, 이미지 post로 전송

//     for (int i = 0; i < images!.length; i++) {
//       var img = images![i];
//       String filePath = img.path;
//       String fileName = img.name;

//       imageFiles.add(await MultipartFile.fromFile(filePath, filename: fileName));
//     }
//       String url = 'http://127.0.0.1:8000/api/upload';
//       FormData formData = FormData.fromMap({
//         'images': imageFiles,
//       });

//       try {
//         Response response = await dio.post(url, data: formData);
//         if (response.statusCode == 200) {
//           //url List 수신
//           urlList = List<String>.from(response.data["song_urls"]);

//           //print('URL List: $urlList'); 디버깅 코드
//         } else {
//           print('Image upload failed');
//         }
//       } catch (e) {
//         print('Error uploding image: $e');
//       }
//     //서버에서 보낸 데이터를 성공적으로 response했을 때 아래 메소드 실행
//     await _navigateToOutPutPage();
//   }

//   Future _navigateToOutPutPage() async {
//     await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => OutPutPage(urlList))
//     );
//   }


//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;

//     final uploadButton = Padding(       //upload button
//     padding: const EdgeInsets.symmetric(vertical: 16.0),
//     child: ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(24),
//         ),
//         padding: const EdgeInsets.all(15),
//         backgroundColor: Colors.purple,
//       ),
//       onPressed: () {
//         //이미지 추가하지 않고 눌렀을 때는 오류가 아니라 반응이 없도록 수정
//         uploadImages();
//       },
//       child: const Text("UpLoad", style: TextStyle(color: Colors.white),),
//     ),
//   );

//     return MaterialApp(
//       home: Scaffold(
//         body: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(height: screenHeight * 0.13),
//               _area(),
//               uploadButton,
//             ],
//           ),
//         ),
//         floatingActionButton: Stack(
//           children: [
//             Align(
//               alignment: Alignment(
//                 Alignment.bottomRight.x, Alignment.bottomRight.y - 0.18
//               ),
//               child: FloatingActionButton(    //camera button
//                 onPressed: () async {
//                   final image = await picker.pickImage(
//                     source: ImageSource.camera,
//                     maxHeight: 200,
//                     maxWidth: 200,
//                     imageQuality: 100
//                   );
//                   if (image != null) {
//                     setState(() {
//                       images?.add(image);
//                     });
//                   }
//                 },
//                 heroTag: 'image0',
//                 child: const Icon(Icons.camera),
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomRight,
//               child: FloatingActionButton(    //photo button
//                 onPressed: () async {
//                   final multiImage = await picker.pickMultiImage(
//                     maxHeight: 200,
//                     maxWidth: 200,
//                     imageQuality: 100
//                   );
//                   setState(() {
//                     images?.addAll(multiImage);
//                   });
//                 },
//                 heroTag: 'image1',
//                 child: const Icon(Icons.photo_album),
//               ),
//             )
//           ],
//         ),

//       ),
//     );
//   }

//   Widget _area() {
//     return Container(
//       margin: const EdgeInsets.all(10),
//       child: GridView.builder(
//         padding: const EdgeInsets.all(10),
//         shrinkWrap: true,
//         itemCount: images!.length,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3, //1개의 행에 보여줄 사진의 개수
//           childAspectRatio: 1/1, //사진 가로세로 비율
//           mainAxisSpacing: 10, //수평
//           crossAxisSpacing: 10, //수직
//         ),

//         itemBuilder: (BuildContext context, int index){
//           return Stack(
//             alignment: Alignment.topRight,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   image: DecorationImage(
//                     fit: BoxFit.cover,   //사진 크기를 Container 크기에 맞춤
//                     image: FileImage(File(images![index].path)) //images 리스트안에 있는 사진들을 순서대로 표시
//                   ),
//                 ),
//               ),

//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 //삭제버튼
//                 child: IconButton(
//                   padding: EdgeInsets.zero,
//                   constraints: const BoxConstraints(),
//                   icon: const Icon(Icons.close,
//                   color: Colors.white,
//                   size: 15
//                   ),
//                   onPressed: (){
//                     setState(() {
//                       images!.remove(images![index]);
//                     });
//                   }
//                 ),
//               )
//             ],
//           );
//         },
//       ),
//     );
//   }
// }