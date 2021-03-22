import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chooser_event.dart';
part 'chooser_state.dart';

class ChooserBloc extends Bloc<ChooserEvent, ChooserState> {
  ChooserBloc() : super(ChooserState());

  @override
  Stream<ChooserState> mapEventToState(
    ChooserEvent event,
  ) async* {
    if (event is Lazy)
      yield ChooserState(index: 0);
    else if (event is Index) yield ChooserState(index: 1);
    print('Log Button is : ${state.index == 0 ? 'Lazy' : 'Index'}');
    // yield (event is On ) ? ChooserState(true) : ChooserState(false);
  }
}
