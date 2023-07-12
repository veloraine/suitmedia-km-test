part of 'users_bloc.dart';

@immutable
abstract class UsersEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class UsersFetchDataEvent extends UsersEvent {
  final int page;
  final int perPage;
  UsersFetchDataEvent({required this.page, required this.perPage});

}

class UsersLoadMoreDataEvent extends UsersEvent {
}

class UsersRefreshDataEvent extends UsersEvent {}
