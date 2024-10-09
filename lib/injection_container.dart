import 'package:get_it/get_it.dart';
import 'package:panda_mart/viewmodel/auth_viewmodel.dart';
import 'package:panda_mart/views/usecases/use_cases.dart';

import 'data/repository/auth_repository.dart';
import 'data/service/firebase_auth_service.dart';


final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Register services
  sl.registerLazySingleton<AuthRepository>(() => FirebaseAuthService());

  // useCases
  sl.registerLazySingleton(() => LoginUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => SignupUseCase(sl<AuthRepository>()));

  // viewModels
  sl.registerFactory(() => AuthViewModel(sl<LoginUseCase>(), sl<SignupUseCase>()));
}
