import 'package:flutter/material.dart';
import 'package:goalkit/resources/navigation/bottom_navigation.dart';
import 'package:goalkit/views/home/home_page.dart';
import 'package:goalkit/views/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
