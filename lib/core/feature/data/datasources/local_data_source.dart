import '../../../../export.dart';

abstract class LocalDataSource {
  Future<dynamic> read(String key);
  Future<void> write(String key, Map<String, dynamic> value);
  Future<void> remove(String key);
  Future<bool> containsKey(String key);
}
