import 'package:data/data_module.dart';
import 'package:domain/domain_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/prepare_page.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/welcome/game_mode_picker_widget.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/main.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/utilities/utilities.dart';

import 'language_picker_widget.dart';

const routeWelcome = "/";

/// The very first page with an invitation to play.
class WelcomePage extends StatelessWidget {
  final Settings _settings = getIt<Settings>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              context.getLocalizedString('welcome_title'),
              key: const ValueKey('welcome_title'),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            LanguagePickerWidget(),
            GameModePickerWidget(_settings),
            ElevatedButton(
                key: const ValueKey('lets_go_button'),
                onPressed: () {
                  Navigator.pushNamed(context, routePreparePageFirstPage);
                  Locale locale = Localizations.localeOf(context);
                  initDefaultTasksIfNeeded(locale.languageCode);
                },
                child: Text(context.getLocalizedString('welcome_lets_go'))),
          ],
        ),
      ),
    );
  }
}
