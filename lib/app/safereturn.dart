import 'package:flutter/material.dart';
import 'package:safereturn/config/config.dart';
import 'package:safereturn/screens/home_screen.dart';

class SafereturnApp extends StatelessWidget {
  const SafereturnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const HomeScreen(),
    );
  }
}