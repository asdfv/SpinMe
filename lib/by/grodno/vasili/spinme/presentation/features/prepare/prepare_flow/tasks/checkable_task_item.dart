import 'package:domain/domain_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/widgets/text_dialog.dart';

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
  static const String EDIT_MENU = "Edit";
  static const String DELETE_MENU = "Delete";

  @override
  void initState() {
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
          return {EDIT_MENU, DELETE_MENU}.map((String choice) {
            return PopupMenuItem<String>(
              value: choice,
              child: Text(choice),
            );
          }).toList();
        },
      ),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  Future<void> _onMenuSelected(String value) async {
    switch (value) {
      case EDIT_MENU:
        final newText = await _edit(context, widget.task.description);
        if (newText == null) return;
        widget.onEdit(newText);
        break;
      case DELETE_MENU:
        widget.onDelete();
        break;
    }
  }

  Future<String?> _edit(BuildContext context, String description) async {
    return await showDialog<String?>(
      context: context,
      builder: (context) => TextDialog(
        context: context,
        initText: description,
        titleLabel: "Edit task",
        okLabel: "OK",
        cancelLabel: "CANCEL",
      ),
    );
  }
}
