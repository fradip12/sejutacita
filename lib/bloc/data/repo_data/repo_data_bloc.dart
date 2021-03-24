import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:citav2/core/models/repo/repo_model.dart';
import 'package:citav2/core/services/api.dart';
import 'package:meta/meta.dart';

part 'repo_data_event.dart';
part 'repo_data_state.dart';

class RepoDataBloc extends Bloc<RepoDataEvent, RepoDataState> {
  RepoResults repo;
  int page = 0;
  RepoDataBloc() : super(RepoDataUnintialized());

  @override
  Stream<RepoDataState> mapEventToState(
    RepoDataEvent event,
  ) async* {
    if (event is FetchRepo) {
      repo = await Git.fetchRepo(event.keywords, page, 10);
      repo.item.map((e) => print(e.name));
      yield RepoDataLoaded(repo: repo, hasReachedMax: false);
    }
    if (event is MoreRepo) {
      RepoResults moreUser = await Git.fetchRepo(event.keywords, page++, 10);
      RepoDataLoaded data = state as RepoDataLoaded;
      if (moreUser == null) {
        page--;
        data.copyWith(hasReachedMax: true);
        yield RepoDataError(message: 'Limit Akses Request');
      } else {
        repo.item.addAll(moreUser.item);
        yield RepoDataLoaded(repo: repo, hasReachedMax: false);
      }
    }
    if (event is ClearRepo) {
      repo.item.clear();
      yield RepoDataClear(message: 't');
    }
  }
}
