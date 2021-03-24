import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'radio_event.dart';
part 'radio_state.dart';

class RadioBloc extends Bloc<RadioEvent, RadioState> {
  RadioBloc() : super(RadioState(index: 0, keywords: 'repositories'));

  @override
  Stream<RadioState> mapEventToState(
    RadioEvent event,
  ) async* {
    if (event is RepoEvent)
      yield RadioState(index: 0, keywords: 'repositories');
    else if (event is IssueEvent)
      yield RadioState(index: 1, keywords: 'issue');
    else
      yield RadioState(index: 2, keywords: 'users');
  }
}
