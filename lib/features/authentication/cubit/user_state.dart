part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserLoading extends UserState {}

final class UserNotLoggedIn extends UserState {}

final class AuthenticatedUser extends UserState {
  final User user;

  AuthenticatedUser({required this.user});
}

final class UserCredentialsNotValid extends UserState {
  final bool passwordIsWeak;
  final bool emailAlreadyExists;
  final bool invalidEmail;

  UserCredentialsNotValid({
    required this.passwordIsWeak,
    required this.emailAlreadyExists,
    required this.invalidEmail,
  }); 
}

final class UserIsCreated extends UserState {}