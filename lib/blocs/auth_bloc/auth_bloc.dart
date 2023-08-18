import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_reminder_app/auth_service.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;

  AuthBloc(this._authService) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is SignUpEvent) {
        emit(AuthLoading());
        try {
          await _authService.registerWithEmailAndPassword(
            event.email,
            event.password,
          );
          emit(AuthSuccess());
        } catch (error) {
          emit(AuthInitial());
        }
      } else if (event is SignInEvent) {
        emit(AuthLoading());
        try {
          await _authService.signInWithEmailAndPassword(
            event.email,
            event.password,
          );
          emit(AuthSuccess());
        } catch (error) {
          emit(AuthInitial());
        }
      }
    });
  }
}
