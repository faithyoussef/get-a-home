import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart'as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Themes.dart';
import 'data.dart';
import 'explorer.dart';
import 'fullscreen.dart';
import 'imageview.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  //String get search => search;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  //late TextEditingController _controller;
  late String search_text = '';

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }


  TextEditingController searchController = new TextEditingController();

  List<ImagePreviewer> images = [];
  int noOfImageToLoad = 30;
  String apiKey = 'l8hxBkmMNdN63IIf4mweziZAQh9yzb7l3eikpF8ORwqib5ueULs2gSZQ';

  Future<dynamic> getTrendingWallpaper(search) async {
    /**  await http.get(Uri.parse("https://api.pexels.com/v1/search?query=${widget
        .category}?per_page=30&page=1"), headers: {
        "title": "Anything",
        "body": "Post body",
        "userid": "1",
        });
     **/
    await http.get(Uri.parse(
        "https://api.pexels.com/v1/curated?per_page=$noOfImageToLoad&page=3"),
        headers: {"Authorization": apiKey}).then((value) {
      print(value.body);

      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        //print(element);
        //  print(response.body);
        //  ImagePreviewer imagePreviewer = new ImagePreviewer(url: 'any' , photographer: 'any', photographerId: 2, photographerUrl: 'any', src: randomImageUrl());
        //  imagePreviewer = ImagePreviewer.fromMap(element);

        // images.add(imagePreviewer);
        //  print(photosModel.toString()+ "  "+ photosModel.src.portrait);
      });

      setState(() {
        images = jsonData["photos"].map<ImagePreviewer>((element) {
          return ImagePreviewer.fromMap(element);
        }).toList();
      });
      // print(images[0]);
    });
  }


  @override
  void initstate() {
    getTrendingWallpaper(searchController.text);
    getImageFromUrl(searchController.text);
    searchController.text = "";
    //_controller.dispose();
    // super.dispose();
  }

  Future<Uint8List> getImageFromUrl(url) async {
    String url = 'https://www.pexels.com/api/documentation/#$search_text-search';
    var response = await http.get(Uri.parse(url));
    Uint8List bytes = response.bodyBytes;
    return bytes;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: ((context, ThemeModel themeNotifier, child) {
        return Scaffold(
          backgroundColor: themeNotifier.isDark
              ? DarkTheme().scafforldColor
              : LightTheme().scafforldColor,
          appBar: AppBar(
            backgroundColor: themeNotifier.isDark
                ? DarkTheme().scafforldColor
                : LightTheme().scafforldColor,
            scrolledUnderElevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FullScreen(
                            key: UniqueKey(),
                            url: 'https://images.pexels.com/photos/220444/pexels-photo-220444.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                  ),
                );
              },
              icon: Icon(Icons.arrow_back),
            ),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            child:
          Column(
           // width: double.infinity,

            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisSize: double.infinity,
            // expandable: true,
            //  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10,
                    vertical: 10),
                child: Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: themeNotifier.isDark
                        ? DarkTheme().bottomNavColor
                        : LightTheme().bottomNavColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    controller: searchController,
                    style: TextStyle(color: Colors.black),
                    //size: 40,
                    onChanged: (value) {
                      setState(() {
                        search_text = value;
                      });
                    },
                    enableSuggestions: true,
                    //searchController: searchController,
                    enableInteractiveSelection: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      //wasfloating: true,
                      fillColor: Colors.black12,
                      hintText: search_text.isEmpty
                          ? 'Search'
                          : searchController.text,
                      contentPadding: EdgeInsets.only(left: 50),
                      //  hintText: 'Search something...',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                    //   getTrendingWallpaper(searchCntroller.text);

                    //  Text('Search'),
                  ),),
              ),
              SizedBox(
                height: 10,
              ),
              //Stream Builder.
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                onPressed: () {
                  getTrendingWallpaper(searchController.text);
                  getImageFromUrl(searchController.text);
                  searchController.text = "";
                  // _controller.dispose();
                },
                child: Text('Search'),
              ),
              Center(
                child: Flex(
                  //expanded: true,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  //flex:1,
                  direction: Axis.horizontal,
                  children:[
                  Expanded(
                    flex: 1,
                    //: FlexFit.tight,
                    child: images.isEmpty
                        ? Center(
                      child: CircularProgressIndicator(),
                    ): GridView.builder(
                      scrollDirection: Axis.vertical,

                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: images.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 3,
                          crossAxisCount: 3,
                          childAspectRatio: 2 / 3,
                          mainAxisSpacing: 3),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    FullScreen(
                                        key: UniqueKey(),
                                        url: images[index].src.portrait),
                              ),
                            );
                          },
                          child: Hero(
                            tag: images[index].src.portrait,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      images[index].src.portrait),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ]),
              )],
          ),
          //getTrendingWallpaper(searchController.text),

          // enableInfiniteScroll: true,
          // padding: EdgeInsets.all(10),
          // widthFactor: 6,
          /**  child: GridView.count(
              //enableInfiniteScroll: true,
              //padding: EdgeInsets.all(10),
              // padding :EdgeInsetsGeometry.infinity,
              // width: double.infinity,
              shrinkWrap:true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              // itemCount: images.length,
              crossAxisSpacing: 2,
              crossAxisCount: 3,
              childAspectRatio: 2 / 3,
              mainAxisSpacing: 2,
              children: [
              Transform.scale(
              scale:2,
              //Scale:0.5,
              // perspective:0.5,


              child: GridView.builder(
              scrollDirection: Axis.vertical,
              // dragStartBehavior: ,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),

              itemCount: images.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 3,
              crossAxisCount: 4,
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

              padding: EdgeInsetsDirectional.symmetric(
              horizontal: 1, vertical: 1),
              margin: EdgeInsetsDirectional.all(1),
              width: 200,
              height: 500,
              color: Colors.white,
              child: Image.network(
              images[listPhotos].src.landscape,
              // ft
              fit: BoxFit.cover,
              ),
              ),
              );
              }),
              ),
              ]),**/
          /**child: InkWell(
              onTap: () {
              DataProvider().imgSource;
              getTrendingWallpaper( searchController.text);
              },
              child: Container(
              margin: EdgeInsets.only(top: 280, bottom: 8),
              height: 50,
              width: 50,

              color: Colors.black,
              child: Center(
              child: Text('lol no more images',
              style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
              ),
              )
              ],
              ))]),**/
        ));
      }),
    );


    /** randomImageUrl() {
        return 'https://images.unsplash.com/photo-1634218617217-4b7b3b5b4b0f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyMjI0NjB8MHwxfHNlYXJjaHwxfHx3YWxscGFwZXJ8ZW58MHx8fHwxNjM0MjU0NjY0&ixlib=rb-1.2.1&q=80&w=1080';

        }**/
  }
}
class Results {

   final String cseKey;
   final String cseEngineID;

  const Results({
    required this.cseKey,
    required this.cseEngineID,
  });
}
//resultsCache _resultsCache = resultsCache();

