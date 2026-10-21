import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/components/my_back_button.dart';
import 'package:flutter_crud/components/my_list_tile.dart';
import 'package:flutter_crud/helper/helper_functions.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            displayMessageToUser("Somenthing went wrong", context);
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data == null) {
            return const Text("No data");
          }

          final users = snapshot.data!.docs;

          return Column(
            children: [
              //botão de voltar
              const Padding(
                padding: EdgeInsets.only(
                  top: 50.0,
                  left: 25,
                ),
                child: Row(
                  children: [
                    MyBackButton(),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              //lista de usuários
              Expanded(
                child: ListView.builder(
                  itemCount:  users.length,
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    final user = users[index];
                    
                    String username = user['username'];
                    String email = user['email'];
                    return MyListTile(title: username, subTitle: email);
                  },
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}