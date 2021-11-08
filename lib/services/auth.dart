import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return result;
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUp(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return result;
    } catch (e) {
      print(e.toString());
    }
  }

  Future logOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
