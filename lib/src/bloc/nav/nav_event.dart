part of 'nav_bloc.dart';

@immutable
abstract class NavEvent {}

class GetScreen extends NavEvent{
  final String screen;
  GetScreen(this.screen);
}
