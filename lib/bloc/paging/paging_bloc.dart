import 'dart:async';

import 'package:bloc/bloc.dart';

part 'paging_event.dart';
part 'paging_state.dart';

class PagingBloc extends Bloc<PagingEvent, PagingState> {
  PagingBloc() : super(PagingState(1));

  @override
  Stream<PagingState> mapEventToState(
    PagingEvent event,
  ) async* {
    yield (event is Next)
        ? PagingState(state.index + 1)
        : (event is Back)
            ? state.index > 1
                ? PagingState(state.index - 1)
                : PagingState(1)
            : PagingState(1);
  }
}
