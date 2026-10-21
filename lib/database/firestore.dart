
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//armazen postagens que o usuário fez
//armazena em uma collection chamada "Posts" no Firebase
// cada mensagem possui: a menssagem, email e a data/hora

class FirestoreDatabase {
  //usuário conextado
  final User? user = FirebaseAuth.instance.currentUser;

  // get collections de posts do firebase
  final CollectionReference posts = FirebaseFirestore.instance.collection('Posts');

  //post da menssagem
  Future<void> addPost(String message) {
    return posts.add({
      'UserEmail': user!.email,
      'PostMessage': message,
      'TimeStamp': Timestamp.now(),
    });
  }

  // read os posts
  Stream<QuerySnapshot> getPostsStream() {
    final postsStream = FirebaseFirestore.instance
      .collection('Posts')
      .orderBy('TimeStamp', descending: true)
      .snapshots();
    return postsStream;
  }

}