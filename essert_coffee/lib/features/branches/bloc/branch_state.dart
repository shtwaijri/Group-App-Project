part of 'branch_bloc.dart';

@immutable
sealed class BranchState {}

final class BranchInitial extends BranchState {}

final class SuccessState extends BranchState {}

final class ErrorState extends BranchState {
  final String message;
  ErrorState(this.message);
}

final class UpdateState extends BranchState {
  final String? selectedMarkerId;

  UpdateState(this.selectedMarkerId);
}
