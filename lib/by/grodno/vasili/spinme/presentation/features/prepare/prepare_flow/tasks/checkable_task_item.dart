import 'package:domain/domain_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/prepare_flow/tasks/task_menu.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/utilities/utilities.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/widgets/text_dialog.dart';

/// [Task] row item which can edited/checked/deleted.
class CheckableTaskItem extends StatefulWidget {
  const CheckableTaskItem({
    Key? key,
    required this.task,
    required this.onCheck,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  final Task task;
  final Function(bool) onCheck;
  final Function(String) onEdit;
  final Function() onDelete;

  @override
  _CheckableTaskItemState createState() => _CheckableTaskItemState();
}

class _CheckableTaskItemState extends State<CheckableTaskItem> {
  late bool isChecked;
  late TaskMenu menu;

  @override
  void initState() {
    menu = TaskMenu(context);
    isChecked = widget.task.isChecked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.task.description),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
        widget.onCheck(value!);
      },
      secondary: PopupMenuButton<String>(
        onSelected: _onMenuSelected,
        itemBuilder: (BuildContext context) {
          return {menu.editKey, menu.deleteKey}.map((String key) {
            return PopupMenuItem<String>(
              value: key,
              child: Text(menu.getText(key)),
            );
          }).toList();
        },
      ),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  Future<void> _onMenuSelected(String value) async {
    if (value == menu.editKey) {
      final newText = await _edit(context, widget.task.description);
      if (newText == null) return;
      widget.onEdit(newText);
    } else if (value == menu.deleteKey) {
      widget.onDelete();
    }
  }

  Future<String?> _edit(BuildContext context, String description) async {
    return await showDialog<String?>(
      context: context,
      builder: (context) => TextDialog(
        context: context,
        initText: description,
        titleLabel: context.getLocalizedString("prepare_tasks_add_task"),
        okLabel: context.getLocalizedString("app_ok"),
        cancelLabel: context.getLocalizedString("app_cancel"),
      ),
    );
  }
}
