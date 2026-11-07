/// The student's personal details shown on the profile card.
class StudentProfile {
  const StudentProfile({
    required this.name,
    required this.section,
    required this.yearLevel,
  });

  final String name;
  final String section;
  final String yearLevel;

  /// Up to two initials, used inside the avatar.
  String get initials {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  StudentProfile copyWith({String? name, String? section, String? yearLevel}) {
    return StudentProfile(
      name: name ?? this.name,
      section: section ?? this.section,
      yearLevel: yearLevel ?? this.yearLevel,
    );
  }
}
