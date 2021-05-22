import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const routeChoosePlayers = "choosePlayers";

class ChoosePlayersPage extends StatelessWidget {
  const ChoosePlayersPage({
    Key? key,
    required this.onPlayersChosen,
  }) : super(key: key);

  final Function onPlayersChosen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text("ChoosePlayersPage")),
          ElevatedButton(
            onPressed: () {
              onPlayersChosen();
            },
            child: Text("Next"),
          ),
        ],
      ),
    );
  }
}
