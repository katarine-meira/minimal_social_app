import 'package:flutter/material.dart';
import 'package:flutter_crud/pages/login_page.dart';
import 'package:flutter_crud/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const new({super.key});

  @override
  State<LoginOrRegister> createState() => LoginOrRegisterState();
}

class LoginOrRegisterState extends State<LoginOrRegister> {

  // show login page
  bool showLoginPage = true;

  //between login and register page
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }


  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglePages);
    } else {
      return RegisterPage(onTap: togglePages);
    }
  }
}