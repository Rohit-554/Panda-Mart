import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/resources/data_state.dart';
import '../../domain/models/user.dart';
import '../usecases/use_cases.dart';

class AuthViewModel extends ChangeNotifier {
  final LoginUseCase _loginUseCase;
  final SignupUseCase _signupUseCase;

  AuthViewModel(this._loginUseCase, this._signupUseCase);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isSuccess = false;
  bool get isSuccess => _isSuccess;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserEntity?> login(String email, String password, BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _loginUseCase.execute(email, password);

    if (result is DataSuccess) {
      _isSuccess = true;
      _isLoading = false;
      await _addUserData(result.data!);
      notifyListeners();
      return result.data;
    } else if (result is DataFailed) {
      _isLoading = false;
      _errorMessage = result.error.toString();
      if(result.error is FirebaseAuthException) {
        _errorMessage = (result.error as FirebaseAuthException).message;
      }else{
        _errorMessage = result.error.toString();
      }
    }
    _isLoading = false;
    notifyListeners();
    return null;
  }

  Future<UserEntity?> register(String email, String password, BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _signupUseCase.execute(email, password);

    if (result is DataSuccess) {
      _isSuccess = true;
      _isLoading = false;
      notifyListeners();
      await _addUserData(result.data!);
      return result.data;
    } else if (result is DataFailed) {
      _isLoading = false;
      _errorMessage = result.error.toString();
      if(result.error is FirebaseAuthException) {
        _errorMessage = (result.error as FirebaseAuthException).message;
      }else{
        _errorMessage = result.error.toString();
      }
    }
    _isLoading = false;
    notifyListeners();
    return null;
  }

  void setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<void> _addUserData(UserEntity user) async {
    final docRef = _firestore.collection('users').doc(user.id);
    final docSnapshot = await docRef.get();

    if (!docSnapshot.exists) {
      await docRef.set({
        'id' : user.id,
        'name': user.name ?? 'Unknown',
        'email': user.email,
      });
    }
    }
}
