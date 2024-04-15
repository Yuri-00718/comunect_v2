part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserLoading extends UserState {}

final class UserNotLoggedIn extends UserState {}

final class AuthenticatedUser extends UserState {
  final User user;

  AuthenticatedUser({required this.user});
}
