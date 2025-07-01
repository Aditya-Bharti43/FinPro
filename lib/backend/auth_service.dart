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

  Future<bool> checkIfEmailExists(String email) async {
  try {
    var methods =
        await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
    if (methods.isNotEmpty) {
      print("Email already exists.");
      return true;
    } else {
      print("Email is available.");
      return false;
    }
  } catch (e) {
    print("Error checking email: $e");
    return false;
  }
}
}
