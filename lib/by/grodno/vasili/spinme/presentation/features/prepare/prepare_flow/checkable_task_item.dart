import 'package:domain/domain_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CheckableTaskItem extends StatefulWidget {
  const CheckableTaskItem({
    Key? key,
    required this.task,
    required this.isChecked,
    required this.onCheck,
    required this.onEdit,
  }) : super(key: key);

  final Task task;
  final bool isChecked;
  final Function(bool) onCheck;
  final Function(String) onEdit;

  @override
  _CheckableTaskItemState createState() => _CheckableTaskItemState();
}

class _CheckableTaskItemState extends State<CheckableTaskItem> {
  late bool isChecked;

  @override
  void initState() {
    isChecked = widget.isChecked;
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
      secondary: IconButton(
        icon: Icon(Icons.edit),
        onPressed: () async {
          final newText = await _editTask(context, widget.task);
          if (newText == null) return;
          widget.onEdit(newText);
        },
      ),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  _editTask(BuildContext context, Task task) async {
    final controller = TextEditingController(text: task.description);
    final newText = await showDialog<String?>(
        context: context,
        builder: (dialogContext) => AlertDialog(
              title: Text("Edit task"),
              contentPadding: const EdgeInsets.all(16.0),
              content: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      maxLines: 6,
                      controller: controller,
                      autofocus: true,
                    ),
                  )
                ],
              ),
              actions: <Widget>[
                ElevatedButton(
                    child: const Text('CANCEL'),
                    onPressed: () {
                      Navigator.of(dialogContext).pop(null);
                    }),
                ElevatedButton(
                    child: const Text('SAVE'),
                    onPressed: () {
                      final newText = controller.value.text;
                      Navigator.of(dialogContext).pop(newText);
                    })
              ],
            ));
    return newText;
  }
}
