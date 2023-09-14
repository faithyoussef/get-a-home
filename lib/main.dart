


import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import  'package:http/http.dart'as http;
import 'Myhome.dart';
import 'Themes.dart';
import 'firebase_options.dart';
import 'imageview.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<ImagePreviewer> images = [];
  int noOfImageToLoad = 30;
  String apiKey = 'l8hxBkmMNdN63IIf4mweziZAQh9yzb7l3eikpF8ORwqib5ueULs2gSZQ';
  getTrendingWallpaper() async {
    /**  await http.get(Uri.parse("https://api.pexels.com/v1/search?query=${widget
        .category}?per_page=30&page=1"), headers: {
        "title": "Anything",
        "body": "Post body",
        "userid": "1",
        });
     **/
    await http.get(Uri.parse(
        "https://api.pexels.com/v1/curated?per_page=$noOfImageToLoad&page=1"),
        headers: {"Authorization": apiKey}).then((value) {
      print(value.body);

      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        //print(element);
        //  print(response.body);
        ImagePreviewer imagePreviewer = new ImagePreviewer(
            url: 'any' ,
            photographer: 'any',
            photographerId: 2,
            photographerUrl: 'any',
            src: randomImageUrl()

        );
        imagePreviewer = ImagePreviewer.fromMap(element);

        images.add(imagePreviewer);
        //  print(photosModel.toString()+ "  "+ photosModel.src.portrait);
      });

      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => ThemeModel()),
      child: Consumer(
        builder: (context, ThemeModel themeNotifier, child) {
          return MaterialApp(
            theme: themeNotifier.isDark
                ? ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark,
            //  fontFamily: 'Poppins',
            )
                : ThemeData(
              useMaterial3: true,
             // fontFamily: 'Poppins',
              brightness: Brightness.light,
            ),
            debugShowCheckedModeBanner: false,
            home: const MainHome(),
          );
        },
      ),
    );
  }
  randomImageUrl() {
    String url = "https://picsum.photos/seed/picsum/200/300";
    return url;
  }
}