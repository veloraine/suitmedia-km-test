import 'dart:convert';

import 'package:km_test/core/client/http_call.dart';
import 'package:km_test/core/environments/endpoints.dart';

import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<Map<String, dynamic>> getUsers(int page, int perPage);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<Map<String, dynamic>> getUsers(int page, int perPage) async {
    const url = Endpoints.users;
    final params = {
      'page': page.toString(),
      'per_page': perPage.toString()
    };
    final response = await getData(url, params);
    if (response.statusCode == 200) {
      final datas = jsonDecode(response.body);
      List<UserModel> userList= List<UserModel>.from(datas['data'].map((x) => UserModel.fromJson(x)));
      final page = datas['page'];
      final totalPages = datas['total_pages'];

      return {
        'users': userList,
        'page': page,
        'totalPages': totalPages
      };
    } else {
      throw Exception('Failed to load users');
    }
  }
}