import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'package:weather_tasks_app/model/convert_item.dart';

const uuid = Uuid();

final dateFormated = DateFormat.yMd();

const categoryIcons = {
  Category.work: Icons.work_outline,
  Category.personal: Icons.person,
  Category.finance: Icons.monetization_on,
  Category.creative: Icons.pallet,
};

class TaskItem {
  final String id;
  final Category category;
  final String title;
  final String description;
  final bool isActive;
  final DateTime wasCreated;

  TaskItem({
    required this.category,
    required this.title,
    required this.description,
    required this.isActive,
    id,
    wasCreated,
  })  : id = id ?? uuid.v4(),
        wasCreated = wasCreated ?? DateTime.now();

  TaskItem copyWith(
      {int? id,
      String? title,
      String? description,
      Category? category,
      bool? isActive,
      DateTime? wasCreated}) {
    return TaskItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      isActive: isActive ?? this.isActive,
      wasCreated: wasCreated ?? this.wasCreated,
    );
  }

  String get formattedDate {
    return dateFormated.format(wasCreated);
  }
}
