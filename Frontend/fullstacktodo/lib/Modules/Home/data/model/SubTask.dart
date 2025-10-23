class SubTasks {
  final String title;
  final bool isComplete;

  SubTasks({required this.title, required this.isComplete});

  factory SubTasks.fromJson(Map<String, dynamic> json) {
    return SubTasks(
      title: json['title'] as String,
      isComplete: json['isComplete'] as bool,
    );
  }
}
