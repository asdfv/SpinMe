import 'package:flutter/material.dart';

/// Multiline [AlertDialog] which returns the string
/// or null if user Cancel the dialog.
class TextDialog extends AlertDialog {
  final BuildContext context;
  final String initText;
  final String titleLabel;
  final String okLabel;
  final String cancelLabel;

  const TextDialog({
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
              key: ValueKey("text_dialog_text_field"),
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
            key: ValueKey("text_dialog_ok_button"),
            child: Text(okLabel),
            onPressed: () {
              Navigator.of(context).pop(controller.value.text);
            })
      ],
    );
  }
}
