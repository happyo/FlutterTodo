import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:todo/utils/app_theme.dart';

class AppThemeBloc {
  final _themeStreamController = BehaviorSubject<AppThemeStyle>();

  Stream<ThemeData> get themeData => _themeStreamController.stream.map((style) => AppThemes.getThemeFromKey(style));

  Function(AppThemeStyle) get changeStyle => _themeStreamController.sink.add;

  dispose() {
    _themeStreamController.close();
  }
}