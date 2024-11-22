import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_new_template/core/feature/data/models/person_model.dart';
import 'package:flutter_new_template/core/feature/data/repositories/persons_repository.dart';

import '../../../../export.dart';

class PersonsUseCase {
  final PersonsRepository repository;

  PersonsUseCase({required this.repository});

  Future<Either<Object, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      getAll() async {
    return repository.getAll();
  }

  Future<Either<Object, Map<String, dynamic>?>> create(String email) async {
    return await repository
        .create(PersonModel.fromJson({'email': email, 'status': 'online'}));
  }

  Future<Either<Object, void>> updateStatus(
      PersonModel person, String? id) async {
    return await repository.updateStatus(person, id);
  }
}
