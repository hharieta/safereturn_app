import 'package:safereturn/app/safereturn.dart';
import 'package:flutter/material.dart';
import 'package:safereturn/services/auth_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  AuthService().initializeAuth();
  runApp(const SafereturnApp());
}
