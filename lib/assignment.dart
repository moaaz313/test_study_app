import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Assignment extends Equatable {
  final String id;
  final String title;
  final String subject;
  final String description;
  final String dueDateString;
  late DateTime dueDate;
  bool isSubmitted;
  bool isClosed;
  List<String> uploadedFiles;

  Assignment({
    required this.id,
    required this.title,
    required this.subject,
    required this.description,
    required this.dueDateString,
    this.isSubmitted = false,
    this.isClosed = false,
    List<String>? uploadedFiles,
  }): uploadedFiles = uploadedFiles ?? []  {
    dueDate = _parseDueDate(dueDateString);
    isClosed = dueDate.isBefore(DateTime.now());
  }

  DateTime _parseDueDate(String dateStr) {
    final format = DateFormat('MMM dd, hh:mm a');
    final parsed = format.parse(dateStr);
    final now = DateTime.now();
    return DateTime(
      now.year,
      parsed.month,
      parsed.day,
      parsed.hour,
      parsed.minute,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'subject': subject,
    'description': description,
    'dueDateString': dueDateString,
    'isSubmitted': isSubmitted,
    'isClosed': isClosed,
    'uploadedFiles': uploadedFiles,
  };

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      id: json['id'],
      title: json['title'],
      subject: json['subject'],
      description: json['description'],
      dueDateString: json['dueDateString'],
      isSubmitted: json['isSubmitted'] ?? false,
      isClosed: json['isClosed'] ?? false,
      uploadedFiles: List<String>.from(json['uploadedFiles'] ?? []),
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    subject,
    description,
    dueDate,
    isSubmitted,
    isClosed,
    uploadedFiles,
  ];
}
