part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {}

class RegisterErrorState extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {
  final LoginModel loginModel;

  LoginSuccessState({required this.loginModel});
}

class LoginErrorState extends AuthState {}

class LogoutLoadingState extends AuthState {}

class LogoutSuccessState extends AuthState {}

class LogoutErrorState extends AuthState {}
