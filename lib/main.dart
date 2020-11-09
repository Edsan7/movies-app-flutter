import 'package:custom_splash/custom_splash.dart';
import 'package:flutter/material.dart';
import 'core/theme_app.dart';
import 'pages/movie_page.dart';

import 'core/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: kAppName,
      theme: themeApp,
      home: CustomSplash(
        backGroundColor: Colors.black54,
        imagePath: 'assets/icon/icon.png',
        animationEffect: 'fade-in',
        duration: 2500,
        home: MoviePage(),
      ),
    );
  }
}
