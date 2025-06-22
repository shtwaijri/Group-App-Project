part of 'more_screen_bloc.dart';

@immutable
sealed class MoreScreenEvent {}

class LoginSiginUpOnSignalEvent extends MoreScreenEvent {}

class LogOutEvent extends MoreScreenEvent {}

class DeleteUerEvent extends MoreScreenEvent {}

class InitEvent extends MoreScreenEvent {}

class SelesctionCounteryEvent extends MoreScreenEvent {
  final int country;

  SelesctionCounteryEvent({required this.country});
}

class ChooseGenderEvent extends MoreScreenEvent {
  final String gender;

  ChooseGenderEvent({required this.gender});
}
