part of 'issue_data_bloc.dart';

abstract class IssueDataEvent {}

class FetchDataIssue extends IssueDataEvent {
  final String keywords;
  final int page;
  FetchDataIssue({this.keywords, this.page});
}

class MoreDataIssue extends IssueDataEvent {
  final String keywords;
  MoreDataIssue({this.keywords});
}

class ClearDataIssue extends IssueDataEvent {}
