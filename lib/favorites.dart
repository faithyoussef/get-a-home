

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:cross_file_image/cross_file_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getawallpaper/imageview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;
import 'Themes.dart';
import 'favorites.dart';
import 'favorites.dart';

class favorites extends StatefulWidget {
  const favorites({Key? key}) : super(key: key);

  @override
  State<favorites> createState() => _favoritesState();
}

//final xFile = _controller.takePicture();
 //final photos = xFile.path;
//final bytes =  File().readAsBytes();


//Image(image: XFileImage(xfile));

class _favoritesState extends State<favorites> {

  List<ImagePreviewer> photoslist = [];
  bool liked = false;
   late String photos ;
 // late CameraController _controller;

  //final img.Image image = img.decodeImage(bytes)
  _pressed() {
    setState(() {
      liked = !liked;
    });
  }
  Future<String?> getStorageDirectory() async {
    if (Platform.isAndroid) {
      return (await getExternalStorageDirectory())?.path;  // OR return "/storage/emulated/0/Download";
    } else {
      return (await getApplicationDocumentsDirectory()).path;
    }
  }

 Future<String?> createImage() async{
    String dir= getStorageDirectory() as String;

    File directory = new File("$dir");
    if (directory.exists() != true) {
      directory.create();
    }
    File file = new File('$directory/image.jpeg');
    var newFile = await file.writeAsBytes( liked as List<int>);
    await newFile.create();
  }
  late CameraController controller;
  late List<CameraDescription> _cameras;

  @override
  void initState() {
    super.initState();
    controller = CameraController(_cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
          // Handle access errors here.
            break;
          default:
          // Handle other errors here.
            break;
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
   return Provider<ThemeModel>(
        create: (_) => ThemeModel(),
        builder: (context, child) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Text(
                'Favorites',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              ),
              elevation: 0,
            ),
            body: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                child: IconButton(
                  icon: Icon(liked ?Icons.favorite: Icons.favorite_border,
                      color: liked ? Colors.red :Colors.grey ),
                  onPressed: () => _pressed(),
                ),

              ),

              Container(
                child: IconButton(
                  icon: Icon(Icons.download_rounded),
                  onPressed: () => createImage(),
                ),
              ),
              Container(
                child: IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () => {},
                ),
              ),
              Container(
                child: InkWell(
                  onTap: () {
          CameraPreview(controller);
          },
                child: IconButton(
                  icon: Icon(Icons.camera),
                  onPressed: () => {
                    CameraAwesomeBuilder.awesome(
                      saveConfig: SaveConfig.photoAndVideo(
                        photoPathBuilder: () async {
                          final Directory extDir = await getTemporaryDirectory();
                          final testDir =
                          await Directory('${extDir.path}/test').create(recursive: true);
                          return '${testDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
                        },
                        videoPathBuilder: () async {
                          final Directory extDir = await getTemporaryDirectory();
                          final testDir =
                          await Directory('${extDir.path}/test').create(recursive: true);
                          return '${testDir.path}/${DateTime.now().millisecondsSinceEpoch}.mp4';
                        },
                     //   onMediaTap: (mediaCapture) {
                     //     OpenFile.open(mediaCapture.filePath);
                     //   },
                      ),
                    )

                  },
                ),
              )
              )],
          ));
        });
  }
}
