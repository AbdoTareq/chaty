import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_new_template/core/feature/data/datasources/secure_local_data_source.dart';
import 'package:flutter_new_template/core/feature/data/repositories/auth_repository.dart';
import 'package:flutter_new_template/features/auth/domain/usecases/usecases.dart';
import 'package:flutter_new_template/features/auth/presentation/cubit.dart';
import 'package:flutter_new_template/features/auth/presentation/reset_pass_cubit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - posts
  // Bloc
  sl.registerFactory(() => AuthCubit(useCase: sl()));
  sl.registerFactory(() => ResetPassCubit(useCase: sl()));

  // Usecases
  sl.registerLazySingleton(() => AuthUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImp(remoteDataSource: sl(), localDataSource: sl()));

  // Datasources
  // sl.registerLazySingleton<RemoteDataSource>(
  //     () => RemoteDataSource(network: sl(), networkInfo: sl()));

  //! Core
  sl.registerLazySingleton(() => SecureLocalDataSourceImpl(box: sl()));

  //! External
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() => FirebaseAuth.instance);
}
