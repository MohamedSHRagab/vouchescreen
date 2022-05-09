import 'dart:convert';

import 'package:voucher/screens%20/user_task.dart';

class UserTasksService {
  static UserTasksService? _userAbleTasksService;
  List<UserTask>? taskData = [];

  UserTasksService._() {
    generateTestData();
  }

  void generateTestData() {
    for (int i = 1; i < 100; i++) {
      taskData!.add(UserTask(
          id: i,
          taskCode: "$i - Task",
          description: "$i - Description",
          active: true));
    }
  }

  static UserTasksService? get instance {
    if (_userAbleTasksService == null) {
      _userAbleTasksService = UserTasksService._();
    }
    return _userAbleTasksService;
  }

  Future<List<UserTask>> getTasks(int offSet, int limit) async {
    return Future.value(taskData);
  }

  Future<UserTask> addTask(UserTask ableTask) async {
    taskData!.add(ableTask);
    return Future.value(ableTask);
  }

  Future<UserTask> updateTask(UserTask ableTask, int taskId) async {
    //Todo add your own Update logic
    return Future.value(ableTask);
  }

  Future<bool> deleteTask(int taskId) async {
    //Todo : add your own delete logic
    return Future.value(true);
  }
}
