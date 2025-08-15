import 'assignment.dart';

class AssignmentDetailsRepository {
  Future<void> uploadFile(Assignment assignment, String fileName) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate API call
    assignment.uploadedFiles.add(fileName);
  }

  Future<void> submitAssignment(Assignment assignment) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate API call
    assignment.isSubmitted = true;
  }
}