import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  Task(this.title, {this.done = false, this.taskDetail});

  String title;
  bool done;
  TaskDetail? taskDetail;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}

@JsonSerializable()
class TaskDetail {
  TaskDetail({this.subtitle = '', this.description = ''});

  String subtitle;
  String description;

  factory TaskDetail.fromJson(Map<String, dynamic> json) =>
      _$TaskDetailFromJson(json);

  Map<String, dynamic> toJson() => _$TaskDetailToJson(this);
}
