part of 'paging_bloc.dart';

abstract class PagingEvent {}

class Next extends PagingEvent {}

class Back extends PagingEvent {}

class Reset extends PagingEvent {}
