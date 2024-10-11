import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../core/resources/data_state.dart';
import '../usecases/use_cases.dart';

class UserViewModel with ChangeNotifier {
  final SaveUserDataToDatabase saveUserDataToDatabase;

  UserViewModel(this.saveUserDataToDatabase);

  DataState<String>? _result;

  DataState<String>? get dataState => _result;

  Future<void> saveUser(String userId, String name, String email) async {
    _result = null;
    notifyListeners();

    final result = await saveUserDataToDatabase(userId, name, email);
    _result = result;
    notifyListeners();
  }
}
