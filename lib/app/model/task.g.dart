// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      json['title'] as String,
      done: json['done'] as bool? ?? false,
      taskDetail: json['taskDetail'] == null
          ? null
          : TaskDetail.fromJson(json['taskDetail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'title': instance.title,
      'done': instance.done,
      'taskDetail': instance.taskDetail,
    };

TaskDetail _$TaskDetailFromJson(Map<String, dynamic> json) => TaskDetail(
      subtitle: json['subtitle'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$TaskDetailToJson(TaskDetail instance) =>
    <String, dynamic>{
      'subtitle': instance.subtitle,
      'description': instance.description,
    };
