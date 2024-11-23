import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_new_template/core/feature/data/models/message_model.dart';
import 'package:flutter_new_template/features/home/domain/usecases/chat_usecases.dart';

import '../../../../../export.dart';

class ChatCubit extends Cubit<BaseState<List<MessageModel>>> {
  ChatCubit({
    required this.useCase,
  }) : super(const BaseState());
  final ChatUsecases useCase;

  Future<void> getAll(String receiver) async {
    emit(state.copyWith(status: RxStatus.loading));
    final response = await useCase
        .getAll('${sl<FirebaseAuth>().currentUser?.email ?? ''}--$receiver');
    response.fold((l) {
      emit(state.copyWith(status: RxStatus.error, errorMessage: l.toString()));
    }, (r) {
      r.listen((p) {
        var temp = <MessageModel>[];
        Logger().i(p.docs.length);
        if (p.docs.isEmpty) {
          Logger().i('error');
          emit(state.copyWith(status: RxStatus.empty, data: temp));
          return;
        }
        for (var element in p.docs) {
          temp.add(
              MessageModel.fromJson({...element.data(), 'id': element.id}));
        }
        emit(state.copyWith(status: RxStatus.success, data: temp));
      });
    });
  }

  Future<void> sendMessage(String receiver, String message) async {
    final response = await useCase.create(
      MessageModel(
        sender: sl<FirebaseAuth>().currentUser?.email ?? '',
        receiver: receiver,
        message: message,
        id: DateTime.now().millisecondsSinceEpoch.toString(),
      ),
      '${sl<FirebaseAuth>().currentUser?.email ?? ''}--$receiver',
    );
    response.fold((l) {}, (r) {});
  }
}
