import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //cabeçalho
              DrawerHeader(
                child: Icon(Icons.favorite, color: Theme.of(context).colorScheme.inversePrimary),
              ),
              const SizedBox(height: 25),

              //title home
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(Icons.home, color: Theme.of(context).colorScheme.inversePrimary),
                  title: Text(" H O M E", style: const TextStyle(fontWeight:FontWeight.bold),),
                  textColor: Theme.of(context).colorScheme.inversePrimary,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              //title perfil
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(Icons.person, color: Theme.of(context).colorScheme.inversePrimary),
                  title: Text(" P R O F I L E", style: const TextStyle(fontWeight:FontWeight.bold),),
                  textColor: Theme.of(context).colorScheme.inversePrimary,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/profile_page');
                  },
                ),
              ),

              //title user
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(Icons.group, color: Theme.of(context).colorScheme.inversePrimary),
                  title: Text(" U S E R S", style: const TextStyle(fontWeight:FontWeight.bold),),
                  textColor: Theme.of(context).colorScheme.inversePrimary,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/users_page');
                  },
                ),
              ),
            ],
          ),

          //title logout
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25),
            child: ListTile(
              leading: Icon(Icons.logout, color: Theme.of(context).colorScheme.inversePrimary),
              title: Text(" L O G O U T", style: const TextStyle(fontWeight:FontWeight.bold),),
              textColor: Theme.of(context).colorScheme.inversePrimary,
              onTap: () {
                Navigator.pop(context);
                //logout
                logout();
              },
            ),
          )
        ],
      ),
    );
  }
}