import '../../data/models/user_model.dart';

abstract class UserRepository {
  Future<Map<String, dynamic>> getUsers(int page, int perPage);
}