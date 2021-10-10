import 'package:flutter/material.dart';

/// UI picker containing buttons that allow to select just one option by clicking on button.
/// [MultipleOption] represents settings for the widget.
class MultipleOptionsPickerWidget extends StatefulWidget {
  final List<MultipleOption> options;

  const MultipleOptionsPickerWidget(this.options);

  @override
  State<MultipleOptionsPickerWidget> createState() => _MultipleOptionsPickerWidgetState();
}

class _MultipleOptionsPickerWidgetState extends State<MultipleOptionsPickerWidget> {
  late int _activeIndex;

  @override
  void initState() {
    _activeIndex = widget.options.indexWhere((element) => element.isActive);
    super.initState();
  }

  _onTap(int optionIndex) {
    widget.options[optionIndex].handler();
    setState(() {
      _activeIndex = optionIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _toButtons(widget.options)
          .map((button) => Expanded(
                  child: Container(
                child: button,
                margin: const EdgeInsets.all(8.0),
              )))
          .toList(),
    );
  }

  List<ElevatedButton> _toButtons(List<MultipleOption> options) {
    return options
        .asMap()
        .map((index, option) {
          final onPressed = index == _activeIndex ? null : () => _onTap(index);
          return MapEntry(index, ElevatedButton(onPressed: onPressed, child: Text(option.label)));
        })
        .values
        .toList();
  }
}

/// Data class represents model to apply on [MultipleOptionsPickerWidget].
/// [handler] - is triggered when the option is tapped.
/// [label] - label for the appropriate button.
/// [isActive] - whether the option-button button should be chosen already. Can be only one [isActive] item.
class MultipleOption {
  final Function() handler;
  final String label;
  final bool isActive;

  MultipleOption({required this.handler, this.label = "", this.isActive = false});
}
