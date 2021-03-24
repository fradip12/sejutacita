import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:citav2/core/models/user/user.model.dart';
import 'package:citav2/core/services/api.dart';
import 'package:meta/meta.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  UserResults user;
  int page = 0;
  DataBloc() : super(DataUnintialized());

  @override
  Stream<DataState> mapEventToState(
    DataEvent event,
  ) async* {
    if (event is FetchData) {
      user = await Git.fetchUser(event.keywords, page, 10);
      user.items.map((e) => print(e.login));
      yield DataLoaded(user: user, hasReachedMax: false);
    }
    if (event is MoreData) {
      UserResults moreUser = await Git.fetchUser(event.keywords, page++, 10);
      DataLoaded data = state as DataLoaded;
      if (moreUser == null) {
        page--;
        data.copyWith(hasReachedMax: true);
      } else {
        user.items.addAll(moreUser.items);
        yield DataLoaded(user: user, hasReachedMax: false);
      }

      // DataLoaded userLoaded = state as DataLoaded;
      // user = await Git.fetchUser('flutter', page + 1, 10);
      // yield (user.items.isEmpty)
      //     ? userLoaded.copyWith(hasReachedMax: true)
      //     : DataLoaded(user: userLoaded.user, hasReachedMax: false);
    }
    if (event is ClearData) {
      user.items.clear();
      yield DataClear(message: 't');
    }
  }
}
