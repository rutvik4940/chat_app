import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthHelper {
  static AuthHelper helper = AuthHelper._();

  AuthHelper._();

  User? user;


  Future<String> signup(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await checkUser();
      return 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'weak-password';
      } else if (e.code == 'email-already-in-use') {
        return 'email-already-in-use';
      } else {
        return 'failed';
      }
    }
  }

  Future<String> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      checkUser();
      return 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'user-not-found';
      } else if (e.code == 'wrong-password') {
        return 'wrong-password';
      } else {
        return 'failed';
      }
    }
  }

  bool checkUser() {
    user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<String> gLoging() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    var credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      await checkUser();
      return "Success";
    }
    catch (e) {
      return "failed";
    }
  }

  Future<String> fbLogin() async {
    LoginResult loginResult = await FacebookAuth.instance.login();
    OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(
        loginResult.accessToken!.token);
    try {
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      return "Success";
    }
    catch (e) {
      return "failed";
    }
  }

  Future<String> guestSignIn() async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInAnonymously();
      return "Success";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          return "Anonymous auth hasn't been enabled for this project.";
        default:
          return "Error";
      }
    }
  }
}