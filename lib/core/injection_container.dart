import 'package:dio/dio.dart';
import 'package:flutter_new_template/core/feature/data/datasources/secure_local_data_source.dart';
import 'package:flutter_new_template/core/feature/data/repositories/repository_imp.dart';
import 'package:flutter_new_template/core/feature/domain/repositories/repositories.dart';
import 'package:flutter_new_template/core/network/network.dart';
import 'package:flutter_new_template/export.dart';
import 'package:flutter_new_template/features/auth/domain/usecases/usecases.dart';
import 'package:flutter_new_template/features/auth/presentation/cubit.dart';
import 'package:flutter_new_template/features/auth/presentation/reset_pass_cubit.dart';
import 'package:flutter_new_template/features/post/domain/usecases/post.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:requests_inspector/requests_inspector.dart';

import '../features/post/data/datasources/post_local_data_source.dart';
import '../features/post/data/repositories/post_repository_impl.dart';
import '../features/post/domain/repositories/posts_repository.dart';
import '../features/post/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import '../features/post/presentation/bloc/posts/posts_bloc.dart';
import 'network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - posts
  // Bloc
  sl.registerFactory(() => PostsBloc(postUseCases: sl()));
  sl.registerFactory(() => AddDeleteUpdatePostBloc(postUseCases: sl()));
  sl.registerFactory(() => AuthCubit(useCase: sl(), box: sl()));
  sl.registerFactory(() => ResetPassCubit(useCase: sl()));

  // Usecases
  sl.registerLazySingleton(() => PostUsecases(sl()));
  sl.registerLazySingleton(() => AuthUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<PostsRepository>(
      () => PostsRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()));
  sl.registerLazySingleton<Repository>(
      () => RepoImp(remoteDataSource: sl(), localDataSource: sl()));

  // Datasources
  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSource(network: sl(), networkInfo: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImpl(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<Network>(() => Network(dio: sl(), box: sl()));
  sl.registerLazySingleton(() => SecureLocalDataSourceImpl(box: sl()));
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(box: sl()));

  //! External
  sl.registerLazySingleton(() => GetStorage());
  sl.registerLazySingleton(() => const FlutterSecureStorage());

  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 1000),
      receiveTimeout: const Duration(seconds: 1000),
      validateStatus: (_) => true))
    ..interceptors.add(RequestsInspectorInterceptor()));
}
