import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:weather_tasks_app/providers/task_providers.dart';
import 'package:weather_tasks_app/screens/add_new_item_screen.dart';
import 'package:weather_tasks_app/widgets/drawer_w.dart';
import 'package:weather_tasks_app/widgets/filter_task_panel.dart';
import 'package:weather_tasks_app/widgets/task_list_w.dart';

class TaskListScreen extends ConsumerStatefulWidget {
  const TaskListScreen({super.key});

  @override
  ConsumerState<TaskListScreen> createState() {
    return _TaskListScreenState();
  }
}

class _TaskListScreenState extends ConsumerState<TaskListScreen> {
  @override
  initState() {
    super.initState();
    ref.read(taskProvider.notifier).loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    void addItem() async {
      final task =
          await Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
        return const NewItemScreen();
      }));
      if (task == null) {
        return;
      }

      ref.read(taskProvider.notifier).onAddTask(task);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          IconButton(
            onPressed: addItem,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: const DrawerW(),
      body: const Column(
        children: [
          FilterTaskPanel(),
          TaskListW(),
        ],
      ),
    );
  }
}
