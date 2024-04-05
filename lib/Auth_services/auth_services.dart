import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // User DB architecture
  // Attandance-Record: ""
  // Direct-Messages: []
  // Email-ID: ""
  // Leave-Record: ""
  // Name: ""

  // Notifications: []
  // Workspace: [
  //  {
  //  "Name": "",
  //  "Role": "",
  //  "Workspace-ID": ""
  //  "last-visited": true,
  // }
  // ]
  // profile-file: ""

  Future<bool> userExist(String emailID) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(emailID)
        .get()
        .then((value) {
      if (value.exists) {
        return true;
      }
    });
    return false;
  }

  Future<String> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      FirebaseFirestore.instance.collection("Users").doc(user.email).set({
        "Name": user.displayName,
        "Email-ID": user.email,
        "UID": user.uid,
        "profilePic": user.photoURL,
        "Attandance-Record": "",
        "Direct-Messages": [],
        "Leave-Record": "",
        "Notifications": [],
        "Workspace": [],
      });
      return "SUCCESS";
    } catch (e) {
      return e.toString();
    }
  }

  //Google Sign in
  Future<String> signInWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account == null) {
        return "No Account Founded";
      }
      UserCredential result = await _auth.signInWithCredential(
          GoogleAuthProvider.credential(
              idToken: (await account.authentication).idToken,
              accessToken: (await account.authentication).accessToken));
      User user = result.user!;
      if (await userExist(user.email!)) {
        return "SUCCESS";
      } else {
        FirebaseFirestore.instance.collection("Users").doc(user.email).set({
          "Name": user.displayName,
          "Email-ID": user.email,
          "UID": user.uid,
          "profilePic": user.photoURL,
          "Attandance-Record": "",
          "Direct-Messages": [],
          "Leave-Record": "",
          "Notifications": [],
          "Workspace": [],
        });
      }
      return "SUCCESS";
    } catch (e) {
      return e.toString();
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      return user;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      // print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      // print(e.toString());
    }
  }

  Future getCurrentUser() async {
    try {
      var user = FirebaseFirestore.instance
          .collection("Users")
          .doc("5iAOiMSJWa7CZtXlkZ7y")
          .get()
          .asStream();
      return user;
    } catch (e) {
      // print(e.toString());
    }
  }
}
