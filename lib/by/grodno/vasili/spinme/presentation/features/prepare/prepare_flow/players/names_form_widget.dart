import 'package:domain/domain_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/preferences/game_preferences.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/utilities/utilities.dart';

class NamesFormWidget extends StatefulWidget {
  const NamesFormWidget({
    Key? key,
    required this.onPlayersChosen,
    this.initialPlayers = const [],
  }) : super(key: key);

  final Function(List<String>) onPlayersChosen;
  final List<Player> initialPlayers;

  @override
  NamesFormWidgetState createState() => NamesFormWidgetState();
}

class NamesFormWidgetState extends State<NamesFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _names = [];
  Map<UniqueKey, TextFormField> _nameFields = {};

  @override
  void initState() {
    _initFields();
    super.initState();
  }

  void _initFields() {
    var initialPlayers = widget.initialPlayers;
    if (initialPlayers.length > GamePreferences.maxNumberOfPlayers) {
      initialPlayers = initialPlayers.sublist(0, GamePreferences.maxNumberOfPlayers - 1);
    }
    final numberToAdd = GamePreferences.minNumberOfPlayers - initialPlayers.length;
    widget.initialPlayers.forEach((element) {
      _addNameField(initText: element.name);
    });
    for (var index = 0; index < numberToAdd; index++) {
      _addNameField();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _nameFields.values.length,
              itemBuilder: (context, index) => _nameFields.values.toList()[index],
            ),
          ),
          _createPlusButton(),
          _createSubmitButton(context)
        ],
      ),
    );
  }

  Widget _createPlusButton() {
    final Function()? action = _nameFields.length >= GamePreferences.maxNumberOfPlayers ? null : _addNameField;
    return ElevatedButton(
      onPressed: action,
      child: Icon(Icons.add),
    );
  }

  Widget _createSubmitButton(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ElevatedButton(
          onPressed: () {
            _formKey.currentState!.save();
            final errorMessage = validate(_names);
            if (errorMessage == null) {
              widget.onPlayersChosen(List.from(_names));
            } else {
              context.snack(errorMessage);
            }
            _names.clear();
          },
          child: Text('Next'),
        ),
      );

  String? validate(List<String> names) {
    if (names._hasShortNames()) {
      return "All fields should be filled with names no shorter than ${GamePreferences.minCharactersInPlayerName} symbols.";
    } else if (names.length < GamePreferences.minNumberOfPlayers || names.length > GamePreferences.maxNumberOfPlayers) {
      return "To play needs from ${GamePreferences.minNumberOfPlayers} to ${GamePreferences.minNumberOfPlayers} players";
    } else if (names._hasDuplicates()) {
      return "All names should be different";
    } else {
      return null;
    }
  }

  void _addNameField({String? initText = ""}) {
    final key = UniqueKey();
    setState(() {
      _nameFields[key] = TextFormField(
        controller: TextEditingController(text: initText),
        onSaved: (value) {
          _names.add(value!);
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 20), // add padding to adjust text
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _nameFields.remove(key);
              });
            },
            child: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
          hintText: 'Enter player name',
        ),
        keyboardType: TextInputType.text,
      );
    });
  }
}

extension _HasShortNames on Iterable<String> {
  bool _hasShortNames() => this.any((name) => name.length < GamePreferences.minCharactersInPlayerName);
}

extension _HasDuplicates on Iterable<String> {
  bool _hasDuplicates() => this.length != this.toSet().length;
}
