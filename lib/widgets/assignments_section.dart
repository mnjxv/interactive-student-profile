import 'package:flutter/material.dart';

import '../app_state.dart';
import '../models/assignment.dart';
import 'section_header.dart';
import 'text_prompt_dialog.dart';

/// Assignment list: add, check off, and swipe left to delete (with undo).
class AssignmentsSection extends StatelessWidget {
  const AssignmentsSection({super.key});

  Future<void> _addAssignment(BuildContext context, AppState state) async {
    final title = await showTextPrompt(
      context,
      title: 'New assignment',
      hint: 'What is it called?',
    );
    if (title != null) state.addAssignment(title);
  }

  void _removeAssignment(
    BuildContext context,
    AppState state,
    Assignment assignment,
  ) {
    final index = state.removeAssignment(assignment);
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text('Deleted "${assignment.title}"'),
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () => state.restoreAssignment(index, assignment),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final colors = Theme.of(context).colorScheme;
    final assignments = state.assignments;
    final total = assignments.length;
    final done = state.completedCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: 'Assignments',
          trailing: IconButton.filled(
            tooltip: 'Add assignment',
            icon: const Icon(Icons.add),
            onPressed: () => _addAssignment(context, state),
          ),
        ),
        if (total > 0) ...[
          Text(
            '$done of $total completed',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(value: done / total, minHeight: 8),
          ),
          const SizedBox(height: 8),
        ],
        if (total == 0)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Text(
              'No assignments yet.\nTap + to add one.',
              textAlign: TextAlign.center,
              style: TextStyle(color: colors.onSurfaceVariant),
            ),
          ),
        for (final assignment in assignments)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Dismissible(
              key: ValueKey(assignment.id),
              direction: DismissDirection.endToStart,
              onDismissed: (_) => _removeAssignment(context, state, assignment),
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 24),
                decoration: BoxDecoration(
                  color: colors.errorContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.delete_outline,
                  color: colors.onErrorContainer,
                ),
              ),
              child: Card(
                margin: EdgeInsets.zero,
                child: CheckboxListTile(
                  value: assignment.isDone,
                  onChanged: (_) => state.toggleAssignment(assignment.id),
                  activeColor: Colors.green,
                  title: Text(
                    assignment.title,
                    style: TextStyle(
                      decoration: assignment.isDone
                          ? TextDecoration.lineThrough
                          : null,
                      color: assignment.isDone ? colors.onSurfaceVariant : null,
                    ),
                  ),
                  secondary: Icon(
                    assignment.isDone
                        ? Icons.check_circle
                        : Icons.assignment_outlined,
                    color: assignment.isDone ? Colors.green : colors.primary,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
