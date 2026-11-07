import 'package:flutter/material.dart';

/// A school announcement shown in the carousel on the home tab.
class Announcement {
  const Announcement({
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;
}
