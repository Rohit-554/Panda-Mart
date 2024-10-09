
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../core/resources/data_state.dart';
import '../../data/repository/auth_repository.dart';
import '../../models/user.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<DataState<UserEntity>> execute(String email, String password) async {
    try {
      final user = await _authRepository.login(email, password);
      if (user != null) {
        return DataSuccess(user);
      } else {
        return DataFailed(DioException(requestOptions: RequestOptions(path: ''), error: 'User not found'));
      }
    }
    catch (e) {
      return DataFailed(e);
    }
  }
}

class SignupUseCase {
  final AuthRepository _authRepository;

  SignupUseCase(this._authRepository);

  Future<DataState<UserEntity>> execute(String email, String password) async {
    try {
      final user = await _authRepository.signup(email, password);
      if (user != null) {
        return DataSuccess(user);
      } else {
        return DataFailed(DioException(requestOptions: RequestOptions(path: ''), error: 'Signup failed'));
      }
    } catch (e) {
      return DataFailed(e);
    }
  }
}
