part of 'data_bloc.dart';

@immutable
abstract class DataState {}

class DataUnintialized extends DataState {}

class DataLoaded extends DataState {
  final UserResults user;
  final bool hasReachedMax;
  DataLoaded({this.user,this.hasReachedMax});

  DataLoaded copyWith({UserResults user, bool hasReachedMax}) {
    return DataLoaded(
      user: user ?? this.user,
    );
  }
}
class DataError extends DataState {
  final String message;
  DataError({this.message});
}
class DataClear extends DataState {
  final String message;
  DataClear({this.message});
}
