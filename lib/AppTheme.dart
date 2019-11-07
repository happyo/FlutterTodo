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
}

class AppBloc extends Bloc<AppThemeStyle, ThemeData> {
  @override
  ThemeData get initialState => AppThemes.personalTheme;

  @override
  Stream<ThemeData> mapEventToState(AppThemeStyle event) async* {
    yield AppThemes.getThemeFromKey(event);
  }
  
}
