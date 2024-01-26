enum Category { work, personal, finance, creative }

enum ExtendedCategory { work, personal, finance, creative, all }

extension TaskCategoriesExtension on ExtendedCategory {
  String get statusText {
    switch (this) {
      case ExtendedCategory.work:
        return 'Work';
      case ExtendedCategory.personal:
        return 'Personal';
      case ExtendedCategory.finance:
        return 'Finance';
      case ExtendedCategory.creative:
        return 'Creative';
      case ExtendedCategory.all:
        return 'All categories';
      default:
        return '';
    }
  }
}

enum TaskStatus { active, done, all }

extension TaskStatusExtension on TaskStatus {
  String get statusText {
    switch (this) {
      case TaskStatus.active:
        return 'Active';
      case TaskStatus.done:
        return 'Done';
      case TaskStatus.all:
        return 'All statuses';
      default:
        return '';
    }
  }
}

class ConvertItem {
  final dynamic task;

  ConvertItem({required this.task});

  Category get convertCategory {
    Category category;

    switch (task['category']) {
      case "work":
        category = Category.work;
        break;
      case "personal":
        category = Category.personal;
        break;
      case "finance":
        category = Category.finance;
        break;
      case "creative":
        category = Category.creative;
        break;
      default:
        category = Category.work;
        break;
    }
    return category;
  }
}
