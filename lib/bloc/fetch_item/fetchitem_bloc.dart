import 'package:bloc/bloc.dart';
import 'package:citav2/core/models/item/item_model.dart';
import 'package:citav2/core/services/api.dart';
import 'package:equatable/equatable.dart';

part 'fetchitem_event.dart';
part 'fetchitem_state.dart';

class FetchItemBloc extends Bloc<FetchitemEvent, FetchitemState> {
  FetchItemBloc() : super(FetchitemInitial());

  @override
  Stream<FetchitemState> mapEventToState(
    FetchitemEvent event,
  ) async* {
    if (event is FetchDataHome) {
      final response = await Git.fetchData();
      print('data home from bloc');
      print(response);
      yield FetchitemLoaded(data: response);
    }
  }
}
