// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  MessageModel({
    required this.message,
    required this.sender,
    required this.receiver,
    required this.id,
    this.timestamp,
  });

  final String message;
  final String sender;
  final String receiver;
  final String id;
  final DateTime? timestamp;

  @override
  String toString() =>
      'MessageModel(message: $message, id: $id, timestamp: $timestamp)';

  MessageModel copyWith({
    String? message,
    String? id,
    DateTime? timestamp,
    String? sender,
    String? receiver,
  }) {
    return MessageModel(
      message: message ?? this.message,
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'message': message,
      'id': id,
      'timestamp': FieldValue.serverTimestamp(),
      'sender': sender,
      'receiver': receiver,
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> map) {
    return MessageModel(
      message: (map['message'] ?? '') as String,
      id: (map['id'] ?? '') as String,
      timestamp: map['timestamp']?.toDate(),
      sender: (map['sender'] ?? '') as String,
      receiver: (map['receiver'] ?? '') as String,
    );
  }
}
