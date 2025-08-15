import 'dart:async';
import 'package:assignments/assignment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'all_ass_cubit.dart';
import 'ass_det_repo.dart';
import 'ass_det_state.dart';

class AssignmentDetailsCubit extends Cubit<AssignmentDetailsState> {
  final AssignmentDetailsRepository repository;
  final Assignment initialAssignment;
  final AssignmentsCubit assignmentsCubit;
  Timer? _timer;

  AssignmentDetailsCubit(this.repository, this.initialAssignment, this.assignmentsCubit)
      : super(AssignmentDetailsInitial()) {
    _startTimer();
    emit(AssignmentDetailsLoaded(assignment: initialAssignment));
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (state is AssignmentDetailsLoaded) {
        final loadedState = state as AssignmentDetailsLoaded;
        emit(AssignmentDetailsLoaded(assignment: loadedState.assignment));
      }
    });
  }

  Future<void> uploadFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.name != null) {
      final fileName = result.files.single.name!;
      if (state is AssignmentDetailsLoaded) {
        final loadedState = state as AssignmentDetailsLoaded;
        await repository.uploadFile(loadedState.assignment, fileName);
        emit(AssignmentDetailsLoaded(assignment: loadedState.assignment));
      }
    }
  }

  Future<void> submitAssignment() async {
    if (state is AssignmentDetailsLoaded) {
      final loadedState = state as AssignmentDetailsLoaded;
      final currentAssignment = loadedState.assignment;
      if (currentAssignment.uploadedFiles.isEmpty) {
        emit(AssignmentDetailsLoaded(assignment: currentAssignment, message: 'Please upload a file first'));
        return;
      }

      emit(AssignmentDetailsLoaded(assignment: currentAssignment, isSubmitting: true));
      try {
        await repository.submitAssignment(currentAssignment);
        assignmentsCubit.updateAssignment(currentAssignment); // Sync with main list
        emit(AssignmentDetailsLoaded(assignment: currentAssignment, message: 'Submitted successfully', isSubmitting: false));
      } catch (e) {
        emit(AssignmentDetailsLoaded(assignment: currentAssignment, message: 'Submission failed', isSubmitting: false));
      }
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}