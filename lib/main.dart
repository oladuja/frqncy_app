import 'package:flutter/material.dart';
import 'package:frqncy_app/src/config/routes.dart';
import 'package:frqncy_app/src/config/theme.dart';
import 'package:frqncy_app/src/screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FRQNCY',
      theme: theme,
      routes: routes,
      home: SplashScreen(),
      // initialRoute: HomeScreen.routeName,
    );
  }
}
