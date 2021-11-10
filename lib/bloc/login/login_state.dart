part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoggedIn extends LoginState {
  final LoginResult user;

  LoggedIn({this.user});

  LoggedIn copyWith({LoginResult user}) {
    return LoggedIn(
      user: user ?? this.user,
    );
  }
}
