import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_new_template/core/feature/data/models/message_model.dart';
import 'package:flutter_new_template/core/feature/data/repositories/chat_repository.dart';

import '../../../../export.dart';

class ChatUsecases {
  final ChatRepository repository;

  ChatUsecases({required this.repository});

  Future<Either<Object, Stream<QuerySnapshot<Map<String, dynamic>>>>> getAll(
      String chatId) async {
    return repository.getAll(chatId);
  }

  Future<Either<Object, void>> create(
      MessageModel message, String chatId) async {
    return await repository.create(message, chatId);
  }
}
