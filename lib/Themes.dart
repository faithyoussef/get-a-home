import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static const PREFKEY = 'theme';

  setTheme(bool value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setBool(PREFKEY, value);
  }

  getTheme() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getBool(PREFKEY) ?? false;
  }
}



class ThemeModel extends ChangeNotifier {
  bool _isDark = false;

  ThemePreferences _themePref = ThemePreferences();

  bool get isDark => _isDark;

  ThemeModel() {
    _isDark = false;
    _themePref = ThemePreferences();
  }
  set isDark(bool value) {
    _isDark = value;
    _themePref.setTheme(value);
    notifyListeners();
  }

  getPreferences() async {
    _isDark = await _themePref.getTheme();
    notifyListeners();
  }
}


class LightTheme {
  var scafforldColor = Colors.grey[200];
  var buttonColor = Colors.blue;
  var bottomNavColor = Colors.white;
  var iconColor = Colors.black;
  var activeIconColor = Colors.blue;
}

class DarkTheme {
  var scafforldColor = Color.fromARGB(255, 40, 49, 73);
  var buttonColor = Colors.blue;
  var bottomNavColor = Color.fromARGB(255, 64, 75, 105);
  var iconColor = Colors.white;
  var activeIconColor = Colors.blue;
}
