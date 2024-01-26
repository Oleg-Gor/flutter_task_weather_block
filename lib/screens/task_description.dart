import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:weather_tasks_app/model/task_item.dart';
import 'package:weather_tasks_app/providers/task_providers.dart';

class TaskDescription extends ConsumerStatefulWidget {
  final TaskItem task;
  const TaskDescription({super.key, required this.task});

  @override
  ConsumerState<TaskDescription> createState() => _TaskDescriptionState();
}

class _TaskDescriptionState extends ConsumerState<TaskDescription> {
  @override
  Widget build(BuildContext context) {
    final task =
        ref.watch(taskProvider).firstWhere((el) => el.id == widget.task.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Title description'),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                'Description: ${task.description}',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              Text(
                'Was created at: ${task.formattedDate}',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              SwitchListTile(
                onChanged: (value) {
                  ref
                      .read(taskProvider.notifier)
                      .onSwitchTaskStatus(widget.task);
                },
                value: task.isActive,
                title: task.isActive
                    ? const Text('Still active')
                    : const Text('Is Done'),
              ),
            ],
          )),
    );
  }
}
