import 'package:domain/domain_module.dart';
import 'package:flutter/material.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/welcome/multiple_options_picker_widget.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/utilities/utilities.dart';

class GameModePickerWidget extends StatelessWidget {
  final Settings _settings;

  const GameModePickerWidget(this._settings, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentMode = _settings.gameMode;
    final options = GameMode.values
        .map((mode) => MultipleOption(
            handler: () {
              _settings.gameMode = mode;
            },
            label: _getLabel(context, mode),
            isActive: mode == currentMode))
        .toList();
    return MultipleOptionsPickerWidget(options);
  }

  String _getLabel(BuildContext context, GameMode mode) {
    switch (mode) {
      case GameMode.tasksPerGame:
        return context.getLocalizedString("welcome_tasks_per_game_label");
      case GameMode.tasksPerPlayer:
        return context.getLocalizedString("welcome_tasks_per_user_label");
    }
  }
}
