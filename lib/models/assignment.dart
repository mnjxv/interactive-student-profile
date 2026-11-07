/// A single assignment the student has to finish.
class Assignment {
  const Assignment({
    required this.id,
    required this.title,
    this.isDone = false,
  });

  final int id;
  final String title;
  final bool isDone;

  Assignment copyWith({String? title, bool? isDone}) {
    return Assignment(
      id: id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }
}
