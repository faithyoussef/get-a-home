import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Themes.dart';
import 'imageview.dart';

class NaturePage extends StatefulWidget {
  const NaturePage({super.key});

  @override
  State<NaturePage> createState() => _NaturePageState();
}

class _NaturePageState extends State<NaturePage> {
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
          ),
          body: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Nature',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Nature')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          //return text.
                          return Text(
                            '${snapshot.data!.docs.length} wallpapers available',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          );
                        } else {
                          //return text with no wallpapers.
                          return Text(
                            'No wallpapers available',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              //Masonry GridView [from package].
              StreamBuilder(
                stream:
                FirebaseFirestore.instance.collection('Nature').snapshots(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          //crossAxisCount: 2,
                        //  mainAxisSpacing: 6,
                        //  crossAxisSpacing: 6,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: ((context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) => ImagePreviewer(
                                        url: snapshot.data!.docs[index]
                                        ['url'], photographer: 'any', photographerId: 1,
                                      photographerUrl: 'any', src: snapshot.data!.docs[index]['src']



                                    )),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  snapshot.data!.docs[index]['imageUrl'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    );
                  } else {
                    //return shimmer.
                    return Container();
                  }
                }),
              )
            ],
          ),
        );
      }),
    );
  }
}
