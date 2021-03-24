import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:citav2/core/models/issue/issue_model.dart';

import '../../../core/services/api.dart';

part 'issue_data_event.dart';
part 'issue_data_state.dart';

class IssueDataBloc extends Bloc<IssueDataEvent, IssueDataState> {
  IssueResults issue;
  int page = 0;
  IssueDataBloc() : super(IssueDataUnintialized());
  

  @override
  Stream<IssueDataState> mapEventToState(
    IssueDataEvent event,
  ) async* {
    if (event is FetchDataIssue) {
      issue = await Git.fetchIssue(event.keywords, event.page ?? 1, 10);
      issue.items.map((e) => print(e.id));
      yield IssueLoaded(issue: issue, hasReachedMax: false);
    }
    if (event is MoreDataIssue) {
      IssueResults moreUser = await Git.fetchIssue(event.keywords, page++, 10);
      IssueLoaded data = state as IssueLoaded;
      if (moreUser == null) {
        page--;
        data.copyWith(hasReachedMax: true);
      } else {
        issue.items.addAll(moreUser.items);
        yield IssueLoaded(issue: issue, hasReachedMax: false);
      }
    }
    if (event is ClearDataIssue) {
      issue.items.clear();
      yield IssueDataClear(message: 't');
    }
  }
}
