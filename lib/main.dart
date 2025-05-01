import 'package:flutter/material.dart';
import 'package:frqncy_app/src/config/routes.dart';
import 'package:frqncy_app/src/config/theme.dart';
import 'package:frqncy_app/src/screens/splash.dart';

void main() => runApp(const MyApp());

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
