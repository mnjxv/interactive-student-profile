import 'package:flutter/material.dart';

import '../widgets/announcements_carousel.dart';
import '../widgets/assignments_section.dart';
import '../widgets/profile_header.dart';
import '../widgets/responsive_content.dart';
import '../widgets/schedule_section.dart';

/// The dashboard: profile card, assignments, schedule and announcements.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveContent(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ProfileHeader(),
          SizedBox(height: 20),
          AssignmentsSection(),
          SizedBox(height: 20),
          ScheduleSection(),
          SizedBox(height: 20),
          AnnouncementsCarousel(),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
