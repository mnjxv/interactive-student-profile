import 'package:flutter/material.dart';

import 'models/announcement.dart';
import 'models/assignment.dart';
import 'models/class_session.dart';
import 'models/student_profile.dart';

/// Holds everything the app shows and changes: profile, assignments, theme.
///
/// Screens read it with [AppScope.of] and rebuild automatically whenever
/// [notifyListeners] is called.
class AppState extends ChangeNotifier {
  AppState() {
    resetAssignments(notify: false);
  }

  // ---------------------------------------------------------------- profile

  StudentProfile _profile = const StudentProfile(
    name: 'Juan Dela Cruz',
    section: 'BSIT',
    yearLevel: '3rd Year',
  );

  StudentProfile get profile => _profile;

  void updateProfile(StudentProfile profile) {
    _profile = profile;
    notifyListeners();
  }

  // ------------------------------------------------------------------ theme

  ThemeMode _themeMode = ThemeMode.light;
  Color _seedColor = Colors.blue;

  /// Accent colors the user can pick from on the settings tab.
  static const List<Color> accentColors = [
    Colors.blue,
    Colors.teal,
    Colors.green,
    Colors.orange,
    Colors.pink,
    Colors.deepPurple,
  ];

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  Color get seedColor => _seedColor;

  void setDarkMode(bool value) {
    _themeMode = value ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void toggleDarkMode() => setDarkMode(!isDarkMode);

  void setSeedColor(Color color) {
    _seedColor = color;
    notifyListeners();
  }

  // ------------------------------------------------------------ assignments

  final List<Assignment> _assignments = [];
  int _nextAssignmentId = 0;

  List<Assignment> get assignments => List.unmodifiable(_assignments);
  int get completedCount => _assignments.where((a) => a.isDone).length;
  int get pendingCount => _assignments.length - completedCount;

  void addAssignment(String title) {
    final text = title.trim();
    if (text.isEmpty) return;
    _assignments.add(Assignment(id: _nextAssignmentId++, title: text));
    notifyListeners();
  }

  void toggleAssignment(int id) {
    final index = _assignments.indexWhere((a) => a.id == id);
    if (index == -1) return;
    final current = _assignments[index];
    _assignments[index] = current.copyWith(isDone: !current.isDone);
    notifyListeners();
  }

  /// Removes [assignment] and returns the position it had, so the caller can
  /// pass it to [restoreAssignment] for an undo.
  int removeAssignment(Assignment assignment) {
    final index = _assignments.indexWhere((a) => a.id == assignment.id);
    if (index == -1) return 0;
    _assignments.removeAt(index);
    notifyListeners();
    return index;
  }

  void restoreAssignment(int index, Assignment assignment) {
    _assignments.insert(index.clamp(0, _assignments.length), assignment);
    notifyListeners();
  }

  /// Puts the three sample assignments back.
  void resetAssignments({bool notify = true}) {
    _assignments
      ..clear()
      ..addAll([
        Assignment(
          id: _nextAssignmentId++,
          title: 'Assignment 1',
          isDone: true,
        ),
        Assignment(id: _nextAssignmentId++, title: 'Assignment 2'),
        Assignment(
          id: _nextAssignmentId++,
          title: 'Assignment 3',
          isDone: true,
        ),
      ]);
    if (notify) notifyListeners();
  }

  // --------------------------------------------------------------- schedule

  static const List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  static const ClassSession _morningClass = ClassSession(
    subject: 'IT 306W - 3JG1',
    time: '10:00 AM - 1:00 PM',
    instructor: 'Mr. Adrian James de Jesus',
    room: 'Prog Lab 2',
    color: Colors.blue,
  );

  static const ClassSession _afternoonClass = ClassSession(
    subject: 'IT 306W - 3HG2',
    time: '2:00 PM - 5:00 PM',
    instructor: 'Mr. Adrian James de Jesus',
    room: 'Prog Lab 2',
    color: Colors.green,
  );

  static const ClassSession _eveningClass = ClassSession(
    subject: 'IT 306W - 3HG1',
    time: '5:00 PM - 8:00 PM',
    instructor: 'Mr. Adrian James de Jesus',
    room: 'Prog Lab 2',
    color: Colors.orange,
  );

  // Each day lists its classes in time order.
  static const Map<String, List<ClassSession>> _schedule = {
    'Monday': [_morningClass],
    'Tuesday': [_morningClass, _afternoonClass, _eveningClass],
    'Wednesday': [_morningClass],
    'Thursday': [_eveningClass],
    'Friday': [_afternoonClass],
  };

  List<ClassSession> sessionsFor(String day) => _schedule[day] ?? const [];

  int get classesPerWeek =>
      _schedule.values.fold(0, (total, list) => total + list.length);

  // ---------------------------------------------------------- announcements

  final List<Announcement> announcements = const [
    Announcement(
      icon: Icons.assignment,
      title: 'Activity 1',
      message:
          'Please submit your Student Dashboard activity before the deadline.',
    ),
    Announcement(
      icon: Icons.assignment,
      title: 'Activity 2',
      message:
          'Please submit your Interactive Student Profile activity before the deadline.',
    ),
    Announcement(
      icon: Icons.event,
      title: 'Midterm Exam Schedule',
      message:
          'Midterm exams will begin next week. Check your schedule for room assignments.',
    ),
  ];
}

/// Makes [AppState] available to every widget below it.
class AppScope extends InheritedNotifier<AppState> {
  const AppScope({super.key, required AppState state, required super.child})
    : super(notifier: state);

  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'No AppScope found above this context');
    return scope!.notifier!;
  }
}
