import 'package:flutter/material.dart';
import 'package:safereturn/config/config.dart';
import 'package:safereturn/config/router/app_router.dart';

class SafereturnApp extends StatelessWidget {
  const SafereturnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: appRouter,
    );
  }
}
