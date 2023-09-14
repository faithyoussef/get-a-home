import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ImagePreviewer extends StatefulWidget {
  String url;
  String photographer;
  String photographerUrl;
  int photographerId;
  SrcModel src;

  ImagePreviewer({
    super.key,
    required this.url,
    required this.photographer,
    required this.photographerId,
    required this.photographerUrl,
    required this.src,
   // required this.src
  });

  factory ImagePreviewer.fromMap(Map<String, dynamic> parsedJson) {
    return ImagePreviewer(
        url: parsedJson["url"],
        photographer: parsedJson["photographer"],
        photographerId: parsedJson["photographer_id"],
        photographerUrl: parsedJson["photographer_url"],
        // src: parsedJson["src"]
        src: SrcModel.fromMap(parsedJson["src"]
        ));

}


  @override
  State<ImagePreviewer> createState() => _ImagePreviewerState();
}
class SrcModel {
  String portrait;
  String large;
  String landscape;
  String medium;

  SrcModel(
      {required this.portrait, required this.landscape, required this.large, required this.medium, required Object original});

  factory SrcModel.fromMap(Map<String, dynamic> srcJson) {
    return SrcModel(
        portrait: srcJson["portrait"],
        large: srcJson["large"],
        landscape: srcJson["landscape"],
        medium: srcJson["medium"],
        original: srcJson["original"]);
  }
}

class _ImagePreviewerState extends State<ImagePreviewer> {
  downloadImage() async {
    try {
      await GallerySaver.saveImage(widget.url,
          toDcim: true, albumName: 'Wallpaper-verse');

      Fluttertoast.showToast(
        msg: "Wallaper downloaded",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }


  _save() async {
    var response = await Uri.http(
        "https://ss0.baidu.com/94o3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=a62e824376d98d1069d40a31113eb807/838ba61ea8d3fd1fc9c7b6853a4e251f94ca5f46.jpg",
    );
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data as List<int>),
        quality: 60,
        name: "hello");
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(widget.url),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                downloadImage();
                _save();

              },
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    'Download',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
