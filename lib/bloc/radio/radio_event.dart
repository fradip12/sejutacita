part of 'radio_bloc.dart';

@immutable
abstract class RadioEvent {}

class RepoEvent extends RadioEvent {}

class UserEvent extends RadioEvent {}

class IssueEvent extends RadioEvent {}
