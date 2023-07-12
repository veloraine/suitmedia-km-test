import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:km_test/features/third_screen/data/data_sources/user_remote_data_source.dart';
import 'package:km_test/features/third_screen/data/repositories/user_repository_impl.dart';

import '../../data/models/user_model.dart';

part 'users_event.dart';

part 'users_state.dart';

@injectable
class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final _repository = UserRepositoryImpl(UserRemoteDataSourceImpl());

  UsersBloc() : super(UsersInitialState()) {
    on<UsersFetchDataEvent>(_fetchData);
    on<UsersRefreshDataEvent>(_refreshData);
    on<UsersLoadMoreDataEvent>(_loadMoreData);
  }

  Future<void> _fetchData(
    UsersFetchDataEvent event,
    Emitter<UsersState> emit,
  ) async {
    emit(UsersLoadingState());
    try {
      final datas = await _repository.getUsers(event.page, event.perPage);
      final users = datas['users'];
      final page = datas['page'];
      final totalPages = datas['totalPages'];
      if (users.isEmpty) {
        emit(UsersEmptyState());
      } else {
        emit(UsersLoadedState(
            users: users, isLimit: page == totalPages, page: page));
      }
    } on Exception catch (e) {
      emit(UsersErrorState(e.toString()));
    }
  }

  Future<void> _loadMoreData(
    UsersLoadMoreDataEvent event,
    Emitter<UsersState> emit,
  ) async {
    if (state is UsersLoadedState) {
      final currentState = state as UsersLoadedState;
      final currentPage = currentState.page;

      final datas = await _repository.getUsers(currentPage + 1, 10);
      final users = datas['users'];
      final page = datas['page'];
      final totalPages = datas['totalPages'];

      if (users.isEmpty) {
        emit(UsersEmptyState());
      } else {
        emit(UsersLoadedState(
          users: currentState.users + users,
          isLimit: page == totalPages,
          page: page,
        ));
      }
    }
  }

  Future<void> _refreshData(
    UsersRefreshDataEvent event,
    Emitter<UsersState> emit,
  ) async {
    emit(UsersLoadingState());
    try {
      final datas = await _repository.getUsers(1, 10);
      final users = datas['users'];
      final page = datas['page'];
      final totalPages = datas['totalPages'];
      if (users.isEmpty) {
        emit(UsersEmptyState());
      } else {
        emit(UsersLoadedState(
            users: users, isLimit: page == totalPages, page: page));
      }
    } on Exception catch (e) {
      emit(UsersErrorState(e.toString()));
    }
  }
}
