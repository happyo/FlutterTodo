
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/blocs/app_theme_bloc.dart';
import 'package:todo/blocs/home_bloc.dart';
import 'package:todo/pages/home_page.dart';
import 'package:todo/utils/app_theme.dart';

import 'database/task_bucket_db.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<AppThemeBloc>(
          create: (_) => AppThemeBloc(),
          dispose: (_, bloc) => bloc.dispose(),
        ),
        Provider<HomeBloc>(
          create: (_) { 
            final homeBloc = HomeBloc();
            TaskBucketDB().getDb().then((_) { 
              homeBloc.fetchBuckets();
              homeBloc.fetchUnfinishedTasksCount();
            });
            return homeBloc;
          },
          dispose: (_, bloc) => bloc.dispose(),
        ),
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeBloc = Provider.of<AppThemeBloc>(context);

    return StreamBuilder(
      stream: themeBloc.themeData,
      initialData: AppThemes.personalTheme,
      builder: (context, snapshot) {
        return MaterialApp(
          title: 'Flutter Todo',
          home: HomePage(),
          theme: snapshot.data,
        ); 
      },
    );
  }
}



