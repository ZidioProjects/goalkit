import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:goalkit/resources/navigation/bottom_navigation.dart';
import 'package:goalkit/views/home/home_page.dart';
import 'package:goalkit/views/home/new_goal.dart';
import 'package:goalkit/views/splash_screen.dart';
import 'package:provider/provider.dart';

import 'api/providers/app_providers.dart';
import 'views/settings_screen/change_password_screen.dart';


void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(
      MultiProvider(
        providers: appProviders,
        child: const MyApp(),
      )
  );
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
