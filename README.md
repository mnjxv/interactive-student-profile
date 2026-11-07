# Interactive Student Profile

A student dashboard built with Flutter and Material 3. It has three tabs
(Home, Profile, Settings) and everything on them works.

## Features

**Home**
- Profile card with the student's initials, name, section and year level
- Assignments: add your own, check them off, swipe left to delete (with Undo), progress bar
- Weekly schedule: pick a day (starts on today), tap a class for instructor and room
- Announcements carousel with page dots; tap one to read the full message

**Profile**
- Larger profile card and quick stats (done, pending, classes per week)
- Edit name, section and year level (validated form)

**Settings**
- Light / dark mode (also available from the top bar)
- Accent color picker
- Reset assignments to the sample data
- About dialog

## Project structure

```
lib/
├── main.dart                  # App entry point and theme
├── app_state.dart             # App data + logic (ChangeNotifier) and AppScope
├── models/
│   ├── announcement.dart
│   ├── assignment.dart
│   ├── class_session.dart
│   └── student_profile.dart
├── screens/
│   ├── main_shell.dart        # App bar + bottom navigation
│   ├── home_screen.dart
│   ├── profile_screen.dart
│   └── settings_screen.dart
└── widgets/
    ├── announcements_carousel.dart
    ├── assignments_section.dart
    ├── brand_gradient.dart
    ├── profile_header.dart
    ├── schedule_section.dart
    ├── section_header.dart
    └── text_prompt_dialog.dart
```

No extra packages are needed, only Flutter itself.

## Getting started

1. Install [Flutter](https://docs.flutter.dev/get-started/install).
2. Clone this repository and run:
   ```bash
   flutter pub get
   flutter run
   ```

## Ideas for later

- Save assignments and settings between launches (`shared_preferences`)
- Edit existing assignments and add due dates
- Add or edit classes in the schedule

## License

MIT
