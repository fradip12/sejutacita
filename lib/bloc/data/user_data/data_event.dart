part of 'data_bloc.dart';

@immutable
class DataEvent {}

class FetchData extends DataEvent {
  final String keywords;
  final int page;
  FetchData({this.keywords,this.page});
}

class MoreData extends DataEvent {
  final String keywords;
  MoreData({this.keywords});
}

class ClearData extends DataEvent {}
