import 'package:data/data_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/prepare_page.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/welcome/bloc/welcome_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/welcome/bloc/welcome_event.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/welcome/bloc/welcome_state.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/welcome/game_mode_picker_widget.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/spin_me_app.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/utilities/utilities.dart';

import 'language_picker_widget.dart';

class WelcomeScaffold extends StatefulWidget {
  const WelcomeScaffold();

  @override
  State<WelcomeScaffold> createState() => _WelcomeScaffoldState();
}

class _WelcomeScaffoldState extends State<WelcomeScaffold> {
  late WelcomeBloc _bloc;

  @override
  void initState() {
    _bloc = context.read<WelcomeBloc>()..add(GameModeRequested());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WelcomeBloc, WelcomeState>(builder: (context, state) {
      return _buildScaffold(context, state);
    });
  }

  Widget _buildScaffold(BuildContext context, WelcomeState state) {
    final currentLanguage = SpinMeApp.of(context)?.getLanguage();
    // todo
    final language = state.language ?? currentLanguage!;
    final mode = state.mode;

    if (mode == null) return Scaffold();

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
            GameModePickerWidget(mode, (mode) {
              _bloc.add(ModeChosen(mode));
            }),
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
