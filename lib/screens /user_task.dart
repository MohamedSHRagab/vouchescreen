import 'package:json_annotation/json_annotation.dart';
part 'user_task.g.dart';

@JsonSerializable(explicitToJson: true)
class UserTask {
  int? id;
  bool? active;
  String? description;
  String? taskCode;

  UserTask({this.id, this.active, this.description, this.taskCode});

  factory UserTask.fromJson(Map<String, dynamic> json) =>
      _$UserAbleTaskFromJson(json);
  Map<String, dynamic> toJson() => _$UserAbleTaskToJson(this);

  @override
  String toString() {
    return '$taskCode';
  }
}
