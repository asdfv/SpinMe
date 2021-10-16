import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/bloc/prepare_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/bloc/prepare_state.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/preferences/game_preferences.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/utilities/utilities.dart';

import 'names_form_widget.dart';

const routeChoosePlayers = "choosePlayers";

/// Page where the user can chose the names for players.
class ChoosePlayersPage extends StatelessWidget {
  const ChoosePlayersPage({
    Key? key,
    required this.onPlayersChosen,
  }) : super(key: key);

  final Function(List<String>) onPlayersChosen;

  @override
  Widget build(BuildContext context) => BlocBuilder<PrepareBloc, PrepareState>(
        builder: (context, state) {
          final players = state.players;
          final isLoading = state.isLoading;
          if (isLoading || players == null) return Center(child: CircularProgressIndicator());
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(context.getLocalizedString("prepare_players_specify_names", GameConstants.maxNumberOfPlayers)),
                const SizedBox(height: 24),
                Expanded(child: NamesFormWidget(initialPlayers: players, onPlayersChosen: onPlayersChosen)),
              ],
            ),
          );
        },
      );
}
