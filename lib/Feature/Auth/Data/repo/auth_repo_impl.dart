
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  @override
  Future<UserCredential> signUp(
      String name, String email, password, ) async {
    final userCredential =
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password!,
    );



    if (userCredential != null) {

      try {
        await FirebaseFirestore.instance.collection("Users").doc("${email}").set({
          "UserName": "$name",
          "UserEmail": "$email",
          "UserPassword": "$password",
        });
      } on Exception catch (e) {
        print("ERROR : ${e.toString()}");
      }
      await userCredential.user?.sendEmailVerification();
    }
    return userCredential;
  }

  @override
  Future<UserCredential> login(
      {required String email, required String password}) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential;
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
