import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/models/user.dart';
import '../repository/auth_repository.dart';

class FirebaseAuthService implements AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserEntity?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user != null) {
        return UserEntity(id: user.uid, email: user.email!, name: user.displayName ?? "Unknown");
      }
    } on FirebaseAuthException catch (e) {
      rethrow;
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
    return null;
  }

  @override
  Future<UserEntity?> signup(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user != null) {
        return UserEntity(id: user.uid, email: user.email!, name: user.displayName ?? "Unknown");
      }
    } catch (e) {
      throw e.toString();
    }
    return null;
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }



}
