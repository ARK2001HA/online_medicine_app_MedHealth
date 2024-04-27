import 'package:flutter/material.dart';
import 'package:medical_app/pages/splash_screen.dart';
import 'package:medical_app/theme.dart';

void main() =>runApp(const MyApp());

class MyApp extends StatelessWidget
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: greenColor),
      home: SplashScreen(),

    );
  }
}