import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign Up Function
  Future<UserCredential?> signUp(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // Optionally, send email verification:
      // await userCredential.user?.sendEmailVerification();
      return userCredential;
    } catch (e) {
      print("Sign Up Error: $e");
      return null;
    }
  }

  // Login Function
  Future<UserCredential?> login(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } catch (e) {
      print("Login Error: $e");
      return null;
    }
  }
}
