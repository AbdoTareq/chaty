import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_new_template/core/feature/data/models/person_model.dart';

abstract class PersonsRepository {
  Future<Either<Object, Stream<QuerySnapshot<Map<String, dynamic>>>>> getAll();
  Future<Either<Object, Map<String, dynamic>?>> create(PersonModel person);
  Future<Either<Object, void>> updateStatus(PersonModel person, String? id);
}

class PersonsRepositoryImp implements PersonsRepository {
  final FirebaseFirestore remoteDataSource;

  PersonsRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Object, Map<String, dynamic>?>> create(
      PersonModel person) async {
    try {
      final res =
          await remoteDataSource.collection('persons').add(person.toJson());
      return right((await res.get()).data());
    } catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Object, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      getAll() async {
    try {
      final snapshots = remoteDataSource.collection('persons').snapshots();
      return right(snapshots);
    } catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Object, void>> updateStatus(
      PersonModel person, String? id) async {
    try {
      final res = await remoteDataSource
          .collection('persons')
          .doc(id)
          .update(person.toJson());
      return right(res);
    } catch (e) {
      return left(e);
    }
  }
}
