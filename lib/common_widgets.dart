import 'package:flutter/material.dart';

import 'app_color.dart';
import 'assignment.dart';

class AssignmentCard extends StatelessWidget {
  final Assignment assignment;
  final VoidCallback onTap;

  const AssignmentCard({super.key, required this.assignment, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    Color statusColor;
    String statusText;
    if (assignment.isClosed) {
      statusColor = AppColors.grey;
      statusText = 'Closed';
    } else if (assignment.isSubmitted) {
      statusColor = AppColors.green;
      statusText = 'Submitted';
    } else {
      statusColor = AppColors.red;
      statusText = 'Pending';
    }

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: screenWidth * 0.04),
      child: ListTile(
        onTap: onTap,
        title: Text(assignment.title, style: TextStyle(fontSize: 18)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(assignment.subject, style: TextStyle(fontSize: 14, color: AppColors.grey)),
            Text('Due: ${assignment.dueDateString}', style: TextStyle(fontSize: 12)),
          ],
        ),
        trailing: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: statusColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(statusText, style: TextStyle(color: AppColors.white, fontSize: 12)),
        ),
      ),
    );
  }
}

class CountdownWidget extends StatelessWidget {
  final DateTime dueDate;

  const CountdownWidget({super.key, required this.dueDate});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(Duration(seconds: 1), (_) => DateTime.now()),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return SizedBox.shrink();
        final now = snapshot.data as DateTime;
        final timeLeft = dueDate.difference(now);
        final days = timeLeft.inDays > 0 ? timeLeft.inDays : 0;
        final hours = timeLeft.inHours.remainder(24);
        final minutes = timeLeft.inMinutes.remainder(60);
        final seconds = timeLeft.inSeconds.remainder(60);

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _CountdownBox(value: days, label: 'Days'),
            _CountdownBox(value: hours, label: 'Hours'),
            _CountdownBox(value: minutes, label: 'Minutes'),
            _CountdownBox(value: seconds, label: 'Seconds'),
          ],
        );
      },
    );
  }
}

class _CountdownBox extends StatelessWidget {
  final int value;
  final String label;

  const _CountdownBox({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.lightGrey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value.toString().padLeft(2, '0'),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}