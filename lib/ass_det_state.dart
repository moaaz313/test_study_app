import 'package:equatable/equatable.dart';

import 'assignment.dart';

abstract class AssignmentDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AssignmentDetailsInitial extends AssignmentDetailsState {}

class AssignmentDetailsLoading extends AssignmentDetailsState {}

class AssignmentDetailsLoaded extends AssignmentDetailsState {
  final Assignment assignment;
  final String? message;
  final bool isSubmitting;

  AssignmentDetailsLoaded({
    required this.assignment,
    this.message,
    this.isSubmitting = false,
  });

  @override
  List<Object?> get props => [assignment, message, isSubmitting];
}

class AssignmentDetailsError extends AssignmentDetailsState {
  final String message;

  AssignmentDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}