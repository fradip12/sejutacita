part of 'issue_data_bloc.dart';

abstract class IssueDataEvent {
 
}


class FetchDataIssue extends IssueDataEvent {
  final String keywords;
  FetchDataIssue({this.keywords});
}

class MoreDataIssue extends IssueDataEvent {
  final String keywords;
  MoreDataIssue({this.keywords});
}

class ClearDataIssue extends IssueDataEvent {}
