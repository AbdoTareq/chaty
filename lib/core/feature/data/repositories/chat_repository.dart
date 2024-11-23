import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_new_template/core/feature/data/models/message_model.dart';

abstract class ChatRepository {
  Future<Either<Object, Stream<QuerySnapshot<Map<String, dynamic>>>>> getAll(
      String chatId);
  Future<Either<Object, void>> create(MessageModel message, String chatId);
}

class ChatRepositoryImp implements ChatRepository {
  final FirebaseFirestore remoteDataSource;

  ChatRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Object, void>> create(
      MessageModel message, String chatId) async {
    try {
      final messageRef = remoteDataSource
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .doc();
      return right(await messageRef.set(message.toJson()));
    } catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Object, Stream<QuerySnapshot<Map<String, dynamic>>>>> getAll(
      String chatId) async {
    try {
      final snapshots = remoteDataSource
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .orderBy('timestamp', descending: false)
          .snapshots();
      return right(snapshots);
    } catch (e) {
      return left(e);
    }
  }
}
