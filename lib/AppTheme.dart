import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import 'ColorHelper.dart';

enum AppThemeStyle { personal, home, work }

class AppThemes {
  static final ThemeData personalTheme = ThemeData(
    primaryColor: hexToColor("#F77B67"),
    accentColor: Colors.white,
    // brightness: Brightness.light,
  );

  static final ThemeData homeTheme = ThemeData(
    primaryColor: hexToColor("#4EC5AC"),
    // brightness: Brightness.dark,
  );

  static final ThemeData workTheme = ThemeData(
    primaryColor: hexToColor("#5A89E6"),
    // brightness: Brightness.dark,
  );

  static ThemeData getThemeFromKey(AppThemeStyle themeKey) {
    switch (themeKey) {
      case AppThemeStyle.personal:
        return personalTheme;
      case AppThemeStyle.home:
        return homeTheme;
      case AppThemeStyle.work:
        return workTheme;
      default:
        return personalTheme;
    }
  }

  static String getStringWithStyle(AppThemeStyle style) {
    switch (style) {
      case AppThemeStyle.personal:
        return "Personal";
      case AppThemeStyle.work:
        return "Work";
      case AppThemeStyle.home:
        return "Home"; 
      default :
        return "Personal";
    }
  }

  static String getImageStrWithStyle(AppThemeStyle style) {
    var imageStr = "";
    switch (style) {
      case AppThemeStyle.personal:
        imageStr = "images/user.png";
        break;
      case AppThemeStyle.work:
        imageStr = "images/work.png";
        break;
      case AppThemeStyle.home:
        imageStr = "images/home.png";
    }

    return imageStr;
  }
}

class AppThemeBloc extends Bloc<AppThemeStyle, ThemeData> {
  @override
  ThemeData get initialState => AppThemes.personalTheme;

  @override
  Stream<ThemeData> mapEventToState(AppThemeStyle event) async* {
    yield AppThemes.getThemeFromKey(event);
  }
  
  
}
