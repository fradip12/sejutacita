part of 'repo_data_bloc.dart';

@immutable
abstract class RepoDataEvent {}

class FetchRepo extends RepoDataEvent {
  final String keywords;
  FetchRepo({this.keywords});
}

class MoreRepo extends RepoDataEvent {
  final String keywords;
  MoreRepo({this.keywords});
}

class ClearRepo extends RepoDataEvent {}
