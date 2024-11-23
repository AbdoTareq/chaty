import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_new_template/core/feature/data/models/person_model.dart';
import 'package:flutter_new_template/features/home/domain/usecases/usecases.dart';

import '../../../../../export.dart';

class PersonsCubit extends Cubit<BaseState<List<PersonModel>>> {
  PersonsCubit({
    required this.useCase,
  }) : super(const BaseState());
  final PersonsUseCase useCase;

  Future<void> getAll() async {
    emit(state.copyWith(status: RxStatus.loading));
    final response = await useCase.getAll();
    response.fold((l) {
      emit(state.copyWith(status: RxStatus.error, errorMessage: l.toString()));
    }, (r) {
      r.listen((p) {
        var temp = <PersonModel>[];
        Logger().i(p.docs.length);
        for (var element in p.docs) {
          temp.add(PersonModel.fromJson({...element.data(), 'id': element.id}));
        }
        emit(state.copyWith(status: RxStatus.success, data: temp));
      });
    });
  }

  Future<void> updateStatus(String status) async {
    final response = await useCase.updateStatus(
      PersonModel(
          status: status, email: sl<FirebaseAuth>().currentUser?.email ?? ''),
      sl<FirebaseAuth>().currentUser?.email ?? '',
    );
    Logger().i(sl<FirebaseAuth>().currentUser?.email ?? '');
    response.fold((l) {}, (r) {});
  }
}
