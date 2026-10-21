import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/components/my_drawer.dart';
import 'package:flutter_crud/components/my_list_tile.dart';
import 'package:flutter_crud/components/my_post_button.dart';
import 'package:flutter_crud/components/my_textfield.dart';
import 'package:flutter_crud/database/firestore.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  //acesso ao firestore
  final FirestoreDatabase database = FirestoreDatabase();

  //text controller
  final TextEditingController newPostContoller = TextEditingController();

  //postar menssagem
  void postMessage() {
    if (newPostContoller.text.isNotEmpty) {
      String message = newPostContoller.text;
       database.addPost(message);
    }
    newPostContoller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text("W A L L"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                //texfild
                Expanded(
                  child: MyTextfield(       
                    hintText: "Say something..", 
                    obscureText: false,
                    controller: newPostContoller,
                  ),
                ),

                //post button
                MyPostButton(
                  onTap: postMessage,
                ),
              ],
            ),
          ),

          // posts
          StreamBuilder(
            stream: database.getPostsStream(), 
            builder: (context, snapshot) {
              //circulo de carregamento
              if(snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              //buscar posts
              final posts = snapshot.data!.docs;

              //sem dados
              if(snapshot.data == null || posts.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Text("No posts.. Post something!"),
                  ),
                );
              }

              // retornar a lista de posts
              return Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    //get postagem individual
                    final post = posts[index];

                    //get dados de cada post
                    String message = post['PostMessage'];
                    String userEmail = post['UserEmail'];
                    Timestamp timestamp = post['TimeStamp'];

                    //retornar a lista de posts
                    return MyListTile(title: message, subTitle: userEmail);
                  },
                ),
              );

            }
          ),

        ],
      ),
    );
  }
}