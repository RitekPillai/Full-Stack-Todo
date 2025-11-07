import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:fullstacktodo/Modules/Authentication/data/Model/UserResponseDTO.dart';
import 'package:fullstacktodo/Modules/Authentication/data/Model/user.dart';
import 'package:fullstacktodo/Modules/Authentication/data/repo/authRepo.dart';
import 'package:fullstacktodo/Modules/Authentication/model_View/Services/AuthenticatedClientService.dart';
import 'package:fullstacktodo/utils/authException.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Authrepo _authrepo;
  final AuthenticatedClientService _authenticatedClientService;
  AuthBloc(this._authrepo, this._authenticatedClientService)
    : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<AuthAppStarted>(_onAppStarted);
    on<AuthTokenRequest>(_onTokenExpired);
    on<AuthAppLoginRequest>(_onLoginRequested);
    on<AuthAppSignUpRequest>(_onSignUpRequest);
  }

  Future<void> _onAppStarted(
    AuthAppStarted event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final hasToken = await _authenticatedClientService.hasToken();
      if (hasToken) {
        Userresponsedto user = await _authrepo.getAuthenticatedUser();
        emit(Authauthenticated(user: user));
      }
    } catch (e) {
      debugPrint(e.toString());
      if (e is AuthException) {
        emit(AuthUnauthenticated(authException: e));
      } else {
        emit(
          AuthUnauthenticated(
            authException: AuthException(
              StatusCode: "",
              errorMessage: e.toString(),
              timeStamp: DateTime.now().toString(),
            ),
          ),
        );
      }
    }
  }

  Future<void> _onLoginRequested(
    AuthAppLoginRequest event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthenticationLoading());
    try {
      User user = User(
        password: event.password,
        email: event.email,
        username: event.username,
      );
      final Userresponsedto tokenmodel = await _authrepo.login(user);

      emit(Authauthenticated(user: tokenmodel));
    } catch (e) {
      debugPrint(e.toString());
      if (e is AuthException) {
        emit(AuthUnauthenticated(authException: e));
      } else {
        emit(
          AuthUnauthenticated(
            authException: AuthException(
              StatusCode: "",
              errorMessage: e.toString(),
              timeStamp: DateTime.now().toString(),
            ),
          ),
        );
      }
    }
  }

  Future<void> _onTokenExpired(
    AuthTokenRequest event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthenticationLoading());

    try {
      await _authenticatedClientService.tokenRequest();

      Userresponsedto user = await _authrepo.getAuthenticatedUser();

      emit(Authauthenticated(user: user));
    } catch (e) {
      await _authrepo.logout();

      debugPrint(
        "Token refresh failed. Logging out user. Error: ${e.toString()}",
      );

      if (e is AuthException) {
        emit(AuthUnauthenticated(authException: e));
      } else {
        emit(
          AuthUnauthenticated(
            authException: AuthException(
              StatusCode: "",
              errorMessage:
                  "Session expired or invalid refresh token. Please login.",
              timeStamp: DateTime.now().toString(),
            ),
          ),
        );
      }
    }
  }

  // Ensure you use the updated method signature in the constructor:
  // on<AuthTokenRequest>(_onTokenExpired);

  Future<void> _onSignUpRequest(
    AuthAppSignUpRequest event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthenticationLoading());
    try {
      User userCrential = User(
        password: event.password,
        email: event.email,
        username: event.username,
      );

      await _authrepo.SignUp(userCrential);
      emit(
        AuthSignUpSucess(), // it indicates signUp is done next step is to login in
      );
    } catch (e) {
      debugPrint(e.toString());
      if (e is AuthException) {
        emit(AuthUnauthenticated(authException: e));
      } else {
        emit(
          AuthUnauthenticated(
            authException: AuthException(
              StatusCode: "",
              errorMessage: e.toString(),
              timeStamp: DateTime.now().toString(),
            ),
          ),
        );
      }
    }
  }

  @override
  void onChange(Change<AuthState> change) {
    // TODO: implement onChange
    debugPrint(change.currentState.toString());
    debugPrint(change.nextState.toString());
    super.onChange(change);
  }
}
