part of 'repo_data_bloc.dart';

@immutable
abstract class RepoDataState {}

class RepoDataUnintialized extends RepoDataState {}

class RepoDataLoaded extends RepoDataState {
  final RepoResults repo;
  final bool hasReachedMax;
  RepoDataLoaded({this.repo, this.hasReachedMax});

  RepoDataLoaded copyWith({RepoResults repo, bool hasReachedMax}) {
    return RepoDataLoaded(
      repo: repo ?? this.repo,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax
    );
  }
}

class RepoDataError extends RepoDataState {
  final String message;
  RepoDataError({this.message});
}

class RepoDataClear extends RepoDataState {
  final String message;
  RepoDataClear({this.message});
}
