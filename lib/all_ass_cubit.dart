import 'package:flutter_bloc/flutter_bloc.dart';
import 'all_ass_repo.dart';
import 'all_ass_state.dart';
import 'assignment.dart';

class AssignmentsCubit extends Cubit<AssignmentsState> {
  final AssignmentsRepository repository;
  late List<Assignment> allAssignments;
  String activeTab = 'All';

  AssignmentsCubit(this.repository) : super(AssignmentsInitial()) {
    _loadAssignments();
  }

  Future<void> _loadAssignments() async {
    emit(AssignmentsLoading());
    try {
      allAssignments = await repository.fetchAssignments();
      emit(AssignmentsLoaded(allAssignments, activeTab));
    } catch (e) {
      emit(AssignmentsError(e.toString()));
    }
  }

  void changeTab(String tab) {
    activeTab = tab;
    emit(AssignmentsLoaded(allAssignments, activeTab));
  }

  List<Assignment> getFilteredAssignments() {
    switch (activeTab) {
      case 'Not Submitted':
        return allAssignments.where((a) => !a.isSubmitted && !a.isClosed).toList();
      case 'Submitted':
        return allAssignments.where((a) => a.isSubmitted).toList();
      case 'Closed':
        return allAssignments.where((a) => a.isClosed).toList();
      default:
        return allAssignments;
    }
  }

  int getSubmittedCount() {
    return allAssignments.where((a) => a.isSubmitted).length;
  }

  void updateAssignment(Assignment updatedAssignment) {
    allAssignments = allAssignments.map((a) => a.id == updatedAssignment.id ? updatedAssignment : a).toList();
    emit(AssignmentsLoaded(allAssignments, activeTab));
  }
}