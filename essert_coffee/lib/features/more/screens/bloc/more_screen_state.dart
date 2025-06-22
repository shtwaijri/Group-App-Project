part of 'more_screen_bloc.dart';

@immutable
sealed class MoreScreenState {}

final class MoreScreenInitial extends MoreScreenState {}

class LoginSiginUpOnSignalState extends MoreScreenState {}

class LogOutState extends MoreScreenState {}

class DeleteuserState extends MoreScreenState {}

class InitState extends MoreScreenState {}

class SelesctionCounteryState extends MoreScreenState {}

final class ChooseGenderState extends MoreScreenState {
  final String gender;

  ChooseGenderState({required this.gender});
}
