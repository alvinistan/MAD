// import 'package:firebase_auth/firebase_auth.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // Sign up
//   Future<User?> signUp(String email, String password) async {
//     try {
//       UserCredential userCred = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCred.user;
//     } on FirebaseAuthException catch (e) {
//       print("Signup Error: ${e.code} - ${e.message}");
//       return null;
//     } catch (e) {
//       print("Other Signup Error: $e");
//       return null;
//     }
//   }

//   // Login
//   Future<User?> login(String email, String password) async {
//     try {
//       UserCredential userCred = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCred.user;
//     } on FirebaseAuthException catch (e) {
//       print("Login Error: ${e.code} - ${e.message}");
//       return null;
//     } catch (e) {
//       print("Other Login Error: $e");
//       return null;
//     }
//   }

//   // Logout
//   Future<void> logout() async {
//     await _auth.signOut();
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign up
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCred.user;
    } on FirebaseAuthException catch (e) {
      print("Signup Error: ${e.code} - ${e.message}");
      return null;
    } catch (e) {
      print("Other Signup Error: $e");
      return null;
    }
  }

  // Login
  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCred.user;
    } on FirebaseAuthException catch (e) {
      print("Login Error: ${e.code} - ${e.message}");
      return null;
    } catch (e) {
      print("Other Login Error: $e");
      return null;
    }
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }
}
