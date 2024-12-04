part of 'nav_bloc.dart';

@immutable
sealed class NavEvent {}

class ChangePage extends NavEvent {
  ChangePage({required this.index});
  final int index;
}
