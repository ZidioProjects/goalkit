import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:goalkit/views/splash_screen.dart';
import 'package:provider/provider.dart';

import 'api/providers/app_providers.dart';


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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
