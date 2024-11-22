import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_new_template/export.dart';

abstract class AuthRepository {
  Future<Either<Exception, User?>> login(String email, String password);
  Future<Either<Exception, User?>> signup(String email, String password);
  Future<Either<Exception, void>> logout();
}

class AuthRepositoryImp implements AuthRepository {
  final FirebaseAuth remoteDataSource;
  final LocalDataSource localDataSource;

  AuthRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Exception, User?>> login(String email, String password) async {
    try {
      UserCredential userCredential =
          await remoteDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await localDataSource.write(
        kUser,
        {
          'uid': userCredential.user!.uid,
          'email': userCredential.user!.email,
          'displayName': userCredential.user!.displayName
        },
      );
      return Right(userCredential.user);
    } on FirebaseAuthException catch (e) {
      // Handle exceptions as necessary
      // logger.i(e);
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, User?>> signup(String email, String password) async {
    try {
      UserCredential userCredential =
          await remoteDataSource.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await localDataSource.write(
        kUser,
        {
          'uid': userCredential.user!.uid,
          'email': userCredential.user!.email,
          'displayName': userCredential.user!.displayName
        },
      );
      return Right(userCredential.user);
    } on FirebaseAuthException catch (e) {
      // Handle exceptions as necessary
      // logger.i(e);
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, void>> logout() async {
    try {
      await localDataSource.remove(kUser);
      return Right(await remoteDataSource.signOut());
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
