import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/resources/data_state.dart';
import '../../domain/UserRepository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore _firestore;

  UserRepositoryImpl(this._firestore);

  @override
  Future<DataState<String>> saveUser(String userId, String name, String email) async {
    try {
      await _firestore.collection('users').doc(userId).set({
        'name': name,
        'email': email,
      });
      return const DataSuccess<String>('User saved successfully!'); // Return success message
    } catch (error) {
      return DataFailed<String>(error.toString()); // Return error message
    }
  }
}
