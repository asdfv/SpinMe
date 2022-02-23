import 'package:flutter/material.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/colors/app_colors.dart';

/// UI picker containing buttons that allow to select just one option by clicking on button.
/// [MultipleOption] represents settings for the widget.
class MultipleOptionsPickerWidget extends StatefulWidget {
  final OptionsPickerViewData data;

  const MultipleOptionsPickerWidget(this.data);

  @override
  State<MultipleOptionsPickerWidget> createState() => _MultipleOptionsPickerWidgetState();
}

class _MultipleOptionsPickerWidgetState extends State<MultipleOptionsPickerWidget> {
  late int _activeIndex;

  @override
  void initState() {
    _activeIndex = widget.data.options.indexWhere((element) => element.isActive);
    super.initState();
  }

  _onTap(int optionIndex) {
    widget.data.options[optionIndex].handler();
    setState(() {
      _activeIndex = optionIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration:
          BoxDecoration(color: AppColors.PrimaryLight, borderRadius: BorderRadius.all(const Radius.circular(8))),
      child: Column(
        children: [
          Text(widget.data.title),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _createItems(widget.data.options)
                .map((button) => Expanded(
                        child: Container(
                      child: button,
                      margin: const EdgeInsets.all(8.0),
                    )))
                .toList(),
          ),
        ],
      ),
    );
  }

  List<Widget> _createItems(List<MultipleOption> options) {
    return options
        .asMap()
        .map((index, option) {
          final onPressed = index == _activeIndex ? null : () => _onTap(index);
          final itemWidget = _ItemWidget(
            label: option.label,
            description: option.description,
            onClick: onPressed,
          );
          return MapEntry(index, itemWidget);
        })
        .values
        .toList();
  }
}

class _ItemWidget extends StatelessWidget {
  const _ItemWidget({Key? key, this.label = "", this.description = "", this.onClick}) : super(key: key);

  final String label;
  final String description;
  final void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(onPressed: onClick, child: Text(label)),
        Text(description),
      ],
    );
  }
}

/// UI model for [MultipleOptionsPickerWidget].
class OptionsPickerViewData {
  OptionsPickerViewData({this.title = "", required this.options});

  final String title;
  final List<MultipleOption> options;
}

/// UI model for options in [MultipleOptionsPickerWidget].
///
/// [handler] - is triggered when the option is tapped.
/// [label] - label for the appropriate button.
/// [isActive] - whether the option-button button should be chosen already. Can be only one [isActive] item.
@immutable
class MultipleOption {
  MultipleOption({required this.handler, this.label = "", this.isActive = false, this.description = ""});

  final Function() handler;
  final String label;
  final bool isActive;
  final String description;
}
