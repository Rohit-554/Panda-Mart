import 'package:panda_mart/core/resources/data_state.dart';

abstract class UserRepository {
  Future<DataState<String>> saveUser(String userId, String name, String email);
}