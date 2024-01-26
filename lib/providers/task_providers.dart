import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:weather_tasks_app/model/convert_item.dart';

import 'package:weather_tasks_app/model/task_item.dart';
import 'package:weather_tasks_app/providers/task_filter_providers.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'tasks_3.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE tasks_list(id TEXT PRIMARY KEY, category TEXT, title TEXT, description TEXT, isActive TEXT, wasCreated INTEGER)');
    },
    version: 1,
  );

  return db;
}

class TaskList extends StateNotifier<List<TaskItem>> {
  TaskList() : super([]);

  Future<void> loadTasks() async {
    final db = await _getDatabase();
    final data = await db.query('tasks_list');

    final taskList = data.map(
      (row) {
        return TaskItem(
          id: row['id'] as String,
          title: row['title'] as String,
          category: ConvertItem(task: row).convertCategory,
          description: row['description'] as String,
          isActive: row['isActive'] == '1',
          wasCreated: DateTime.fromMillisecondsSinceEpoch(
              int.parse(row['wasCreated'].toString())),
        );
      },
    ).toList();

    state = taskList;
  }

  void onAddTask(TaskItem task) async {
    final db = await _getDatabase();
    db.insert(
      'tasks_list',
      {
        'id': task.id,
        'title': task.title,
        'category': task.category.name,
        'description': task.description,
        'isActive': task.isActive,
        'wasCreated': task.wasCreated.millisecondsSinceEpoch,
      },
    );

    state = [...state, task];
  }

  void onRemoveTask(
    TaskItem taskItem,
  ) async {
    final db = await _getDatabase();

    await db.delete(
      'tasks_list',
      where: 'id = ?',
      whereArgs: [taskItem.id],
    );

    state = [...state]..remove(taskItem);
  }

  void onSwitchTaskStatus(TaskItem taskItem) async {
    final db = await _getDatabase();

    await db.update(
      'tasks_list',
      {
        'isActive': taskItem.isActive ? '0' : '1',
      },
      where: 'id = ?',
      whereArgs: [taskItem.id],
    );

    state = state
        .map((task) => task.id == taskItem.id
            ? task.copyWith(isActive: !task.isActive)
            : task)
        .toList();
  }
}

final taskProvider =
    StateNotifierProvider<TaskList, List<TaskItem>>((ref) => TaskList());

final sortedTaskProvider = Provider((ref) {
  final tasks = ref.watch(taskProvider);

  final sortedTasks = List<TaskItem>.from(tasks);
  sortedTasks.sort((a, b) => b.wasCreated.compareTo(a.wasCreated));

  return sortedTasks;
});

final filteredProvider = Provider((ref) {
  final sortedTask = ref.watch(sortedTaskProvider);
  final taskStatus = ref.watch(taskStatusFilterProvider);
  final taskCategory = ref.watch(taskCategoryFilterProvider);

  return sortedTask.where((task) {
    final isActiveFilterCategory = task.category.name == taskCategory.name ||
        taskCategory.name == ExtendedCategory.all.name;
    final isActiveFilterStatus =
        (task.isActive && taskStatus == TaskStatus.active) ||
            (!task.isActive && taskStatus == TaskStatus.done) ||
            taskStatus.name == TaskStatus.all.name;

    if (isActiveFilterCategory && isActiveFilterStatus) {
      return true;
    }
    return false;
  }).toList();
});
