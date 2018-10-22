import 'package:flutter/material.dart';
import 'package:gymapp/pages/home.dart';
import 'package:gymapp/app/theme.dart';

class GymApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gym App',
      theme: ThemeData(
        brightness: Brightness.dark,
        backgroundColor: AppTheme.backgroundColor,
        scaffoldBackgroundColor: AppTheme.backgroundColor,
        bottomAppBarColor: AppTheme.primaryColor,
        primaryColor: AppTheme.primaryColor,
        accentColor: AppTheme.accentColor,
        cardColor: AppTheme.primaryColor,
      ),
      home: HomeScreen(),
    );
  }
}
