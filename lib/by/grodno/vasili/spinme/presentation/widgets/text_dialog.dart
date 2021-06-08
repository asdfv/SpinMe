import 'package:flutter/material.dart';

class TextDialog extends AlertDialog {
  final BuildContext context;
  final String initText;
  final String titleLabel;
  final String okLabel;
  final String cancelLabel;

  TextDialog({
    required this.context,
    this.initText = "",
    required this.titleLabel,
    required this.okLabel,
    required this.cancelLabel,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: initText);
    return AlertDialog(
      title: Text(titleLabel),
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
            child: Text(cancelLabel),
            onPressed: () {
              Navigator.of(context).pop(null);
            }),
        ElevatedButton(
            child: Text(okLabel),
            onPressed: () {
              Navigator.of(context).pop(controller.value.text);
            })
      ],
    );
  }
}
