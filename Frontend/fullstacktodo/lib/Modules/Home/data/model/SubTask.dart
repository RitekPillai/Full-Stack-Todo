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
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['isComplete'] = this.isComplete;
    return data;
  }
}
