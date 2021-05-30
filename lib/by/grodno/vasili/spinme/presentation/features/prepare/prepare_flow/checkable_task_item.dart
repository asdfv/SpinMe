import 'package:domain/domain_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CheckableTaskItem extends StatefulWidget {
  const CheckableTaskItem({
    Key? key,
    required this.task,
    required this.isChecked,
    required this.onCheck,
  }) : super(key: key);

  final Task task;
  final bool isChecked;
  final Function(bool) onCheck;

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
    );
  }
}
