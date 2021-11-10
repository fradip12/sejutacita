part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoggedIn extends LoginState {
  final LoginResult user;

  LoggedIn({this.user});
}

class NotLoggedIn extends LoginState {}

class InitialLoggedIn extends LoginState {}
