
import 'assignment.dart';

class AssignmentsRepository {
  Future<List<Assignment>> fetchAssignments() async {
    await Future.delayed(Duration(seconds: 1));
    return [
      Assignment(
        id: '1',
        title: 'Homework 3 - Chapter 5',
        subject: 'Mathematics',
        description: 'Complete exercises 1-10',
        dueDateString: 'Aug 10, 11:59 PM', // Past date
      ),
      Assignment(
        id: '2',
        title: 'Quiz 2 - Sections 3.1-3.3',
        subject: 'Physics',
        description: 'Online quiz preparation',
        dueDateString: 'Aug 12, 11:59 PM', // Past date
      ),
      Assignment(
        id: '3',
        title: 'Lab Report - Experiment 2',
        subject: 'Chemistry',
        description: 'Submit lab findings',
        dueDateString: 'Oct 28, 11:59 PM',
      ),
      Assignment(
        id: '4',
        title: 'Homework 4 - Chapter 6',
        subject: 'Mathematics',
        description: 'Solve problems 11-20',
        dueDateString: 'Oct 29, 11:59 PM',
      ),
      Assignment(
        id: '5',
        title: 'Midterm Exam - Chapters 1-6',
        subject: 'History',
        description: 'Study for exam',
        dueDateString: 'Oct 30, 11:59 PM',
      ),
      Assignment(
        id: '6',
        title: 'Project Proposal',
        subject: 'Computer Science',
        description: 'Draft project proposal',
        dueDateString: 'Oct 31, 11:59 PM',
      ),
      Assignment(
        id: '7',
        title: 'Final Project - Phase 1',
        subject: 'Engineering',
        description: 'Complete initial phase',
        dueDateString: 'Nov 1, 11:59 PM',
      ),
      Assignment(
        id: '8',
        title: 'Essay on Sustainability',
        subject: 'Environmental Science',
        description: 'Essay on environmental impact',
        dueDateString: 'Nov 2, 11:59 PM',
      ),
    ];
  }

  Future<void> updateAssignmentStatus(String id, bool isSubmitted) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate API call
  }
}