import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riddle_me/modals/riddle_modal.dart';
import 'package:riddle_me/modals/user_modal.dart';

class FirebaseService {
  static Future<UserCredential?> createUserWithCred(
      String email, String password, String displayName) async {
    UserCredential credential;
    if (email.isEmpty || password.isEmpty || displayName.isEmpty) {
      throw "All fields are mandatory";
    }
    try {
      if (await doesNameAlreadyExist(displayName)) {
        throw "Display Name already exists";
      }
      credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        credential.user!.updateDisplayName(displayName);
      }
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        throw "Email already in use";
      } else if (e.code == 'invalid-email') {
        throw "Email Address is not Valid";
      }
    }
    return null;
  }

  static Future<void> logOutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  static addToDB(UserClass user) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await FirebaseFirestore.instance
          .collection('usersCollection')
          .doc(currentUser.uid)
          .set(user.toMap());
    }
  }

  static Future<bool> doesNameAlreadyExist(String name) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('usersCollection')
        .where('displayName', isEqualTo: name)
        .limit(1)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    return documents.length == 1;
  }

  static updateLastLogin() async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await FirebaseFirestore.instance
          .collection('usersCollection')
          .doc(currentUser.uid)
          .update({"lastLogin": DateTime.now()}).catchError((e) => print(e));
    }
  }

  static insertToSearch(String searchTerm) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await FirebaseFirestore.instance
          .collection('usageData')
          .doc("allSearches")
          .update({
        "searches": FieldValue.arrayUnion([
          {"term": searchTerm, "user": currentUser.uid}
        ])
      });
    }
  }

  static addFeedback(String feedBack) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await FirebaseFirestore.instance
          .collection('usageData')
          .doc("feedback")
          .update({
        "feedback": FieldValue.arrayUnion([
          {"text": feedBack, "user": currentUser.uid, "date": DateTime.now()}
        ])
      });
    }
  }

  static Future<DailyQuestion?> getDailyQuestion() async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      var dailyRiddle = await FirebaseFirestore.instance
          .collection('riddles')
          .doc("daily_riddle")
          .get();
      DailyQuestion daily = DailyQuestion.fromMap(dailyRiddle.data()!);
      return daily;
    }
    return null;
  }

  static Future<UserClass?> getUserbyId(String uid) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      var user = await FirebaseFirestore.instance
          .collection('usersCollection')
          .doc(uid)
          .get();
      UserClass userClass = UserClass.fromMap(user.data()!);
      return userClass;
    }
    return null;
  }

  static Future<UserCredential?> loginWithCred(
      String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw "Wrong Email or Password";
      } else if (e.code == 'wrong-password') {
        throw "Wrong Email or Password";
      } else if (e.code == 'invalid-email') {
        throw "Email Address is not Valid";
      }
    }
    return null;
  }

  static Future<UserCredential?> signInWithGoogle() async {
    try {
      print("Connctinh with Google");

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
              scopes: ['email'],
              clientId:
                  "921203505862-60nn97psoq7son729gjihemgirc3i797.apps.googleusercontent.com")
          .signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      print(credential.idToken);
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e);

      return null;
    }
  }

  static isUserLoggedIn() {
    return FirebaseAuth.instance.currentUser == null ? false : true;
  }
}
