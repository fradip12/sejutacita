import 'package:bloc/bloc.dart';
import 'package:citav2/core/models/login/login_model.dart';
import 'package:citav2/core/services/api.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginResult user;
  LoginBloc() : super(InitialLoggedIn());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is InitLoggin) {
      yield NotLoggedIn();
    }
    if (event is FetchLogin) {
      user = await Git.login(pass: event.password, user: event.username);

      yield LoggedIn(user: user);
    }
  }
}
