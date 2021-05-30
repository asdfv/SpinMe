import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'names_form_widget.dart';

const routeChoosePlayers = "choosePlayers";

class ChoosePlayersPage extends StatelessWidget {
  const ChoosePlayersPage({
    Key? key,
    required this.onPlayersChosen,
  }) : super(key: key);

  final Function(List<String>) onPlayersChosen;

  @override
  Widget build(BuildContext context) => NamesFormWidget(onPlayersChosen: onPlayersChosen);
}
