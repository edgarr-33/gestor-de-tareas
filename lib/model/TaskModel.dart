class Task {
  late final String title;
  late final int is_completed;
  late final String due_date;
  late final String description;
  late final String comments;

  Task(
      {required this.title,
      required this.is_completed,
      required this.due_date,
      required this.description,
      required this.comments}) {
    throw UnimplementedError();
  }

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        title: json['title'],
        is_completed: json['is_completed'],
        due_date: json['due_date'],
        description: json['description'],
        comments: json['comments'],
      );
}
