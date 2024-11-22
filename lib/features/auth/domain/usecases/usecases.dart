import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_new_template/core/feature/data/repositories/auth_repository.dart';

import '../../../../export.dart';

class AuthUseCase {
  final AuthRepository repository;

  AuthUseCase({required this.repository});

  Future<Either<Exception, User?>> login(String email, String password) async {
    return await repository.login(email, password);
  }

  Future<Either<Exception, User?>> signup(String email, String password) async {
    return await repository.signup(email, password);
  }

  Future<Either<Exception, void>> logout() async {
    return await repository.logout();
  }
}
