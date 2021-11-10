import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'fetchitem_event.dart';
part 'fetchitem_state.dart';

class FetchItemBloc extends Bloc<FetchitemEvent, FetchitemState> {
  FetchItemBloc() : super(FetchitemInitial());

  @override
  Stream<FetchitemState> mapEventToState(
    FetchitemEvent event,
  ) async* {}
}
