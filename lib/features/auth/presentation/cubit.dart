import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_new_template/features/auth/domain/usecases/usecases.dart';

import '../../../../../export.dart';

class AuthCubit extends Cubit<BaseState<User?>> {
  AuthCubit({
    required this.useCase,
  }) : super(const BaseState());
  final AuthUseCase useCase;

  Future login(String email, String password) async {
    final response = await useCase.login(email, password);
    return response.fold((l) {
      emit(state.copyWith(status: RxStatus.error, errorMessage: l.toString()));
    }, (r) {
      if (r == null) {
        emit(
            state.copyWith(status: RxStatus.error, errorMessage: r.toString()));
      } else
        emit(state.copyWith(status: RxStatus.success, data: r));
    });
  }

  Future signup(String email, String password) async {
    final response = await useCase.signup(email, password);
    return response.fold((l) {
      emit(state.copyWith(status: RxStatus.error, errorMessage: l.toString()));
    }, (r) {
      if (r == null) {
        emit(
            state.copyWith(status: RxStatus.error, errorMessage: r.toString()));
      } else
        emit(state.copyWith(status: RxStatus.success, data: r));
    });
  }

  logout() async {
    final response = await useCase.logout();
    return response.fold((l) {
      emit(state.copyWith(status: RxStatus.error, errorMessage: l.toString()));
    }, (r) {
      emit(state.copyWith(status: RxStatus.success));
    });
  }
}
