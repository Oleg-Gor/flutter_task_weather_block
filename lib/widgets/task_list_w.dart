import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:weather_tasks_app/model/task_item.dart';
import 'package:weather_tasks_app/providers/task_providers.dart';
import 'package:weather_tasks_app/screens/task_description.dart';

class TaskListW extends ConsumerStatefulWidget {
  const TaskListW({super.key});

  @override
  ConsumerState<TaskListW> createState() {
    return _TaskListWState();
  }
}

class _TaskListWState extends ConsumerState<TaskListW> {
  @override
  Widget build(BuildContext context) {
    final taskList = ref.watch(filteredProvider);

    final onRemoveTask = ref.read(taskProvider.notifier).onRemoveTask;
    final onAddTask = ref.read(taskProvider.notifier).onAddTask;

    void removeTask(TaskItem task) {
      onRemoveTask(task);

      ScaffoldMessenger.of(context).clearSnackBars();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          content: const Text('Task deleted.'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () => onAddTask(task),
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(taskList[index]),
            onDismissed: (dis) => removeTask(taskList[index]),
            background: Container(
              color: Theme.of(context).colorScheme.error.withOpacity(0.1),
            ),
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => TaskDescription(task: taskList[index]),
                ));
              },
              leading: Icon(categoryIcons[taskList[index].category]),
              title: Text(taskList[index].title),
              subtitle: Text(
                taskList[index].description,
                maxLines: 1,
              ),
              trailing: taskList[index].isActive
                  ? const Icon(Icons.visibility)
                  : null,
            ),
          );
        },
      ),
    );
  }
}
