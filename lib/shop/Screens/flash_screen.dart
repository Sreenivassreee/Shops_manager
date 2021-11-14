import 'package:flutter/material.dart';
import 'package:shops_manager/export.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class FlastScreen extends StatelessWidget {
  const FlastScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget example1 = SplashScreenView(
      navigateRoute: Homepage(),
      duration: 5000,
      imageSize: 130,
      imageSrc: "image.png",
      text: "Splash Screen",
    );

    return Scaffold(
      body: example1,
    );
  }
}