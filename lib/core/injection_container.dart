import 'package:flutter_new_template/core/feature/data/datasources/secure_local_data_source.dart';
import 'package:flutter_new_template/export.dart';
import 'package:flutter_new_template/features/auth/domain/usecases/usecases.dart';
import 'package:flutter_new_template/features/auth/presentation/cubit.dart';
import 'package:flutter_new_template/features/auth/presentation/reset_pass_cubit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - posts
  // Bloc
  sl.registerFactory(() => AuthCubit(useCase: sl(), box: sl()));
  sl.registerFactory(() => ResetPassCubit(useCase: sl()));

  // Usecases
  sl.registerLazySingleton(() => AuthUseCase(repository: sl()));

  // Repository
  // sl.registerLazySingleton<Repository>(
  //     () => RepoImp(remoteDataSource: sl(), localDataSource: sl()));

  // // Datasources
  // sl.registerLazySingleton<RemoteDataSource>(
  //     () => RemoteDataSource(network: sl(), networkInfo: sl()));

  //! Core
  sl.registerLazySingleton(() => SecureLocalDataSourceImpl(box: sl()));
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(box: sl()));

  //! External
  sl.registerLazySingleton(() => GetStorage());
  sl.registerLazySingleton(() => const FlutterSecureStorage());

  sl.registerLazySingleton(() => InternetConnectionChecker());
}
