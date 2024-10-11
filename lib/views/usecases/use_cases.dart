
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../core/resources/data_state.dart';
import '../../data/model/product_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../domain/UserRepository.dart';
import '../../domain/models/user.dart';
import '../../domain/product_repository.dart';

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

class FetchProductsUseCase {
  final ProductRepository repository;

  FetchProductsUseCase(this.repository);

  Future<DataState<List<Product>>> call() async {
    return await repository.fetchProducts();
  }
}

class SaveUserDataToDatabase {
  final UserRepository userRepository;

  SaveUserDataToDatabase(this.userRepository);

  @override
  Future<DataState<String>> call(String userId, String name, String email) async {
    return await userRepository.saveUser(userId, name, email);
  }
}


