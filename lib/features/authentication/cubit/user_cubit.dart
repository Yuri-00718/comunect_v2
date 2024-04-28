import 'package:comunect_v2/features/authentication/models/user.dart' as m_user;
import 'package:comunect_v2/features/authentication/repositories/user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserLoading());
  
  static final auth = FirebaseAuth.instance;
  static final userRepo = UserRepository();

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


  Future<void> createNewUser(String email, String password, String username) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email, 
        password: password,
      );
      await auth.signOut();
      await userRepo.insert(m_user.User(email: email, username: username));
      emit(UserIsCreated());
    } on FirebaseAuthException catch (e) {
      bool passwordIsWeak = false;
      bool emailAlreadyExists = false;
      bool invalidEmail = false;

      switch(e.code) {
        case 'weak-password':
          passwordIsWeak = true;
          break;
        case 'email-already-in-use':
          emailAlreadyExists = true;
          break;
        case 'invalid-email':
          invalidEmail = true;
      }

      emit(UserCredentialsNotValid(
        passwordIsWeak: passwordIsWeak, 
        emailAlreadyExists: emailAlreadyExists,
        invalidEmail: invalidEmail,
      ));
    } catch (e) {
      print(e);
    }
  }


  Future<void> signOutUser() async {
    await auth.signOut();
    emit(UserNotLoggedIn());
  }

  Future<void> signinUser(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      emit(AuthenticatedUser(user: credential.user as User));
    } on FirebaseAuthException catch (_) {
      emit(IncorrectUserCredential());
    }
  }
}
