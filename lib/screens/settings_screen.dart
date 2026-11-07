import 'package:flutter/material.dart';

import '../app_state.dart';
import '../widgets/responsive_content.dart';
import '../widgets/section_header.dart';

/// Theme options, data reset and the About dialog.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _confirmReset(BuildContext context, AppState state) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset assignments?'),
        content: const Text(
          'This replaces your current list with the three sample assignments.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    state.resetAssignments();
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        const SnackBar(
          content: Text('Assignments reset'),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final colors = Theme.of(context).colorScheme;

    return ResponsiveContent(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionHeader(title: 'Appearance'),
          Card(
            margin: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SwitchListTile(
                  secondary: Icon(
                    state.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  ),
                  title: const Text('Dark mode'),
                  value: state.isDarkMode,
                  onChanged: state.setDarkMode,
                ),
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text(
                    'Accent color',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      for (final color in AppState.accentColors)
                        _ColorDot(
                          color: color,
                          selected: color == state.seedColor,
                          onTap: () => state.setSeedColor(color),
                          checkColor: colors.surface,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const SectionHeader(title: 'Data'),
          Card(
            margin: EdgeInsets.zero,
            child: ListTile(
              leading: const Icon(Icons.restart_alt),
              title: const Text('Reset assignments'),
              subtitle: const Text('Restore the sample assignments'),
              onTap: () => _confirmReset(context, state),
            ),
          ),
          const SizedBox(height: 20),
          const SectionHeader(title: 'About'),
          Card(
            margin: EdgeInsets.zero,
            child: ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Interactive Student Profile'),
              subtitle: const Text('Version 1.0.0'),
              onTap: () => showAboutDialog(
                context: context,
                applicationName: 'Interactive Student Profile',
                applicationVersion: '1.0.0',
                children: const [
                  Text(
                    'A student dashboard built with Flutter: profile, '
                    'assignments, weekly schedule and announcements.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ColorDot extends StatelessWidget {
  const _ColorDot({
    required this.color,
    required this.selected,
    required this.onTap,
    required this.checkColor,
  });

  final Color color;
  final bool selected;
  final VoidCallback onTap;
  final Color checkColor;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: 'Accent color',
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              color: selected
                  ? Theme.of(context).colorScheme.onSurface
                  : Colors.transparent,
              width: 3,
            ),
          ),
          child: selected ? Icon(Icons.check, color: checkColor) : null,
        ),
      ),
    );
  }
}
