import 'package:bloc/bloc.dart';
import 'package:citav2/core/models/login/login_model.dart';
import 'package:citav2/core/services/api.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginResult user;
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is FetchLogin) {
      print('login block with ${event.username} and ${event.password}');
      user = await Git.login(pass: event.password, user: event.username);
      print('bloc event login');
      print(user);
      yield LoggedIn(user: user);
    }
  }
}
