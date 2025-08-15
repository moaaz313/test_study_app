import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'all_ass_cubit.dart';
import 'all_ass_screen.dart';
import 'ass_det_cubit.dart';
import 'ass_det_repo.dart';
import 'ass_det_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/all-assignments',
    routes: [
      GoRoute(
        path: '/all-assignments',
        builder: (context, state) => AllAssignmentsScreen(),
      ),
      GoRoute(
        path: '/assignment-details/:id',
        builder: (context, state) {
          final assignmentId = state.pathParameters['id']!;
          final assignmentsCubit = context.read<AssignmentsCubit>();
          final assignment = assignmentsCubit.allAssignments.firstWhere(
                (a) => a.id == assignmentId,
          );
          return BlocProvider(
            create: (_) => AssignmentDetailsCubit(
              AssignmentDetailsRepository(),
              assignment,
              assignmentsCubit,
            ),
            child: Builder(
              builder: (context) {
                return AssignmentDetailsScreen(
                  assignment: assignment,
                );
              },
            ),
          );
        },
      ),


    ],
  );
}
