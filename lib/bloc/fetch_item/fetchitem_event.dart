part of 'fetchitem_bloc.dart';

abstract class FetchitemEvent extends Equatable {
  const FetchitemEvent();

  @override
  List<Object> get props => [];
}

class FetchDataHome extends FetchitemEvent {}
