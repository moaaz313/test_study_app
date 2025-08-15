import 'package:equatable/equatable.dart';

import 'assignment.dart';

abstract class AssignmentsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AssignmentsInitial extends AssignmentsState {}

class AssignmentsLoading extends AssignmentsState {}

class AssignmentsLoaded extends AssignmentsState {
  final List<Assignment> assignments;
  final String activeTab;

  AssignmentsLoaded(this.assignments, this.activeTab);

  @override
  List<Object?> get props => [assignments, activeTab];
}

class AssignmentsError extends AssignmentsState {
  final String message;

  AssignmentsError(this.message);

  @override
  List<Object?> get props => [message];
}