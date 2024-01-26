import 'package:flutter/material.dart';

import 'package:weather_tasks_app/model/convert_item.dart';
import 'package:weather_tasks_app/model/task_item.dart';

class NewItemScreen extends StatefulWidget {
  const NewItemScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  Category _selectedCategory = Category.creative;

  void addTask() {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Check your fields'),
                content: const Text('Fill in all the fields'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Ok',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.background,
                          ),
                    ),
                  )
                ],
              ));
      return;
    }

    Navigator.of(context).pop(
      TaskItem(
        category: _selectedCategory,
        title: _titleController.text,
        description: _descriptionController.text,
        isActive: true,
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Task'),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                maxLength: 40,
                controller: _titleController,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              TextField(
                maxLength: 200,
                minLines: 2,
                maxLines: 4,
                controller: _descriptionController,
                decoration: const InputDecoration(
                  label: Text('Descriptions'),
                ),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: DropdownButton(
                      dropdownColor: Theme.of(context).colorScheme.background,
                      onChanged: (value) {
                        setState(() {
                          if (value == null) {
                            return;
                          }
                          _selectedCategory = value;
                        });
                      },
                      value: _selectedCategory,
                      items: Category.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name.toUpperCase(),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        OutlinedButton(
                          onPressed: addTask,
                          child: const Text('Add task'),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
