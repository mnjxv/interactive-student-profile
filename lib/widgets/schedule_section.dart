import 'package:flutter/material.dart';

import '../app_state.dart';
import 'section_header.dart';

/// Weekly schedule with a day picker. Tap a class to see instructor and room.
class ScheduleSection extends StatefulWidget {
  const ScheduleSection({super.key});

  @override
  State<ScheduleSection> createState() => _ScheduleSectionState();
}

class _ScheduleSectionState extends State<ScheduleSection> {
  /// Starts on today's weekday (weekends fall back to Monday).
  late String _day = _todayOrMonday();

  static String _todayOrMonday() {
    final weekday = DateTime.now().weekday; // 1 = Monday ... 7 = Sunday
    final index = (weekday >= 1 && weekday <= AppState.days.length)
        ? weekday - 1
        : 0;
    return AppState.days[index];
  }

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final colors = Theme.of(context).colorScheme;
    final sessions = state.sessionsFor(_day);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: 'Schedule',
          trailing: Text(
            sessions.length == 1 ? '1 class' : '${sessions.length} classes',
            style: TextStyle(color: colors.onSurfaceVariant),
          ),
        ),
        SegmentedButton<String>(
          showSelectedIcon: false,
          segments: [
            for (final day in AppState.days)
              ButtonSegment<String>(
                value: day,
                label: Text(day.substring(0, 3)),
              ),
          ],
          selected: {_day},
          onSelectionChanged: (selection) =>
              setState(() => _day = selection.first),
        ),
        const SizedBox(height: 8),
        if (sessions.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Text(
              'No classes on $_day.',
              textAlign: TextAlign.center,
              style: TextStyle(color: colors.onSurfaceVariant),
            ),
          ),
        for (final session in sessions)
          Card(
            margin: const EdgeInsets.symmetric(vertical: 4),
            clipBehavior: Clip.antiAlias,
            child: ExpansionTile(
              shape: const Border(),
              collapsedShape: const Border(),
              leading: CircleAvatar(
                backgroundColor: session.color,
                child: const Icon(Icons.laptop, color: Colors.white, size: 20),
              ),
              title: Text(
                session.subject,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(session.time),
              children: [
                ListTile(
                  leading: const Icon(Icons.person, color: Colors.blueGrey),
                  title: Text(session.instructor),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.location_on,
                    color: Colors.redAccent,
                  ),
                  title: Text(session.room),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
