import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserLoading());
  static final auth = FirebaseAuth.instance;

  Future<void> checkUserAuthenticationStatus() async {
    auth
      .authStateChanges()
      .listen((event) { 
        User? user = auth.currentUser;
        if (user == null) {
          emit(UserNotLoggedIn());
          return;
        }
        emit(AuthenticatedUser(user: user));
      });
  }
}
