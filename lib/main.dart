import 'package:flutter/material.dart';
import 'package:flutter_crud/auth/login_or_register.dart';
import 'package:flutter_crud/theme/dark_mode.dart';
import 'package:flutter_crud/theme/light_mode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginOrRegister(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
