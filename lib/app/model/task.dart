class Task {
  Task(this.title, {this.done = false});

  String title;
  bool done;

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      json['title'],
      done: json['done'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'done': done,
    };
  }
}
