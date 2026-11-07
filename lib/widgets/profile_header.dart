import 'package:flutter/material.dart';

import '../app_state.dart';
import 'brand_gradient.dart';

/// The gradient card with the student's avatar, name, section and year.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, this.large = false});

  /// A bigger, centered layout used on the Profile tab.
  final bool large;

  @override
  Widget build(BuildContext context) {
    final profile = AppScope.of(context).profile;
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final avatar = CircleAvatar(
      radius: large ? 48 : 32,
      backgroundColor: colors.onPrimary,
      child: Text(
        profile.initials,
        style: TextStyle(
          fontSize: large ? 32 : 22,
          fontWeight: FontWeight.bold,
          color: colors.primary,
        ),
      ),
    );

    final details = Column(
      crossAxisAlignment: large
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          profile.name,
          textAlign: large ? TextAlign.center : TextAlign.start,
          style: (large ? textTheme.headlineSmall : textTheme.titleMedium)
              ?.copyWith(fontWeight: FontWeight.bold, color: colors.onPrimary),
        ),
        const SizedBox(height: 4),
        Text(
          'Section: ${profile.section}',
          style: TextStyle(color: colors.onPrimary),
        ),
        Text(
          'Year Level: ${profile.yearLevel}',
          style: TextStyle(color: colors.onPrimary),
        ),
      ],
    );

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(large ? 24 : 16),
        decoration: BoxDecoration(gradient: brandGradient(colors)),
        child: large
            ? Column(children: [avatar, const SizedBox(height: 16), details])
            : Row(
                children: [
                  avatar,
                  const SizedBox(width: 16),
                  Expanded(child: details),
                ],
              ),
      ),
    );
  }
}
