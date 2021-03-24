part of 'issue_data_bloc.dart';

abstract class IssueDataState {}

class IssueDataUnintialized extends IssueDataState {}

class IssueLoaded extends IssueDataState {
  final IssueResults issue;
  final bool hasReachedMax;
  IssueLoaded({this.issue, this.hasReachedMax});

  IssueLoaded copyWith({IssueResults issue, bool hasReachedMax}) {
    return IssueLoaded(
      issue: issue ?? this.issue,
    );
  }
}

class IssueDataError extends IssueDataState {
  final String message;
  IssueDataError({this.message});
}

class IssueDataClear extends IssueDataState {
  final String message;
  IssueDataClear({this.message});
}
