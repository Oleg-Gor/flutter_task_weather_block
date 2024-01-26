import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:weather_tasks_app/model/convert_item.dart';
import 'package:weather_tasks_app/providers/task_filter_providers.dart';

class FilterTaskPanel extends ConsumerStatefulWidget {
  const FilterTaskPanel({super.key});

  @override
  ConsumerState<FilterTaskPanel> createState() {
    return _FilterTaskPanelState();
  }
}

class _FilterTaskPanelState extends ConsumerState<FilterTaskPanel> {
  @override
  Widget build(BuildContext context) {
    final selectedCategory = ref.watch(taskCategoryFilterProvider);
    final onChangeCategory =
        ref.read(taskCategoryFilterProvider.notifier).setCategory;

    final selectedTaskStatus = ref.watch(taskStatusFilterProvider);
    final onChangeStatus =
        ref.read(taskStatusFilterProvider.notifier).setStatus;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: DropdownButton(
              dropdownColor: Theme.of(context).colorScheme.background,
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                onChangeCategory(value);
              },
              value: selectedCategory,
              items: ExtendedCategory.values
                  .map(
                    (category) => DropdownMenuItem(
                      value: category,
                      child: Text(
                        category.statusText,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(
            width: 32,
          ),
          Expanded(
            child: DropdownButton(
              dropdownColor: Theme.of(context).colorScheme.background,
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                onChangeStatus(value);
              },
              value: selectedTaskStatus,
              items: TaskStatus.values
                  .map(
                    (status) => DropdownMenuItem(
                      value: status,
                      child: Text(
                        status.statusText,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
