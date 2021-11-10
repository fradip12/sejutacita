part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class InitLoggin extends LoginEvent {
  InitLoggin();
}

class FetchLogin extends LoginEvent {
  final String username;
  final String password;
  FetchLogin({this.password, this.username});
}
