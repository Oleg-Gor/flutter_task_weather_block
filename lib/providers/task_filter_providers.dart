import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_tasks_app/model/convert_item.dart';

class TaskCategoryFilterProvider extends StateNotifier<ExtendedCategory> {
  TaskCategoryFilterProvider() : super(ExtendedCategory.all);

  void setCategory(ExtendedCategory category) {
    state = category;
  }
}

final taskCategoryFilterProvider =
    StateNotifierProvider<TaskCategoryFilterProvider, ExtendedCategory>(
        (ref) => TaskCategoryFilterProvider());

class TaskStatusFilterProvider extends StateNotifier<TaskStatus> {
  TaskStatusFilterProvider() : super(TaskStatus.all);

  void setStatus(TaskStatus status) {
    state = status;
  }
}

final taskStatusFilterProvider =
    StateNotifierProvider<TaskStatusFilterProvider, TaskStatus>(
        (ref) => TaskStatusFilterProvider());
