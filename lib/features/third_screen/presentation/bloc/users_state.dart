part of 'users_bloc.dart';

@immutable
abstract class UsersState extends Equatable{
  @override
  List<Object?> get props => [];
}

class UsersInitialState extends UsersState {}

class UsersLoadingState extends UsersState {}

class UsersLoadedState extends UsersState {
  UsersLoadedState({required this.users, required this.isLimit, required this.page});
  final List<UserModel> users;
  final bool isLimit;
  final int page;

  @override
  List<Object?> get props => [users, isLimit];
}

class UsersErrorState extends UsersState {
  UsersErrorState(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}

class UsersEmptyState extends UsersState {}

