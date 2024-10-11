import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:panda_mart/data/repository/RemoteConfigRepositoryIml.dart';
import 'package:panda_mart/data/repository/user_repository_impl.dart';
import 'package:panda_mart/views/viewModels/auth_viewmodel.dart';
import 'package:panda_mart/views/viewModels/product_viewmodel.dart';
import 'package:panda_mart/views/viewModels/remote_config_viewmodel.dart';
import 'package:panda_mart/views/usecases/firebase_remote_config.dart';
import 'package:panda_mart/views/usecases/use_cases.dart';

import 'data/repository/auth_repository.dart';
import 'data/repository/product_repository_impl.dart';
import 'data/service/FirebaseRemoteConfigService.dart';
import 'data/service/firebase_auth_service.dart';
import 'data/service/product_service.dart';
import 'domain/UserRepository.dart';
import 'domain/product_repository.dart';
import 'domain/remote_config_repository/RemoteConfigRepository.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  sl.registerLazySingleton<FirebaseRemoteConfig>(() => FirebaseRemoteConfig.instance);


  // Register services
  sl.registerLazySingleton<AuthRepository>(() => FirebaseAuthService());
  sl.registerLazySingleton<ProductService>(() => ProductService(sl<Dio>()));
  sl.registerLazySingleton<FirebaseRemoteConfigService>(
        () => FirebaseRemoteConfigService(sl<FirebaseRemoteConfig>()),
  );

  //repository
  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(sl<ProductService>()));
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(sl<FirebaseFirestore>()),
  );
  sl.registerLazySingleton<RemoteConfigRepository>(
        () => RemoteConfigRepositoryImpl(sl<FirebaseRemoteConfigService>()),
  );


  // useCases
  sl.registerLazySingleton(() => LoginUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => SignupUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton<FetchProductsUseCase>(
      () => FetchProductsUseCase(sl<ProductRepository>()));
  sl.registerLazySingleton<FetchRemoteConfigUseCase>(
        () => FetchRemoteConfigUseCase(sl<RemoteConfigRepository>()),
  );

  // viewModels
  sl.registerFactory(
      () => AuthViewModel(sl<LoginUseCase>(), sl<SignupUseCase>()));
  sl.registerFactory(() => ProductViewModel(sl<FetchProductsUseCase>(), sl<FetchRemoteConfigUseCase>()));
  sl.registerFactory<RemoteConfigViewModel>(
        () => RemoteConfigViewModel(sl<FetchRemoteConfigUseCase>()),
  );
}
