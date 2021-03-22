part of 'chooser_bloc.dart';

@immutable
abstract class ChooserEvent {}

class Index extends ChooserEvent{
}
class Lazy extends ChooserEvent{
}
