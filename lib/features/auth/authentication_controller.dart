import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationController {
  final String _email;
  final String _password;
  final String? _name;
  final String? _confirmPassword;

  AuthenticationController(
    this._email,
    this._password,
    this._name,
    this._confirmPassword,
  );

  Future<void> signUp() async {
    try {
      try {
        if (_password == _confirmPassword) {
          final user = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                email: _email,
                password: _password,
              );

          if (user.user != null) {
            FirebaseFirestore.instance.collection("users").add({
              "user_id": user.user?.uid,
              "name": _name,
              "created_at": DateTime.now(),
            });
          }
        } else {
          throw new Exception("the password was incorrect");
        }
      } on FirebaseAuthException catch (e) {
        print(e);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> login() async {
    try {

      await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);

    } on FirebaseAuthException catch(e){
      print(e);
    }
  }
}
