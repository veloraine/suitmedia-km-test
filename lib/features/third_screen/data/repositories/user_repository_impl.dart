import 'package:km_test/features/third_screen/domain/repositories/user_repository.dart';

import '../data_sources/user_remote_data_source.dart';
import '../models/user_model.dart';


class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _userRemoteDataSource;

  UserRepositoryImpl(this._userRemoteDataSource);

  @override
  Future<Map<String, dynamic>> getUsers(int page, int perPage) {
    return _userRemoteDataSource.getUsers(page, perPage);
  }
}