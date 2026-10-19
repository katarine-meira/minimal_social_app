import 'package:flutter/material.dart';
import 'package:flutter_crud/components/my_button.dart';
import 'package:flutter_crud/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  //controlador de edição de texto
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPwControler = TextEditingController();

  //register method
  void register() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
          
              const SizedBox(height: 25),
          
              //app name
              Text(
                'M I N I M A L',
                style: TextStyle(fontSize: 20),
              ),
          
              const SizedBox(height: 50),
          
              // username textfield
              MyTextfield(
                hintText: 'Username',
                obscureText: false,
                controller: usernameController,
              ),

              const SizedBox(height: 10),
          
              // email textfield
              MyTextfield(
                hintText: 'Email',
                obscureText: false,
                controller: emailController,
              ),

              const SizedBox(height: 10),

              MyTextfield(
                hintText: 'Password',
                obscureText: true,
                controller: passwordController,
              ),

              const SizedBox(height: 10),

              MyTextfield(
                hintText: 'Confirm Password',
                obscureText: true,
                controller: confirmPwControler,
              ),

              const SizedBox(height: 10),

              //recuperar senha
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              //register in button
              MyButton(text: "Register", onTap: register),

              const SizedBox(height: 25),

              //dont have an account? register here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary
                    ),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(" Login here",
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ],
              )
              

            ]
          )
        )
      )
    );
  }
}