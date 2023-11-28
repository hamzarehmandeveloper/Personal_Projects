import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminRepo{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  late String currentUser= auth.currentUser!.uid;

  Future<User?> adminSignIn(
      String email, String password) async {
    try {
      final UserCredential userCredential =
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Login Error: $e');
      return null;
    }
  }

  Future<void> adminSignOut() async {
    await auth.signOut();
  }
}