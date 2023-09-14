import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getawallpaper/favorites.dart';
import 'package:getawallpaper/naturepreview.dart';
import 'package:getawallpaper/searchpage.dart';
import 'package:getawallpaper/settings.dart';
import 'package:provider/provider.dart';

import 'Themes.dart';
import 'explorer.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  int currentPage = 0;
  void onPageChange(int index) {
    setState(() {
      currentPage = index;
    });
  }

  final List _pages = [
    SearchPage(),
    ExplorePage(),
    SettingsPage(),
    NaturePage(),
    favorites(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: ((context, ThemeModel themeNotifier, child) {
        return Scaffold(
          //Body
          body: _pages[currentPage],
          //BottonNavigationBar.
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentPage,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: themeNotifier.isDark
                ? DarkTheme().bottomNavColor
                : LightTheme().bottomNavColor,
            onTap: onPageChange,
            items: [
              //Home item
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/home_icon.svg',
                    fit: BoxFit.none,
                    color: themeNotifier.isDark
                        ? DarkTheme().iconColor
                        : LightTheme().iconColor,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/active_home.svg',
                    fit: BoxFit.none,
                    color: Colors.blue,
                  ),
                  label: 'Home'),
              //Downloads item
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/explore.svg',
                    fit: BoxFit.none,
                    color: themeNotifier.isDark
                        ? DarkTheme().iconColor
                        : LightTheme().iconColor,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/active_explore.svg',
                    fit: BoxFit.none,
                    color: Colors.lightBlue,
                  ),
                  label: 'Explore'),
              //Settings Item
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/settings_icon.svg',
                    fit: BoxFit.none,
                    color: themeNotifier.isDark
                        ? DarkTheme().iconColor
                        : LightTheme().iconColor,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/active_settings.svg',
                    fit: BoxFit.none,
                    color: Colors.lightBlue,
                  ),
                  label: 'Settings'),

              BottomNavigationBarItem(icon: Icon(Icons.nature)),
              BottomNavigationBarItem(icon: Icon(Icons.favorite_border)),
            ],
          ),
        );
      }),
    );
  }
}