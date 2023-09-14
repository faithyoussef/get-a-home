import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'Themes.dart';
import 'fullscreen.dart';
import 'imageview.dart';

class DataProvider {
  final String imgSource = 'https://api.pexels.com/v1/search?query=random&per_page=30&page=any';
}

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

/**
 * Provider<Example>(
    create: (_) => Example(),
    // we use `builder` to obtain a new `BuildContext` that has access to the provider
    builder: (context, child) {
    // No longer throws
    return Text(context.watch<Example>().toString());
    }
 */
class _ExplorePageState extends State<ExplorePage> {
List<ImagePreviewer>listPhotos = [];

int photo= 100;
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
      "https://api.pexels.com/v1/curated?per_page=$noOfImageToLoad&page=$photo"),
      headers: {"Authorization": apiKey}).then((value) {
    print(value.body);

    Map<String, dynamic> jsonData = jsonDecode(value.body);
    jsonData["photos"].forEach((element) {
      //print(element);
      //  print(response.body);
     // ImagePreviewer imagePreviewer = new ImagePreviewer(url: 'any' , photographer: 'any', photographerId: 2, photographerUrl: 'any', src: randomImageUrl());
     // imagePreviewer = ImagePreviewer.fromMap(element);

    //  images.add(imagePreviewer);
      //  print(photosModel.toString()+ "  "+ photosModel.src.portrait);
    });

    setState(() {
      images = jsonData["photos"].map<ImagePreviewer>((element) {
        return ImagePreviewer.fromMap(element);
      }).toList();
    });
  });
}



  @override
  Widget build(BuildContext context) {
    return Provider<ThemeModel>(
      create: (_) => ThemeModel(),
      builder: (context, child) {
        //const isDark = themeNotifier == ThemeMode.dark;
        //var isDark;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: context.watch<ThemeModel>().isDark
                ? DarkTheme().scafforldColor
                : LightTheme().scafforldColor,
            scrolledUnderElevation: 0,
            actions: [

              IconButton(
                onPressed: () {
                 Navigator.push(context,
                     MaterialPageRoute(builder: (context) => FullScreen(
                         key: UniqueKey(), url: 'any')));
                },
                icon: Icon(Icons.arrow_back_ios),

              )
            ],
          ),
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child:
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100,
                    right: 100,),
                    child: Text(
                      'Explore',
                      style: TextStyle(
                        fontSize: 55,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
                ),
                ),
            SizedBox(
                height: 10,
              ),
              //Masonry GridView [from package].
           Flexible(
             flex:2,
             child:  GridView.builder(
                shrinkWrap: true,
                itemCount: images.length,
                   // enableInfiniteScroll: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 2,
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 3,
                            mainAxisSpacing: 2),
                         itemBuilder: (context, listPhotos) {
                           return InkWell(
                              onTap: () {
                            Navigator.push(
                                   context,
                                      MaterialPageRoute(
                                   builder: (context) => FullScreen(
                      url : images[listPhotos].src.portrait,
                             key: UniqueKey(),
                             ),
               ),
               );
    },
                     child: Container(
                          color: Colors.white,
                            child: Image.network(
                        images[listPhotos].src.landscape,
                          fit: BoxFit.cover,
                     ),
                   ),
                     );
                      }),
           ),
                        InkWell(
                       onTap: () {
                         DataProvider().imgSource;
                         getTrendingWallpaper();
                         //liked();
                       },
                              child: Container(
                                margin: EdgeInsets.only(top: 100, bottom: 8),
                       height: 50,

                     width: double.infinity,
                                          color: Colors.black,
                        child: Center(
                     child: Text('Load More',
                style: TextStyle(fontSize: 20, color: Colors.white)),
                                   ),
               ),
        ),
             ],
          ),
       );

  });
  }

  randomImageUrl() {
    return 'https://images.pexels.com/photos/20787/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=$photo&w=500';
  }
}
