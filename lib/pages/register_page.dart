import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/components/my_button.dart';
import 'package:flutter_crud/components/my_textfield.dart';
import 'package:flutter_crud/helper/helper_functions.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //controlador de edição de texto
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPwController = TextEditingController();

  //register method
  void registerUser() async {
    //circulo de carregamento
    showDialog(
      context: context, 
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    //verificar se as senhas correspondem
    if (passwordController.text != confirmPwController.text) {
      //abrir circulo de carregamento
      Navigator.pop(context);
      //mostrar erro
      displayMessageToUser("Passwords don't match!", context);
    }
    else {
      try {
        //criar o user
        UserCredential? userCredential = 
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, 
            password: passwordController.text
          );
        
        //criar um user e adicionar ao firestore
        createUserDocument(userCredential);

        if (!mounted) return;
        Navigator.pop(context);
      }on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        displayMessageToUser(e.code, context);
      }
    }
  }

  //metodo de criar usuário
  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
        .collection("Users")
        .doc(userCredential.user!.email)
        .set({
          'email': userCredential.user!.email,
          'username': usernameController.text,
        });
    }
  }

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
                controller: confirmPwController,
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
              MyButton(text: "Register", onTap: registerUser),

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
                    onTap: widget.onTap,
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