part of 'branch_bloc.dart';

@immutable
sealed class BranchEvent {}

class LocationEvent extends BranchEvent {
  final String? markerId;

  LocationEvent(this.markerId);
}

class CurrentLocationEvent extends BranchEvent {}
