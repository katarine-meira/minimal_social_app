import 'package:flutter/material.dart';

//exibir messagem de erro
void displayMessageToUser(String message, BuildContext context) {
  showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      title: Text(message),
    ),
  );
}