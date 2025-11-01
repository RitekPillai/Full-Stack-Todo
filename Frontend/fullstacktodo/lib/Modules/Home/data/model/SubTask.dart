class SubTasks {
  final String title;
  bool isComplete;

  SubTasks({required this.title, required this.isComplete});

  factory SubTasks.fromJson(Map<String, dynamic> json) {
    return SubTasks(
      title: json['title'] as String,
      isComplete: json['isComplete'] as bool,
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['isComplete'] = isComplete;
    return data;
  }
}
