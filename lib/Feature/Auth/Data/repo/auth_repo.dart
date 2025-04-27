import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepo {
  Future<UserCredential> signUp(
     String name,
     String email,
     password,
     );
  Future<UserCredential> login(
      {required String email, required String password});

  Future<void> signOut();
}
