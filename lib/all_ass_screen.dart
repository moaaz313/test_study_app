import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'all_ass_cubit.dart';
import 'all_ass_state.dart';
import 'app_color.dart';
import 'common_widgets.dart';

class AllAssignmentsScreen extends StatelessWidget {
  const AllAssignmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => context.go('/'),),
        title: Text(
          'All Assignments',
          style: TextStyle(color: AppColors.black),
        ),
        backgroundColor: AppColors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<AssignmentsCubit, AssignmentsState>(
              builder: (context, state) {
                if (state is AssignmentsLoaded) {
                  final cubit = context.read<AssignmentsCubit>();
                  final submittedCount = cubit.getSubmittedCount();
                  final total = cubit.allAssignments.length;
                  return SubmissionProgress(
                    submittedCount: submittedCount,
                    total: total,
                  );
                  //   Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       '$submittedCount/$total submitted',
                  //       style: TextStyle(
                  //         fontSize: 18,
                  //         fontWeight: FontWeight.bold,
                  //         color: AppColors.black,
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 150,
                  //       child: LinearProgressIndicator(
                  //         value: submittedCount / total,
                  //         backgroundColor: AppColors.lightGrey,
                  //         color: AppColors.blue,
                  //       ),
                  //     ),
                  //   ],
                  // );
                }
                return SizedBox.shrink();
              },
            ),
          ),
          DefaultTabController(
            length: 4,
            child: Column(
              children: [
                TabBar(
                  onTap: (index) {
                    final tabs = [
                      'All',
                      'Not Submitted',
                      'Submitted',
                      'Closed',
                    ];
                    context.read<AssignmentsCubit>().changeTab(tabs[index]);
                  },
                  tabs: [
                    Tab(text: 'All'),
                    Tab(text: 'Not Submitted'),
                    Tab(text: 'Submitted'),
                    Tab(text: 'Closed'),
                  ],
                  labelColor: AppColors.blue,
                  unselectedLabelColor: AppColors.grey,
                ),
                SizedBox(
                  height:
                      MediaQuery.of(context).size.height -
                      200,
                  child: BlocBuilder<AssignmentsCubit, AssignmentsState>(
                    builder: (context, state) {
                      if (state is AssignmentsLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is AssignmentsError) {
                        return Center(child: Text(state.message));
                      } else if (state is AssignmentsLoaded) {
                        final assignments = context
                            .read<AssignmentsCubit>()
                            .getFilteredAssignments();
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: assignments.length,
                          itemBuilder: (context, index) {
                            return AssignmentCard(
                              assignment: assignments[index],
                              onTap: () {
                                context.push(
                                  '/assignment-details/${assignments[index].id}',
                                );
                              },
                            );
                          },
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SubmissionProgress extends StatelessWidget {
  final int submittedCount;
  final int total;

  const SubmissionProgress({
    Key? key,
    required this.submittedCount,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double progress = total == 0 ? 0 : submittedCount / total;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Assignments Progress",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$submittedCount / $total submitted",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: progress),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOut,
                  builder: (context, value, _) => ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: value,
                      minHeight: 10,
                      backgroundColor: Colors.grey[200],
                      valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
