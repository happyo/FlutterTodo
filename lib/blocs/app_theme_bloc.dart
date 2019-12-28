import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo/utils/app_theme.dart';

class AppThemeBloc extends Bloc<AppThemeStyle, ThemeData> {
  @override
  ThemeData get initialState => AppThemes.personalTheme;

  @override
  Stream<ThemeData> mapEventToState(AppThemeStyle event) async* {
    yield AppThemes.getThemeFromKey(event);
  }
}