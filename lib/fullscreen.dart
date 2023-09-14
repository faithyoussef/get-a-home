import 'package:flutter/material.dart';
import 'package:gallery_saver/files.dart';

import "package:http/http.dart" as http;
class FullScreen extends StatefulWidget {
  final String url;

  const FullScreen({required Key key, required this.url}) : super(key: key);
  @override
  _FullScreenState createState() => _FullScreenState();
}
Future <dynamic> view(){
   var result = http.get(Uri.parse("http://api.pexels.com/v1/search?query=random&per_page=30&page=any"),headers: {
      "title": "Anything",
      "body": "Anything",
      "userid": "1",
      });
  return result;

}

Future <dynamic> Download(){
    var result = http.get(Uri.parse("http://api.pexels.com/v1/search?query=random&per_page=30&page=any"),headers: {
        "title": "Anything",
        "body": "Anything",
        "userid": "1",
        });
    return result;
}

class _FullScreenState extends State<FullScreen> {
  List<String> images = [
    'Set Wallpaper',
    'Download',
  ];
  Future<void> setwallpaper() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('view'),
            content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              child: ListBody(
                children: [
                  GestureDetector(
                    onTap: () {
                       view();
                    },
                    child: Text('Set Wallpaper'),
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    onTap: () {
                   Download();


                    },
                    child: Text('download Wallpaper'),
                  ),
                ],
              ),
            ),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: Image.network(widget.url),
                ),
              ),
              InkWell(
                onTap: () {
                  setwallpaper();
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  color: Colors.black,
                  child: Center(
                    child: Text('Set Wallpaper',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                ),
              )
            ],
          )),
    );
  }
}