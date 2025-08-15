import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'all_ass_cubit.dart';
import 'app_color.dart';
import 'ass_det_cubit.dart';
import 'ass_det_repo.dart';
import 'ass_det_state.dart';
import 'assignment.dart';
import 'common_widgets.dart';

class AssignmentDetailsScreen extends StatelessWidget {
  final Assignment assignment;

  const AssignmentDetailsScreen({super.key, required this.assignment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assignment Details', style: TextStyle(color: AppColors.black)),
        backgroundColor: AppColors.white,
      ),
      body: BlocBuilder<AssignmentDetailsCubit, AssignmentDetailsState>(
        builder: (context, state) {
          if (state is AssignmentDetailsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is AssignmentDetailsError) {
            return Center(child: Text(state.message));
          } else if (state is AssignmentDetailsLoaded) {
            final assignment = state.assignment;
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(assignment.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(assignment.subject, style: TextStyle(fontSize: 18, color: AppColors.grey)),
                  SizedBox(height: 16),
                  Text(assignment.description, style: TextStyle(fontSize: 16)),
                  SizedBox(height: 24),
                  Text('Deadline', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  CountdownWidget(dueDate: assignment.dueDate),
                  SizedBox(height: 24),
                  if (!assignment.isSubmitted && !assignment.isClosed) ...[
                    ElevatedButton(
                      onPressed: () => context.read<AssignmentDetailsCubit>().uploadFile(),
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.blue, foregroundColor: AppColors.white),
                      child: Text('Upload File'),
                    ),
                    SizedBox(height: 16),
                    if (assignment.uploadedFiles.isNotEmpty)
                      ...assignment.uploadedFiles.map((file) => ListTile(
                        title: Text(file),
                        trailing: Icon(Icons.check, color: AppColors.green),
                      )),
                    SizedBox(height: 16),
                    if (state.isSubmitting)
                      Center(child: CircularProgressIndicator())
                    else
                      ElevatedButton(
                        onPressed: () => context.read<AssignmentDetailsCubit>().submitAssignment(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.blue,
                          foregroundColor: AppColors.white,
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Text('Submit'),
                      ),
                  ],
                  if (state.message != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(state.message!, style: TextStyle(color: AppColors.red, fontSize: 16)),
                    ),
                ],
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}