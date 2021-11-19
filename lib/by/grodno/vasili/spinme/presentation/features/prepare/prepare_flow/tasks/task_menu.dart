import 'package:flutter/cupertino.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/utilities/utilities.dart';

/// Overflow menu for task item with Edit and Delete option.
class TaskMenu {
  TaskMenu(this.context);

  String editKey = "prepare_tasks_menu_edit_text";
  String deleteKey = "prepare_tasks_menu_delete_text";
  final BuildContext context;

  String getText(String key) {
    return context.getLocalizedString(key);
  }
}
