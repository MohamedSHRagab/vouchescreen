// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTask _$UserAbleTaskFromJson(Map<String, dynamic> json) => UserTask(
      id: json['id'] as int?,
      active: json['active'] as bool?,
      description: json['description'] as String?,
      taskCode: json['taskCode'] as String?,
    );

Map<String, dynamic> _$UserAbleTaskToJson(UserTask instance) =>
    <String, dynamic>{
      'id': instance.id,
      'active': instance.active,
      'description': instance.description,
      'taskCode': instance.taskCode,
    };
