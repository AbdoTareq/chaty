import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_new_template/core/feature/data/datasources/secure_local_data_source.dart';
import 'package:flutter_new_template/core/feature/data/repositories/auth_repository.dart';
import 'package:flutter_new_template/core/feature/data/repositories/persons_repository.dart';
import 'package:flutter_new_template/export.dart';
import 'package:flutter_new_template/features/auth/domain/usecases/usecases.dart';
import 'package:flutter_new_template/features/auth/presentation/cubit.dart';
import 'package:flutter_new_template/features/home/domain/usecases/usecases.dart';
import 'package:flutter_new_template/features/home/presentation/chat/persons_cubit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - posts
  // Bloc
  sl.registerFactory(() => AuthCubit(useCase: sl()));
  sl.registerFactory(() => PersonsCubit(useCase: sl()));

  // Usecases
  sl.registerLazySingleton(() => AuthUseCase(repository: sl()));
  sl.registerLazySingleton(() => PersonsUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImp(remoteDataSource: sl(), localDataSource: sl()));
  sl.registerLazySingleton<PersonsRepository>(
      () => PersonsRepositoryImp(remoteDataSource: sl()));

  // Datasources
  sl.registerLazySingleton<LocalDataSource>(
      () => SecureLocalDataSourceImpl(box: sl()));

  //! External
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() => FirebaseAuth.instance);
}
