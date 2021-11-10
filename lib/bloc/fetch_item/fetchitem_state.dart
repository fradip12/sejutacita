part of 'fetchitem_bloc.dart';

abstract class FetchitemState extends Equatable {
  const FetchitemState();

  @override
  List<Object> get props => [];
}

class FetchitemInitial extends FetchitemState {}

class FetchitemLoaded extends FetchitemState {
  final List<ItemResult> data;

  FetchitemLoaded({this.data});
}
