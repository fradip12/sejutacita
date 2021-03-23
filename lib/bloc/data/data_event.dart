part of 'data_bloc.dart';

@immutable
class DataEvent {}

class FetchData extends DataEvent{
  final String keywords;
  FetchData({this.keywords});
}
class MoreData extends DataEvent{
  final String keywords;
  MoreData({this.keywords});
}
