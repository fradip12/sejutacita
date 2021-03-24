part of 'repo_data_bloc.dart';

@immutable
abstract class RepoDataEvent {}

class FetchRepo extends RepoDataEvent {
  final String keywords;
  final int page;
  FetchRepo({this.keywords, this.page});
}

class MoreRepo extends RepoDataEvent {
  final String keywords;
  MoreRepo({this.keywords});
}

class ClearRepo extends RepoDataEvent {}
