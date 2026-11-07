import 'package:flutter/material.dart';

/// One class meeting in the weekly schedule.
class ClassSession {
  const ClassSession({
    required this.subject,
    required this.time,
    required this.instructor,
    required this.room,
    required this.color,
  });

  final String subject;
  final String time;
  final String instructor;
  final String room;
  final Color color;
}
